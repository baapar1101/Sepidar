--<<FileName:DST_ProductSaleLineStock.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('DST.ProductSaleLineStock') IS NULL
CREATE TABLE [DST].[ProductSaleLineStock]
(
	[ProductSaleLineStockId] [INT] NOT NULL,
	[ProductSaleLineRef] [INT] NOT NULL,
	[StockRef] [INT] NOT NULL,
) 
ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.Quotation') and
				[name] = 'ColumnName')
begin
    Alter table SLS.Quotation Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--
IF EXISTS (SELECT 1 FROM [sys].[columns] WHERE [object_id]=OBJECT_ID('DST.ProductSaleLineStock') AND [name] = 'IsDefault')
BEGIN
	ALTER TABLE [DST].[ProductSaleLineStock] DROP COLUMN IsDefault
END

/* Sample
IF EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.Quotation') AND
				[name] = 'NetPriceInBaseCurrency' AND is_Computed = 1)
BEGIN
	IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Quotation') AND
			[name] = 'PriceInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Quotation DROP COLUMN PriceInBaseCurrency
	END
END
*/

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_DST_ProductSaleLineStock')
ALTER TABLE [DST].[ProductSaleLineStock] ADD  CONSTRAINT [PK_DST_ProductSaleLineStock] PRIMARY KEY CLUSTERED 
(
	[ProductSaleLineStockId] ASC
) 
ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_ProductSaleLineStock_ProductSaleLineRef_StockRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_ProductSaleLineStock_ProductSaleLineRef_StockRef] ON [DST].[ProductSaleLineStock]
(
	[ProductSaleLineRef] ASC,
	[StockRef] ASC
)

GO

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductSaleLineStock_ProductSaleLine')
ALTER TABLE [DST].[ProductSaleLineStock] ADD CONSTRAINT [FK_ProductSaleLineStock_ProductSaleLine] FOREIGN KEY([ProductSaleLineRef])
REFERENCES [DST].[ProductSaleLine] ([ProductSaleLineId])
ON DELETE CASCADE

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductSaleLineStock_Stock')
ALTER TABLE [DST].[ProductSaleLineStock] ADD CONSTRAINT [FK_ProductSaleLineStock_Stock] FOREIGN KEY([StockRef])
REFERENCES [INV].[Stock] ([StockID])

GO

--<< DROP OBJECTS >>--
