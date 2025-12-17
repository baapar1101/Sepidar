--<<FileName:INV_ItemStockSummary.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('INV.ItemStockSummary') Is Null
CREATE TABLE [INV].[ItemStockSummary](
	[ItemStockSummaryID] [int] NOT NULL,
	[StockRef] [int] NOT NULL,
	[ItemRef] [int] NOT NULL,
	[TracingRef] [int] NULL,
	[Order] [int] NULL,
	[UnitRef] [int] NOT NULL,
	[InputQuantity] [decimal](19, 4) NOT NULL,
	[OutputQuantity] [decimal](19, 4) NOT NULL,
	[Quantity]  AS ([InputQuantity]-[OutputQuantity]) PERSISTED,
	[SaleQuantity] [decimal](19, 4) NULL,
	[SaleWithReserveQuantity] [decimal](19, 4) NULL,
	[FiscalYearRef] [int] NOT NULL,
	[FeedFromClosingOperation] [BIT] NOT NULL DEFAULT 0
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.ItemStockSummary') AND
				[Name]='FiscalYearRef')
	ALTER TABLE INV.ItemStockSummary
		ADD FiscalYearRef INT NULL

GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.ItemStockSummary') AND
				[Name]='FiscalYearRef' and is_nullable=1)
BEGIN
	DECLARE @fy INT
	SELECT TOP 1 @fy =FiscalYearId FROM FMK.FiscalYear
	UPDATE INV.ItemStockSummary SET FiscalYearRef=@fy
	ALTER TABLE INV.ItemStockSummary
		ALTER COLUMN FiscalYearRef INT NOT NULL
END

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.ItemStockSummary') AND
				[Name]='SaleWithReserveQuantity')
	ALTER TABLE INV.ItemStockSummary ADD SaleWithReserveQuantity [decimal](19, 4) NULL

GO


IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.ItemStockSummary') AND
				[Name]='FeedFromClosingOperation')
	ALTER TABLE INV.ItemStockSummary ADD [FeedFromClosingOperation] [BIT] NOT NULL DEFAULT 0

GO

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('INV.ItemStockSummary') and
				[name] = 'ColumnName')
begin
    Alter table INV.ItemStockSummary Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_StockSummary')
ALTER TABLE [INV].[ItemStockSummary] ADD  CONSTRAINT [PK_StockSummary] PRIMARY KEY CLUSTERED 
(
	[ItemStockSummaryID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_ItemStockSummary_Qty')
	CREATE NONCLUSTERED INDEX IX_ItemStockSummary_Qty
ON [INV].[ItemStockSummary] ([InputQuantity],[OutputQuantity],[SaleQuantity],[SaleWithReserveQuantity])
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_ItemStockSummary_ItemRef')
CREATE NONCLUSTERED INDEX [IX_ItemStockSummary_ItemRef]
ON [INV].[ItemStockSummary] ([ItemRef])
Go
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_ItemStockSummary_FiscalYearRef')
CREATE NONCLUSTERED INDEX [IX_ItemStockSummary_FiscalYearRef]
ON [INV].[ItemStockSummary] ([FiscalYearRef])
Go
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_StockSummary_ItemRef')
ALTER TABLE [INV].[ItemStockSummary]  ADD  CONSTRAINT [FK_StockSummary_ItemRef] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_StockSummary_StockRef')
ALTER TABLE [INV].[ItemStockSummary]  ADD  CONSTRAINT [FK_StockSummary_StockRef] FOREIGN KEY([StockRef])
REFERENCES [INV].[Stock] ([StockID])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_StockSummary_Tracing')
ALTER TABLE [INV].[ItemStockSummary]  ADD  CONSTRAINT [FK_StockSummary_Tracing] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_StockSummary_Unit')
ALTER TABLE [INV].[ItemStockSummary]  ADD  CONSTRAINT [FK_StockSummary_Unit] FOREIGN KEY([UnitRef])
REFERENCES [INV].[Unit] ([UnitID])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
