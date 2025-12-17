--<<FileName:WKO_FormulaBomItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('WKO.FormulaBomItem') Is Null
CREATE TABLE [WKO].[FormulaBomItem](
	[FormulaBomItemID] [int] NOT NULL,
	[ProductFormulaRef] [int] NOT NULL,
    [ItemRef] [int] NOT NULL,
    [Quantity] [decimal](19, 4) NOT NULL,
    [SecondaryQuantity] [decimal](19, 4) NULL,
	[Description] [nvarchar](4000) NULL,
	[ItemTracingRef] int NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO

--<< ADD CLOLUMNS >>--
/*IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('WKO.FormulaBomItem') AND
				[Name] = 'ColumnName')
BEGIN
	ALTER TABLE WKO.FormulaBomItem ADD ColumnName DataType Nullable
END
GO*/
IF COLUMNPROPERTY(OBJECT_ID('WKO.FormulaBomItem'), 'ItemTracingRef' , 'AllowsNull') IS NULL
BEGIN
  ALTER TABLE WKO.FormulaBomItem ADD [ItemTracingRef] int NULL
END
GO

--<< ALTER COLUMNS >>--

/*IF EXISTS (SELECT 1 FROM sys.columns WHERE  object_id=object_id('WKO.FormulaBomItem') AND
	[Name] = 'ColumnName')
BEGIN
	ALTER TABLE WKO.FormulaBomItem ALTER COLUMN ColumnName DataType NOT NULL
END*/

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_FormulaBomItemID')
BEGIN
	ALTER TABLE [WKO].[FormulaBomItem] ADD CONSTRAINT [PK_FormulaBomItemID] PRIMARY KEY CLUSTERED 
	(
		[FormulaBomItemID] ASC
	) ON [PRIMARY]
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_FormulaBomItem_ProductFormulaRef_ItemRef')
CREATE UNIQUE NONCLUSTERED INDEX [IX_FormulaBomItem_ProductFormulaRef_ItemRef] ON [WKO].[FormulaBomItem]
(
	[ProductFormulaRef] ASC,
	[ItemRef] ASC
) ON [PRIMARY]

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_FormulaBomItem_ProductFormulaRef')
BEGIN
	ALTER TABLE [WKO].[FormulaBomItem] ADD CONSTRAINT [FK_FormulaBomItem_ProductFormulaRef] FOREIGN KEY([ProductFormulaRef])
	REFERENCES [WKO].[ProductFormula] ([ProductFormulaID])
	ON DELETE CASCADE
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_FormulaBomItem_ItemRef')
BEGIN
	ALTER TABLE [WKO].[FormulaBomItem] ADD CONSTRAINT [FK_FormulaBomItem_ItemRef] FOREIGN KEY([ItemRef])
	REFERENCES [INV].[Item] ([ItemId])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_FormulaBomItem_ItemTracingRef')
BEGIN
	ALTER TABLE [WKO].[FormulaBomItem] ADD CONSTRAINT [FK_FormulaBomItem_ItemTracingRef] FOREIGN KEY([ItemTracingRef])
	REFERENCES [INV].[Tracing] ([TracingID])
END
GO
--<< DROP OBJECTS >>--