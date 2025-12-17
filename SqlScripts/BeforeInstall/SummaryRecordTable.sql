IF OBJECT_ID('INV.spLockItemStockSummary') IS NOT NULL
	DROP PROCEDURE INV.spLockItemStockSummary
GO

IF OBJECT_ID('INV.spUpdateItemStockSummary') IS NOT NULL
	DROP PROCEDURE INV.spUpdateItemStockSummary
GO

IF  EXISTS(SELECT * FROM SYS.TABLE_TYPES WHERE [NAME] = 'SummaryRecordTable')
	DROP TYPE [INV].[SummaryRecordTable]
		

IF NOT EXISTS(SELECT * FROM SYS.TABLE_TYPES WHERE [NAME] = 'SummaryRecordTable')
	CREATE TYPE INV.SummaryRecordTable AS TABLE
	(
		[StockID] [int],
		[ItemID] [int],
		[TracingID] [int] NULL,
		[FiscalYearID] [int] ,
		[FeedFromClosingOperation] BIT NOT NULL DEFAULT 0
	)
	