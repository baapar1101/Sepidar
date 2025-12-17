IF EXISTS (SELECT * FROM TempDB.dbo.sysobjects WHERE ID = object_id(N'TempDb.Dbo.#TempDiscount'))
DROP TABLE  #TempDiscount

DECLARE @DiscountID INT, @UsedCount INT
DECLARE  @StartDate DateTime, @EndDate DateTime, @SaleTypeRef INT,  @CurrencyRef INT, @CustomerGroupingRef INT, @IsActive INT

  
SELECT D.DiscountID,  Pnd.StartDate, PND.EndDate, PNI.SaleTypeRef,  PNI.CurrencyRef, PNI.CustomerGroupingRef, IsActive  
	INTO  #TempDiscount
FROM  [SLS].[PriceNoteiTEM] PNI 
		inner join [SLS].[PriceNoteItemDiscount] PND ON  pnd.PriceNoteItemRef = PNI.PriceNoteItemID
		inner join [SLS].[Discount] D ON  PND.disCountRef = D.DiscountID	
WHERE PND.Converted	 IS null
group by D.DiscountID,  Pnd.StartDate, PND.EndDate, 
		PNI.SaleTypeRef,  PNI.CurrencyRef, PNI.CustomerGroupingRef, IsActive 
order by D.DiscountID


Declare OldDiscountItems Cursor For
  	SELECT DiscountID,  StartDate, EndDate, SaleTypeRef,  CurrencyRef, CustomerGroupingRef, IsActive  
		FROM #TempDiscount

OPEN OldDiscountItems
Fetch Next  FROM OldDiscountItems  INTO @DiscountID, @StartDate, @EndDate, @SaleTypeRef,  @CurrencyRef, @CustomerGroupingRef, @IsActive

While @@FETCH_STATUS	= 0
BEGIN 
	Declare @DiscountCount INT 
  	SELECT @DiscountCount = Count(*) 
		FROM #TempDiscount
	WHERE DiscountID = @DiscountID

	DECLARE @NewDiscountId  int , @NewDiscountNumber INT
	
	
	if(@DiscountCount > 1)
	BEGIN

		EXEC [FMK].[spGetNextId]  'SLS.Discount',  @NewDiscountId out,1

            Select @NewDiscountNumber = ISNULL(Max(Isnull(NUmber,0) ),0)+1 From sls.Discount 
      
		
		INSERT INTO SLS.Discount(DiscountID, Number, Title, Title_En, SaleVolumeType, DiscountCalcType, IsActive,  
									StartDate, EndDate, SaleTypeRef,  CurrencyRef, CustomerGroupingRef, Version)
			Select @NewDiscountId ,  @NewDiscountNumber, Title + '_' + CAST(@NewDiscountNumber As NVarchar), 
														 Title_En + '_' + CAST(@NewDiscountNumber As NVarchar),  
					SaleVolumeType, DiscountCalcType, IsActive, @StartDate, @EndDate, @SaleTypeRef,  @CurrencyRef, @CustomerGroupingRef, 1
				FROM sls.Discount
		WHERE DiscountID = @DiscountID

		Declare @DicountItemCount int

		select @DicountItemCount = Count(*)
		FROM SLS.DiscountItem
		Where Discountref = @DiscountID

		if(@DicountItemCount  > 0 )
		begin
			DECLARE @DiscountItemID INT
			EXEC [FMK].[spGetNextId] 'SLS.DiscountItem', @DiscountItemID  out , @DicountItemCount

			SET @DiscountItemID  = @DiscountItemID  - @DicountItemCount
			
			INSERT INTO [SLS].[DiscountItem]([DiscountItemID], [DiscountRef], [FromValue], [ToValue], [DiscountType], [Amount], [ItemRef], [TracingRef], [ProductPackRef])
			SELECT  Row_Number() over(order by DiscountItemID) + @DiscountItemID, @NewDiscountId, [FromValue], [ToValue], [DiscountType], [Amount], [ItemRef], [TracingRef], [ProductPackRef]
			 FROM SLS.DiscountItem
			Where Discountref = @DiscountID
		END

	END
	ELSE
	BEGIN
		SET @NewDiscountId = @DiscountID
		UPDATE sls.Discount
			SET StartDate = @StartDate, EndDate = @EndDate, SaleTypeRef = @SaleTypeRef,  
				CurrencyRef = @CurrencyRef, CustomerGroupingRef = @CustomerGroupingRef
		WHERE DiscountID =  @DiscountID
	END

		Declare @ItemDiscountID Int , @RecordCount  int

		SELECT @RecordCount  = Count(*)
		FROM  [SLS].[PriceNoteItem] PNI 
			 inner join [SLS].[PriceNoteItemDiscount] PND ON  pnd.PriceNoteItemRef = PNI.PriceNoteItemID		 
		Where Isnull(PNI.SaleTypeRef, 0)=  Isnull(@SaleTypeRef,0)
			AND Isnull(PNI.CurrencyRef, 0) = Isnull(@CurrencyRef ,0)
			AND Isnull(PNI.CustomerGroupingRef,0) = Isnull(@CustomerGroupingRef,0)
			AND PND.StartDate= @StartDate
			AND isnull(PND.EndDate ,0)= isnull(@EndDate,0)
			AND PND.DiscountRef = @DiscountID 
		if(@RecordCount  >0)
		BEGIN

			EXEC [FMK].[spGetNextId] 'SLS.ItemDiscount', @ItemDiscountID out , @RecordCount
			
			SET @ItemDiscountID = @ItemDiscountID - @RecordCount 

			INSERT INTO [SLS].[ItemDiscount](ItemDiscountID, DiscountRef, ItemRef, TracingRef)
			SELECT Row_Number() over(order by itemRef) + @ItemDiscountID  ItemDiscountID,  @NewDiscountId , PNI.ItemRef, PNI.TracingRef
			FROM  [SLS].[PriceNoteItem] PNI 
				 inner join [SLS].[PriceNoteItemDiscount] PND ON  pnd.PriceNoteItemRef = PNI.PriceNoteItemID		 
			Where Isnull(PNI.SaleTypeRef, 0)=  Isnull(@SaleTypeRef,0)
				AND Isnull(PNI.CurrencyRef, 0) = Isnull(@CurrencyRef ,0)
				AND Isnull(PNI.CustomerGroupingRef,0) = Isnull(@CustomerGroupingRef,0)
				AND PND.StartDate= @StartDate
				AND isnull(PND.EndDate ,0)= isnull(@EndDate,0)
				AND PND.DiscountRef = @DiscountID 
			GROUP BY  PNI.ItemRef, PNI.TracingRef
		END 
	Fetch Next  FROM OldDiscountItems  INTO @DiscountID, @StartDate, @EndDate, @SaleTypeRef,  @CurrencyRef, @CustomerGroupingRef, @IsActive
END

Close OldDiscountItems  
DEALLOCATE OldDiscountItems  

UPDATE  [SLS].[Discount]
SET IsActive = 0
WHERE ISactive= 1	
	AND DiscountID IN (  SELECT T.DiscountID
						FROM #TempDiscount T INNER JOIN sls.Discount D On T.DiscountID = D.DiscountID AND D.ISactive= 1							
						GROUP BY T.DiscountID
						Having count(*) > 1	)
UPDATE [SLS].[PriceNoteItemDiscount] 
SET Converted = 1

UPDATE  [SLS].[Discount]
SET IsActive = 0
WHERE ISactive= 1	
	AND startDate IS NUll

IF EXISTS (SELECT * FROM TempDB.dbo.sysobjects WHERE ID = object_id(N'TempDb.Dbo.#TempDiscount'))
DROP TABLE  #TempDiscount