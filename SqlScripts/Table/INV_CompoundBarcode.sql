--<<FileName:INV_CompoundBarcode.sql>>--
--<< TABLE DEFINITION >>--

IF object_id('INV.CompoundBarcode') IS NULL
CREATE TABLE [INV].[CompoundBarcode](
	[CompoundBarcodeID] [int] NOT NULL,
	[Code] [int] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[FixedPart] [nvarchar](50) NULL,
	[FixedPartStart] [int] NULL,
	[ItemIdentifier] [int] NOT NULL,
	[CodeStart] [int] NOT NULL,
	[CodeLength] [int] NULL,
	[CodeSeparator] [nvarchar](50) NULL,
	[TracingStart] [int] NULL,
	[TracingLength] [int] NULL,
	[TracingSeparator] [nvarchar](50) NULL,
	[QuantityStart] [int] NULL,
	[QuantityWholeLength] [int] NULL,
	[QuantityDecimalSeparator] [nvarchar](50) NULL,
	[QuantityDecimalLength] [int] NULL,
	[QuantitySeparator] [nvarchar](50) NULL,
	[SecondaryQuantityStart] [int] NULL,
	[SecondaryQuantityWholeLength] [int] NULL,
	[SecondaryQuantityDecimalSeparator] [nvarchar](50) NULL,
	[SecondaryQuantityDecimalLength] [int] NULL,
	[SecondaryQuantitySeparator] [nvarchar](50) NULL,
	[DescriptionStart] [int] NULL,
	[DescriptionLength] [int] NULL,
	[DescriptionSeparator] [nvarchar](50) NULL,
	[SerialStart] [int] NULL,
	[SerialLength] [int] NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]


GO

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code


--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('INV.Item') and
				[name] = 'ColumnName')
begin
    Alter table INV.Item Add ColumnName DataType Nullable
end
GO*/

IF NOT EXISTS
	(SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.CompoundBarcode') AND [name]='SecondaryQuantityStart')
	ALTER TABLE INV.CompoundBarcode ADD [SecondaryQuantityStart] [int] NULL

IF NOT EXISTS
	(SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.CompoundBarcode') AND [name]='SecondaryQuantityWholeLength')
	ALTER TABLE INV.CompoundBarcode ADD [SecondaryQuantityWholeLength] [int] NULL

IF NOT EXISTS
	(SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.CompoundBarcode') AND [name]='SecondaryQuantityDecimalSeparator')
	ALTER TABLE INV.CompoundBarcode ADD [SecondaryQuantityDecimalSeparator] [nvarchar](50) NULL

IF NOT EXISTS
	(SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.CompoundBarcode') AND [name]='SecondaryQuantityDecimalLength')
	ALTER TABLE INV.CompoundBarcode ADD [SecondaryQuantityDecimalLength] [int] NULL

IF NOT EXISTS
	(SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.CompoundBarcode') AND [name]='SecondaryQuantitySeparator')
	ALTER TABLE INV.CompoundBarcode ADD [SecondaryQuantitySeparator] [nvarchar](50) NULL

IF NOT EXISTS
	(SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.CompoundBarcode') AND [name]='DescriptionSeparator')
	ALTER TABLE INV.CompoundBarcode ADD [DescriptionSeparator] [nvarchar](50) NULL


	IF NOT EXISTS
	(SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.CompoundBarcode') AND [name]='SerialStart')
	ALTER TABLE INV.CompoundBarcode ADD [SerialStart] [int] NULL


	IF NOT EXISTS
	(SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.CompoundBarcode') AND [name]='SerialLength')
	ALTER TABLE INV.CompoundBarcode ADD [SerialLength] [int] NULL

--<< ALTER COLUMNS >>--

if not exists (select 1 from sys.columns where object_id=object_id('INV.CompoundBarcode') and
				[name] = 'ItemIdentifier')
begin
    Alter table INV.CompoundBarcode Add ItemIdentifier INT NOT NULL DEFAULT 0
end
GO

if exists (select 1 from sys.columns where object_id=object_id('INV.CompoundBarcode') and
				[name] = 'UsesBarcode')
begin
    EXECUTE sp_executesql N'UPDATE INV.CompoundBarcode SET ItemIdentifier = (CAST(UsesBarcode AS INT) + 1)'
    
	IF EXISTS (SELECT * FROM sys.objects WHERE name ='DF_CompoundBarcode_UsesBarcode')
		ALTER TABLE [INV].[CompoundBarcode] DROP  CONSTRAINT [DF_CompoundBarcode_UsesBarcode]
    Alter table INV.CompoundBarcode DROP COLUMN UsesBarcode
end
GO

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_CompoundBarcode')
ALTER TABLE [INV].[CompoundBarcode] ADD  
 CONSTRAINT [PK_CompoundBarcode] PRIMARY KEY CLUSTERED 
 (
	[CompoundBarcodeID] ASC
 ) ON [PRIMARY]
 
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--
