--<<FileName:DST_ProductSaleLineItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('DST.ProductSaleLineItem') Is Null
CREATE TABLE [DST].[ProductSaleLineItem]
(
	[ProductSaleLineItemId] [int] NOT NULL,
	[ProductSaleLineRef] INT NOT NULL,
	[ItemRef] INT NOT NULL,
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

If not Exists (select 1 from sys.objects where name = 'PK_DST_ProductSaleLineItem')
ALTER TABLE [DST].[ProductSaleLineItem] ADD  CONSTRAINT [PK_DST_ProductSaleLineItem] PRIMARY KEY CLUSTERED 
(
	[ProductSaleLineItemId] ASC
) 
ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'UIX_ProductSaleLineItem_ProductSaleLineRef_ItemRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_ProductSaleLineItem_ProductSaleLineRef_ItemRef] ON [DST].[ProductSaleLineItem]
(
	[ProductSaleLineRef], [ItemRef]
)

GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ProductSaleLineItem_ProductSaleLine')
ALTER TABLE [DST].[ProductSaleLineItem]  ADD  CONSTRAINT [FK_ProductSaleLineItem_ProductSaleLine] FOREIGN KEY([ProductSaleLineRef])
REFERENCES [DST].[ProductSaleLine] ([ProductSaleLineId])
ON DELETE CASCADE

GO

If not Exists (select 1 from sys.objects where name = 'FK_ProductSaleLineItem_Item')
ALTER TABLE [DST].[ProductSaleLineItem]  ADD  CONSTRAINT [FK_ProductSaleLineItem_Item] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])

GO

--<< DROP OBJECTS >>--
