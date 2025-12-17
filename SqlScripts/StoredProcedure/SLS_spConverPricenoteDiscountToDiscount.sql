
IF OBJECT_ID('SLS.spConverPricenoteDiscountToDiscount') IS NOT NULL
    DROP PROCEDURE SLS.spConverPricenoteDiscountToDiscount
GO
CREATE PROCEDURE [SLS].[spConverPricenoteDiscountToDiscount]
	@FiscalYearID INT,
	@Title NVARCHAR(100)
AS
	BEGIN
	IF EXISTS (SELECT * FROM TempDB.dbo.sysobjects WHERE ID = object_id(N'TempDb.Dbo.#TempDiscount'))
	DROP TABLE  #TempDiscount

	DECLARE @ItemID INT, @UsedCount INT 
	DECLARE  @StartDate DateTime,  @SaleTypeRef INT,  @CurrencyRef INT,  @Discount Decimal(19,4), @IsActive INT

	select @StartDate = StartDate
	From  FMK.FiscalYear
	Where FiscalYearId = @FiscalYearID 

  
	SELECT distinct  PNI.SaleTypeRef,  PNI.CurrencyRef, Discount
		INTO  #TempDiscount
	FROM  [SLS].[PriceNoteItem] PNI 
	WHERE ISNULL(Discount ,0) <> 0


	Declare OldDiscountItems Cursor For
  		SELECT SaleTypeRef,  CurrencyRef, ISNULL(Discount, 0) Discount
			FROM #TempDiscount

	OPEN OldDiscountItems
	Fetch Next  FROM OldDiscountItems  INTO  @SaleTypeRef,  @CurrencyRef, @Discount

	While @@FETCH_STATUS	= 0
	BEGIN 
	
			Declare @ItemDicountCount int
			select @ItemDicountCount = Count(*)
			FROM  [SLS].[vwPriceNoteItem] PNI 
			WHERE ISNULL(Discount ,0) <> 0
				AND SaleTypeRef = @SaleTypeRef
				AND CurrencyRef = @CurrencyRef
				AND ISNULL(Discount, 0)= @Discount
				
			if(@ItemDicountCount  > 0 )
			begin
				DECLARE @NewDiscountId  int , @NewDiscountNumber INT
	
				EXEC [FMK].[spGetNextId]  'SLS.Discount',  @NewDiscountId out,1

				Select @NewDiscountNumber = ISNULL(Max(Isnull(NUmber,0) ),0)+1 From sls.Discount 
		
				INSERT INTO SLS.Discount(DiscountID, Number, Title, Title_En, SaleVolumeType, DiscountCalcType, IsActive,  
											StartDate,  SaleTypeRef,  CurrencyRef, DiscountCalculationBasis, Version)
					Select @NewDiscountId ,  @NewDiscountNumber, @Title + '_' + CAST(@NewDiscountNumber As NVarchar), 
																 @Title + '_' + CAST(@NewDiscountNumber As NVarchar),  
							1 SaleVolumeType,/*Price = 1, Quantity = 2*/ 
							1 DiscountCalcType,/*Linear = 1, Stepped = 2*/ 
							1 IsActive, @StartDate,  @SaleTypeRef,  @CurrencyRef,  0 /* Item = 0*/, 1

				DECLARE @DiscountItemID INT
				EXEC [FMK].[spGetNextId] 'SLS.DiscountItem', @DiscountItemID  out , 1
			
				INSERT INTO [SLS].[DiscountItem]([DiscountItemID], [DiscountRef], [FromValue], [ToValue], [DiscountType], [Amount])
				SELECT  @DiscountItemID, @NewDiscountId, 1, 99999999999, 1 [DiscountType]/*Percent*/, @Discount


			
				DECLARE @ItemDiscountID INT
				EXEC [FMK].[spGetNextId] 'SLS.ItemDiscount', @ItemDiscountID out , @ItemDicountCount
			
				SET @ItemDiscountID = @ItemDiscountID - @ItemDicountCount 
			
				INSERT INTO [SLS].[ItemDiscount](ItemDiscountID, DiscountRef, ItemRef)
				SELECT Row_Number() over(order by itemRef) + @ItemDiscountID  ItemDiscountID,  @NewDiscountId , PNI.ItemRef
					FROM  [SLS].[vwPriceNoteItem] PNI 
				WHERE ISNULL(Discount ,0) <> 0
				AND SaleTypeRef = @SaleTypeRef
				AND CurrencyRef = @CurrencyRef
				AND ISNULL(Discount, 0) = @Discount
			END

 
		Fetch Next  FROM OldDiscountItems  INTO @SaleTypeRef,  @CurrencyRef, @Discount
	END

	Close OldDiscountItems  
	DEALLOCATE OldDiscountItems  

	update [SLS].[PriceNoteItem] 
	set discount = null
	WHERE ISNULL(Discount ,0) <> 0

	IF EXISTS (SELECT * FROM TempDB.dbo.sysobjects WHERE ID = object_id(N'TempDb.Dbo.#TempDiscount'))
	DROP TABLE  #TempDiscount
END