IF OBJECT_ID('INV.GetTheLastFeeOFInventoryPurchaseInvoice') IS NOT NULL
	DROP FUNCTION INV.GetTheLastFeeOFInventoryPurchaseInvoice
GO
CREATE FUNCTION INV.GetTheLastFeeOFInventoryPurchaseInvoice(@ItemID int, @StockID int, @TracingID int, @VendorDLRef int)
Returns @result TABLE(
              RowID             INT, 
              PriceType			INT, 
			  [Order]           INT, 
			  Title             NVARCHAR(100), 
			  Fee               DECIMAL(19,4), 
			  FeeInStock        DECIMAL(19,4), 
			  TracingFee        DECIMAL(19,4), 
			  TracingFeeInStock DECIMAL(19,4)
			  )
AS
BEGIN


	DECLARE @Tbl    TABLE(RowID             INT,
						  VendorlDlRef  INT,
						  TracingID         INT,
						  StockID           INT,
						  Fee               DECIMAL(19,4))

	INSERT INTO @Tbl ( RowId, VendorlDlRef , TracingID , StockID)
	SELECT 
			 RowId = CASE 
					 WHEN ISNULL(VendorlDlRef , 0)  = -1 THEN 0
					 WHEN ISNULL(VendorlDlRef , 0)  <> -1 THEN 1
				 END,
		 VendorlDlRef , TracingID , StockID 
	FROM 
	   
	   (Select VendorlDlRef = -1 UNION ALL Select VendorlDlRef = @VendorDLRef)b
	CROSS JOIN    
	   (Select TracingID        = -1 UNION ALL Select TracingID        = @TracingID       )c
	CROSS JOIN    
	   (Select StockID          = -1 UNION ALL Select StockID          = @StockID        )d
	
	order by VendorlDlRef  ,TracingID,StockID 
	
	
	
;WITH Buy_CTE
	AS
	(
	SELECT * FROM
	(
		Select  b.Date,
		        EntityOrder = 1,
				ID = a.InventoryReceiptItemId,
				ItemRef,
				TracingRef,
				StockRef,
				VendorlDlRef = CAST(DelivererDLRef AS int),
				Fee = CASE WHEN Quantity <> 0 THEN Fee + (ISNULL(TransportPrice,0)) / Quantity END 

		From       INV.vwInventoryReceiptItem a 
		INNER JOIN INV.InventoryReceipt       b ON a.InventoryReceiptRef = b.InventoryReceiptID
		WHERE 1=1
		AND   b.Type = 1      -- Buy

		UNION ALL
		
		SELECT  b.Date,
		        EntityOrder = 2,
				ID = a.InventoryPurchaseInvoiceItemId,
				ItemRef,
				TracingRef,
				StockRef = NULL,
				VendorlDlRef = CAST(b.VendorDLRef AS int),
				Fee = CASE WHEN Quantity <> 0 THEN 
				         FeeInBaseCurrency + 
				         (
				          +ISNULL(TransportPriceInBaseCurrency,0)
				          +ISNULL(AdditionInBaseCurrency ,0)
				          -ISNULL(DiscountInBaseCurrentcy,0)
				         ) / Quantity 
				      END
		From       Inv.InventoryPurchaseInvoiceItem a 
		INNER JOIN Inv.InventoryPurchaseInvoice     b ON a.InventoryPurchaseInvoiceRef = b.InventoryPurchaseInvoiceID
		WHERE 1=1						

	)Tmp1
	WHERE ItemRef = @ItemID 
	)

	
		UPDATE a Set 
	Fee = 
	(
	   SELECT TOP 1 Fee 
	   From Buy_CTE b
	   Where (ISNULL(a.VendorlDlRef, 0) = -1 OR ( ISNULL(b.VendorlDlRef,0) = ISNULL(a.VendorlDlRef, 0) and @VendorDLRef <> 0) )
	   AND   (ISNULL(a.StockID         , 0) = -1 OR (ISNULL(b.StockRef        ,0) = ISNULL(a.StockID         , 0)and @StockID <>0))
	   AND   (ISNULL(a.TracingID       , 0) = -1 OR (ISNULL(b.TracingRef      ,0) = ISNULL(a.TracingID       ,  0) and @TracingID <>0) )
	   AND   Fee IS NOT NULL
	   ORDER BY [Date]  DESC, EntityOrder, ID DESC
	) 
	, RowId = CASE 
					 WHEN ISNULL(VendorlDlRef , 0)  = -1 THEN 0
					 WHEN ISNULL(VendorlDlRef , 0)  <> -1 THEN 1
				 END
	From @Tbl a
	
	INSERT INTO @Result(RowID , PriceType, [Order] , Title , Fee , FeeInStock , TracingFee , TracingFeeInStock)
    SELECT RowID , PriceType = RowID, [Order] , Title , 
           (SELECT Fee FROM @Tbl b WHERE a.RowID = b.RowID AND StockID = -1       AND TracingID = -1        ),
           (SELECT Fee FROM @Tbl b WHERE a.RowID = b.RowID AND StockID = @StockId AND TracingID = -1        ),
           (SELECT Fee FROM @Tbl b WHERE a.RowID = b.RowID AND StockID = -1       AND TracingID = @TracingID),
           (SELECT Fee FROM @Tbl b WHERE a.RowID = b.RowID AND StockID = @StockId AND TracingID = @TracingID)
    FROM (
		SELECT 0 , 0 , 'Bye'    UNION ALL   
		SELECT 1 , 1 , 'VendorBuy' 
		
	   )a(RowID, [Order] , Title)
	
	
	RETURN
end	
GO