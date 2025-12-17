--<<FileName:WKO_ProductOrderBOMItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('WKO.ProductOrderBOMItem') IS NULL
CREATE TABLE [WKO].[ProductOrderBOMItem](
	[ProductOrderBOMItemID] [int] NOT NULL,
	[ProductOrderRef] [int] NOT NULL,	
	[ItemRef] [int] NOT NULL,
	[FormulaBOMItemRef] [int] NULL,
	[StandardConsumptionQuantity] [decimal](19,4) NULL,
	[RemainingConsumptionQuantity] [decimal](19,4) NULL,
	[Description] [nvarchar](1000) NULL,
	[TransferedQuantity] [decimal](19,4) NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO

--<< ADD CLOLUMNS >>--
/*IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('WKO.ProductOrderBOMItem') AND
				[Name] = 'ColumnName')
BEGIN
	ALTER TABLE WKO.ProductOrderBOMItem ADD ColumnName DataType Nullable
END
GO*/
IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('WKO.ProductOrderBOMItem') AND
				[Name] = 'TransferedQuantity')
BEGIN
	ALTER TABLE WKO.ProductOrderBOMItem ADD [TransferedQuantity] [decimal](19,4) NULL
END
GO

IF COLUMNPROPERTY(OBJECT_ID('WKO.ProductOrderBOMItem'), 'RemainingConsumptionQuantity' , 'AllowsNull') IS NULL
BEGIN
  ALTER TABLE WKO.ProductOrderBOMItem ADD [RemainingConsumptionQuantity] [decimal](19,4) NULL
END
GO

IF COLUMNPROPERTY(OBJECT_ID('WKO.ProductOrderBOMItem'), 'ItemTracingRef' , 'AllowsNull') IS NULL
BEGIN
  ALTER TABLE WKO.ProductOrderBOMItem ADD [ItemTracingRef] int NULL
END
GO

--<< ALTER COLUMNS >>--

/*IF EXISTS (SELECT 1 FROM sys.columns WHERE  object_id=object_id('WKO.ProductOrderBOMItem') AND
	[Name] = 'ColumnName')
BEGIN
	ALTER TABLE WKO.ProductOrderBOMItem ALTER COLUMN ColumnName DataType NOT NULL
END*/

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_ProductOrderBOMItemID')
BEGIN
	ALTER TABLE [WKO].[ProductOrderBOMItem] ADD CONSTRAINT [PK_ProductOrderBOMItemID] PRIMARY KEY CLUSTERED 
	(
		[ProductOrderBOMItemID] ASC
	) ON [PRIMARY]
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes where name = 'UNIQUE_ProductOrderRef_ItemRef')
BEGIN
	ALTER TABLE [WKO].[ProductOrderBOMItem] ADD CONSTRAINT UNIQUE_ProductOrderRef_ItemRef UNIQUE ([ProductOrderRef],[ItemRef])
END
GO

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects where name = 'FK_ProductOrderBOMItem_ProductOrderRef')
ALTER TABLE [WKO].[ProductOrderBOMItem]  ADD  CONSTRAINT [FK_ProductOrderBOMItem_ProductOrderRef] FOREIGN KEY([ProductOrderRef])
REFERENCES [WKO].[ProductOrder] ([ProductOrderID])
ON DELETE CASCADE
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOrderBOMItem_ItemRef')
BEGIN
	ALTER TABLE [WKO].[ProductOrderBOMItem] ADD CONSTRAINT [FK_ProductOrderBOMItem_ItemRef] FOREIGN KEY([ItemRef])
	REFERENCES [INV].[Item] ([ItemId])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOrderBOMItem_FormulaBOMItemRef')
BEGIN
	ALTER TABLE [WKO].[ProductOrderBOMItem] ADD CONSTRAINT [FK_ProductOrderBOMItem_FormulaBOMItemRef] FOREIGN KEY([FormulaBOMItemRef])
	REFERENCES [WKO].[FormulaBOMItem] ([FormulaBOMItemId])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOrderBOMItem_ItemTracingRef')
BEGIN
	ALTER TABLE [WKO].[ProductOrderBOMItem] ADD CONSTRAINT [FK_ProductOrderBOMItem_ItemTracingRef] FOREIGN KEY([ItemTracingRef])
	REFERENCES [INV].[Tracing] ([TracingID])
END
GO

--<< DROP OBJECTS >>--