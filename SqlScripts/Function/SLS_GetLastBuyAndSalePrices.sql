IF OBJECT_ID('SLS.GetLastBuyAndSalePrices') IS NOT NULL
	DROP FUNCTION SLS.GetLastBuyAndSalePrices
GO
CREATE FUNCTION SLS.GetLastBuyAndSalePrices(@ItemID int, @StockID int, @TracingID int, @CustomerPartyRef int)
Returns @result TABLE(
              RowID             INT, 
              PriceType			INT, 
			  [Order]           INT, 
			  Title             NVARCHAR(100), 
			  Fee               DECIMAL(19,4), 
			  FeeInStock        DECIMAL(19,4), 
			  TracingFee        DECIMAL(19,4), 
			  TracingFeeInStock DECIMAL(19,4),
              FeeDate               DATETIME, 
			  FeeInStockDate        DATETIME, 
			  TracingFeeDate        DATETIME, 
			  TracingFeeInStockDate DATETIME
			  )
AS
BEGIN


----------------------------------------------------------------------------------------------------------------------------------------
	IF @CustomerPartyRef <= 0 SET @CustomerPartyRef = NULL
	IF @StockID          <= 0 SET @StockID          = NULL
	IF @TracingID        <= 0 SET @TracingID        = NULL

	declare @isProduct int
	set @isProduct = -1

	select @isProduct = 1 
	from inv.Item 
			  Where ItemID = @itemId And [Type] = 1

----------------------------------------------------------------------------------------------------------------------------------------
	DECLARE @Tbl    TABLE(RowID             INT,
	                      IsSale            INT, 
						  CustomerPartyRef  INT,
						  TracingID         INT,
						  StockID           INT,
						  Fee               DECIMAL(19,4),
                          [Date]            DATETIME)

	INSERT INTO @Tbl (RowId , IsSale , CustomerPartyRef , TracingID , StockID)
	SELECT 
		 RowId = CASE 
					 WHEN IsSale = 1 AND ISNULL(CustomerPartyRef , 0)  = -1 THEN 1
					 WHEN IsSale = 1 AND ISNULL(CustomerPartyRef , 0) <> -1 THEN 2
					 WHEN IsSale = 0                             THEN 3
				 END,
	     IsSale , CustomerPartyRef , TracingID , StockID 
	FROM 
	   (Select IsSale           = 0  UNION ALL Select IsSale           = 1                )a
	CROSS JOIN    
	   (Select CustomerPartyRef = -1 UNION ALL Select CustomerPartyRef = @CustomerPartyRef WHERE @CustomerPartyRef <> -1)b
	CROSS JOIN    
	   (Select TracingID        = -1 UNION ALL Select TracingID        = @TracingID        WHERE @TracingID <> -1)c
	CROSS JOIN    
	   (Select StockID          = -1 UNION ALL Select StockID          = @StockID          WHERE @StockID <> -1)d
	WHERE NOT(IsSale = 0 AND CustomerPartyRef > 0)
----------------------------------------------------------------------------------------------------------------------------------------
if(@isProduct = 1)
BEGIN
	UPDATE a Set a.Fee = b.Fee, a.[Date] = b.[Date],
        a.RowId = CASE 
            WHEN IsSale = 1 AND CustomerPartyRef   = -1 THEN 1
            WHEN IsSale = 1 AND CustomerPartyRef  <> -1 THEN 2
            WHEN IsSale = 0                             THEN 3
        END
	From @Tbl a
    OUTER APPLY (
	   SELECT TOP 1 Fee, [Date]
	   From (Select  b.Date,
		        EntityOrder = 1,
				ID = a.InventoryReceiptItemId,
				ItemRef,
				TracingRef,
				StockRef,
				CustomerPartyRef = CAST(NULL AS int),
				Fee = CASE WHEN Quantity <> 0 THEN Fee + (ISNULL(TransportPrice,0)) / Quantity END ,
				IsSale = 0
		From       INV.vwInventoryReceiptItem a 
		INNER JOIN INV.InventoryReceipt       b ON a.InventoryReceiptRef = b.InventoryReceiptID
		WHERE @isProduct = 1
		AND   b.Type = 1      -- Buy
		AND ItemRef = @ItemId
		union all
		SELECT  b.Date,
		        EntityOrder = 2,
				ID = a.InventoryPurchaseInvoiceItemId,
				ItemRef,
				TracingRef,
				StockRef = NULL,
				CustomerPartyRef = CAST(NULL AS int),
				Fee = CASE WHEN Quantity <> 0 THEN 
				         FeeInBaseCurrency + 
				         (
				          +ISNULL(TransportPriceInBaseCurrency,0)
				          +ISNULL(AdditionInBaseCurrency ,0)
				          -ISNULL(DiscountInBaseCurrentcy,0)
				         ) / Quantity 
				      END,
				IsSale = 0
		From       Inv.InventoryPurchaseInvoiceItem a 
		INNER JOIN Inv.InventoryPurchaseInvoice     b ON a.InventoryPurchaseInvoiceRef = b.InventoryPurchaseInvoiceID
		WHERE @isProduct = 1						
		AND ItemRef = @ItemId ) b
	   Where a.IsSale = b.IsSale
	   AND   (ISNULL(a.CustomerPartyRef, 0) = -1 OR ISNULL(b.CustomerPartyRef,0) = ISNULL(a.CustomerPartyRef, -2))
	   AND   (ISNULL(a.StockID         , 0) = -1 OR ISNULL(b.StockRef        ,0) = ISNULL(a.StockID         , -2))
	   AND   (ISNULL(a.TracingID       , 0) = -1 OR ISNULL(b.TracingRef      ,0) = ISNULL(a.TracingID       ,  0))
	   AND   Fee IS NOT NULL
	   ORDER BY [Date]  DESC, EntityOrder, ID DESC
	) b
    Where  a.IsSale = 0

END


		
	UPDATE a Set Fee = b.Fee, a.[Date] = b.[Date],
        RowId = CASE 
            WHEN IsSale = 1 AND CustomerPartyRef   = -1 THEN 1
            WHEN IsSale = 1 AND CustomerPartyRef  <> -1 THEN 2
            WHEN IsSale = 0                             THEN 3
        END
	From @Tbl a
    OUTER APPLY (
	   SELECT TOP 1 Fee, [Date]
	   From (	SELECT  b.Date,
		        EntityOrder = 1,
				ID = a.InvoiceItemId,
				ItemRef,
				TracingRef,
				StockRef,
				CustomerPartyRef,
				Fee = CASE WHEN Quantity <> 0 THEN 
				         (
				          +ISNULL(a.PriceInBaseCurrency, 0)
				       -- +ISNULL(a.AdditionInBaseCurrency,0)
				       -- -ISNULL(a.DiscountInBaseCurrency,0)
				         ) / Quantity 
				      END ,
				IsSale = 1
		From       SLS.InvoiceItem a 
		INNER JOIN SLS.Invoice     b ON a.InvoiceRef = b.InvoiceID
		WHERE 1=1						
		AND   State <> 2 /*ابطال*/
		AND ItemRef = @ItemId ) b
	   Where a.IsSale = b.IsSale
	   AND   (ISNULL(a.CustomerPartyRef, 0) = -1 OR ISNULL(b.CustomerPartyRef,0) = ISNULL(a.CustomerPartyRef, -2))
	   AND   (ISNULL(a.StockID         , 0) = -1 OR ISNULL(b.StockRef        ,0) = ISNULL(a.StockID         , -2))
	   AND   (ISNULL(a.TracingID       , 0) = -1 OR ISNULL(b.TracingRef      ,0) = ISNULL(a.TracingID       ,  0))
	   AND   Fee IS NOT NULL
	   ORDER BY [Date]  DESC, EntityOrder, ID DESC
	) b
    Where  a.IsSale = 1
----------------------------------------------------------------------------------------------------------------------------------------
	INSERT INTO @Result(RowID, PriceType, [Order], Title, Fee, FeeInStock, TracingFee, TracingFeeInStock, FeeDate, FeeInStockDate, TracingFeeDate, TracingFeeInStockDate)
    SELECT RowID, PriceType = RowID, [Order], Title,
        Fee.Fee,
        FeeInStock.FeeInStock,
        TracingFee.TracingFee,
        TracingFeeInStock.TracingFeeInStock,
        Fee.FeeDate,
        FeeInStock.FeeInStockDate,
        TracingFee.TracingFeeDate,
        TracingFeeInStock.TracingFeeInStockDate
    FROM (
		SELECT 1 , 1 , 'SALE'           UNION ALL   
		SELECT 2 , 2 , 'SALETOCUSTOMER'  UNION ALL    
		SELECT 3 , 3 , 'BUY'
	)a(RowID, [Order] , Title)
    OUTER APPLY (
		SELECT Fee AS Fee, [Date] AS FeeDate FROM @Tbl b WHERE a.RowID = b.RowID AND StockID = -1       AND TracingID = -1
    ) AS Fee
    OUTER APPLY (
		SELECT Fee AS FeeInStock, [Date] AS FeeInStockDate FROM @Tbl b WHERE a.RowID = b.RowID AND StockID = @StockID AND TracingID = -1
    ) AS FeeInStock
    OUTER APPLY (
		SELECT TOP 1 Fee AS TracingFee, [Date] AS TracingFeeDate FROM @Tbl b WHERE a.RowID = b.RowID AND StockID = -1       AND TracingID = @TracingID
    ) AS TracingFee
    OUTER APPLY (
		SELECT Fee AS TracingFeeInStock, [Date] AS TracingFeeInStockDate FROM @Tbl b WHERE a.RowID = b.RowID AND StockID = @StockID AND TracingID = @TracingID
    ) AS TracingFeeInStock
----------------------------------------------------------------------------------------------------------------------------------------
	RETURN
end	
GO
