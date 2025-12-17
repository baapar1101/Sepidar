--<<FileName:WKO_ProductFormula.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('WKO.ProductFormula') Is Null
CREATE TABLE [WKO].[ProductFormula](
	[ProductFormulaID] [int] NOT NULL,
    [Code] [nvarchar](250) NOT NULL,
    [Title] [nvarchar](250) NOT NULL,
    [ItemRef] [int] NOT NULL,
    [ItemUnitRef] [int] NOT NULL,
    [Quantity] [decimal](19, 4) NOT NULL,
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_ProductFormula_IsActive]  DEFAULT ((1)),
	[EstimatedLabour] [decimal](19, 4) NULL,
	[EstimatedOverhead] [decimal](19, 4) NULL,
	[BaseProductFormula] [int] NULL,
	[Description] [nvarchar](4000) NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[CostCenterRef] [int] NULL,
	[Version] [int] NOT NULL,
	[TracingTitle] [nvarchar](4000) NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO

--<< ADD CLOLUMNS >>--
/*IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('WKO.ProductFormula') AND
				[Name] = 'ColumnName')
BEGIN
	ALTER TABLE WKO.ProductFormula ADD ColumnName DataType Nullable
END
GO*/

IF COLUMNPROPERTY(OBJECT_ID('WKO.ProductFormula'), 'CostCenterRef' , 'AllowsNull') IS NULL
BEGIN
  ALTER TABLE WKO.ProductFormula ADD [CostCenterRef] [int] NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('WKO.ProductFormula') AND
	[name] = 'Description' )
BEGIN
	ALTER TABLE WKO.ProductFormula ADD [Description] [nvarchar](4000) NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('WKO.ProductFormula') AND
	[name] = 'TracingTitle' )
BEGIN
	ALTER TABLE WKO.ProductFormula ADD [TracingTitle] [nvarchar](4000) NULL
END
GO

--<< ALTER COLUMNS >>--

/*IF EXISTS (SELECT 1 FROM sys.columns WHERE  object_id=object_id('WKO.ProductFormula') AND
	[Name] = 'ColumnName')
BEGIN
	ALTER TABLE WKO.ProductFormula ALTER COLUMN ColumnName DataType NOT NULL
END*/

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_ProductFormulaID')
BEGIN
	ALTER TABLE [WKO].[ProductFormula] ADD CONSTRAINT [PK_ProductFormulaID] PRIMARY KEY CLUSTERED 
	(
		[ProductFormulaID] ASC
	) ON [PRIMARY]
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductFormula_ItemRef')
BEGIN
	ALTER TABLE [WKO].[ProductFormula] ADD CONSTRAINT [FK_ProductFormula_ItemRef] FOREIGN KEY([ItemRef])
	REFERENCES [INV].[Item] ([ItemId])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductFormula_ItemUnitRef')
BEGIN
	ALTER TABLE [WKO].[ProductFormula] ADD CONSTRAINT [FK_ProductFormula_ItemUnitRef] FOREIGN KEY([ItemUnitRef])
	REFERENCES [INV].[Unit] ([UnitId])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects where name = 'FK_ProductFormula_BaseProductFormula')
BEGIN
	ALTER TABLE [WKO].[ProductFormula] ADD CONSTRAINT [FK_ProductFormula_BaseProductFormula] FOREIGN KEY([BaseProductFormula])
	REFERENCES [WKO].[ProductFormula] ([ProductFormulaID])
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductFormula_CostCenterRef')
BEGIN
	ALTER TABLE [WKO].[ProductFormula] ADD CONSTRAINT [FK_ProductFormula_CostCenterRef] FOREIGN KEY([CostCenterRef])
	REFERENCES [GNR].[CostCenter] ([CostCenterId])
END
GO
--<< DROP OBJECTS >>--