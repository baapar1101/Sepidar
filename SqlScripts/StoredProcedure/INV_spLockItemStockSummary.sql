If Object_ID('INV.spLockItemStockSummary') Is Not Null
	Drop Procedure INV.spLockItemStockSummary
GO


CREATE PROCEDURE [INV].[spLockItemStockSummary]
	@SummaryTable [SummaryRecordTable] READONLY
AS
BEGIN
	SET NOCOUNT ON;
	
	CREATE TABLE #tmpSummaryTable 
	(
		[StockID] [int],
		[ItemID] [int],
		[TracingID] [int] NULL,
		[FiscalYearID] [int],
		[FeedFromClosingOperation] BIT NOT NULL DEFAULT 0
	)

	INSERT INTO #tmpSummaryTable 
	SELECT * FROM @SummaryTable
	
	
	DECLARE @SummaryTableName NVARCHAR(50)
	SET @SummaryTableName = 'INV.ItemStockSummary'
	
	DECLARE @tmpvar INT

	DECLARE @ID INT
	SELECT @ID = LastId FROM FMK.IDGeneration WHERE TableName = @SummaryTableName
	
	INSERT INTO INV.ItemStockSummary( ItemStockSummaryID,
		StockRef, ItemRef ,TracingRef, [Order], UnitRef , InputQuantity, OutputQuantity, FiscalYearRef,FeedFromClosingOperation) 
	SELECT ISNULL(@ID, 0) + ROW_NUMBER() OVER(ORDER BY T.StockID),
		T.StockID , T.ItemID , T.TracingID , I.Ord, I.UnitRef , 0, 0, T.FiscalYearID , T.FeedFromClosingOperation
	FROM #tmpSummaryTable T
		JOIN
		(
			SELECT ItemID, UnitRef, 1 Ord FROM INV.Item
			UNION ALL
			SELECT ItemID, SecondaryUnitRef, 2 Ord FROM INV.Item WHERE SecondaryUnitRef IS NOT NULL
		) I ON T.ItemID = I.ItemID
	WHERE NOT EXISTS
	(
		SELECT *
		FROM INV.ItemStockSummary WITH(NOLOCK) 
		WHERE T.StockID = StockRef
			AND T.ItemID = ItemRef
			AND T.FiscalYearID = FiscalYearRef
			AND ISNULL(T.TracingID, 0) = ISNULL(TracingRef, 0)
			AND I.UnitRef = UnitRef
	)
	
	SELECT @ID = ISNULL(@ID, 0) + @@ROWCOUNT
	EXEC FMK.spSetLastId  @SummaryTableName, @ID
	
	SELECT @tmpvar = 1 FROM INV.ItemStockSummary ISS WITH(ROWLOCK)
		JOIN #tmpSummaryTable T ON StockRef = T.StockID AND ItemRef = T.ItemID AND ISNULL(TracingRef, 0) = ISNULL(T.TracingID, 0) AND FiscalYearRef = T.FiscalYearID
		JOIN INV.Item I ON I.ItemID = ItemRef
	WHERE ISS.UnitRef = I.UnitRef OR ISS.UnitRef = I.SecondaryUnitRef

	drop table #tmpSummaryTable
END



