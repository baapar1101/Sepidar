--<<FileName:INV_ProducedItemPrice.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('INV.ProducedItemPrice') Is Null
CREATE TABLE [INV].[ProducedItemPrice](
	[ProducedItemPriceID] [int] NOT NULL,
	[StockRef] [int] NOT NULL,
	[ItemRef] [int] NOT NULL,
	[Price] [decimal](19, 4) NULL,
	[FiscalYearRef] [int] NOT NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('INV.ProducedItemPrice') and
				[name] = 'ColumnName')
begin
    Alter table INV.ProducedItemPrice Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ProducedItemPrice')
ALTER TABLE [INV].ProducedItemPrice ADD  CONSTRAINT [PK_ProducedItemPrice] PRIMARY KEY CLUSTERED 
(
	[ProducedItemPriceID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME='FK_ProducedItemPrice_FiscalYear')
	ALTER TABLE [INV].[ProducedItemPrice] ADD  CONSTRAINT [FK_ProducedItemPrice_FiscalYear]
	FOREIGN KEY ([FiscalYearRef]) REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME='FK_ProducedItemPrice_Item')
	ALTER TABLE [INV].[ProducedItemPrice] ADD  CONSTRAINT [FK_ProducedItemPrice_Item]
	FOREIGN KEY([ItemRef]) REFERENCES [INV].[Item] ([ItemID]) ON DELETE CASCADE

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME='FK_ProducedItemPrice_Stock')
	ALTER TABLE [INV].[ProducedItemPrice] ADD  CONSTRAINT [FK_ProducedItemPrice_Stock]
	FOREIGN KEY([StockRef]) REFERENCES [INV].[Stock] ([StockID])
--<< DROP OBJECTS >>--