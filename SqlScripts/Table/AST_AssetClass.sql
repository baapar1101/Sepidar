--<<FileName:AST_AssetClass.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('AST.AssetClass') Is Null
CREATE TABLE [AST].[AssetClass](
	[AssetClassID] [int] NOT NULL,
	[Code] [nvarchar] (250) NOT NULL,
	[Title] [nvarchar](400) NOT NULL,
	[Title_En] [nvarchar](400) NOT NULL,
	[AssetSLRef] [int] NULL,
	[DepreciationSLRef] [int] NULL,
	[AccumulatedDepreciationSLRef] [int] NULL,
	[AssetClassRef] [int] NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('AST.AssetClass') and
				[name] = 'ColumnName')
begin
    Alter table AST.AssetClass Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_AssetClass')
ALTER TABLE [AST].[AssetClass] ADD  CONSTRAINT [PK_AssetClass] PRIMARY KEY CLUSTERED 
(
	[AssetClassID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
If not Exists (select 1 from sys.indexes where name = 'UIX_AssetClass_Code_AssetClassRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_AssetClass_Code_AssetClassRef] ON [AST].[AssetClass] 
(
	[Code] ASC,
	[AssetClassRef] ASC
) ON [PRIMARY]

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name='FK_AssetClass_AssetClassRef')
	ALTER TABLE [AST].[AssetClass]
	ADD CONSTRAINT [FK_AssetClass_AssetClassRef]
	FOREIGN KEY (AssetClassRef) REFERENCES [AST].[AssetClass] ([AssetClassID])
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name='FK_AssetClass_AssetSLRef')
	ALTER TABLE [AST].[AssetClass]
	ADD CONSTRAINT [FK_AssetClass_AssetSLRef]
	FOREIGN KEY (AssetSLRef) REFERENCES [ACC].[Account] ([AccountId])
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name='FK_AssetClass_DepreciationSLRef')
	ALTER TABLE [AST].[AssetClass]
	ADD CONSTRAINT [FK_AssetClass_DepreciationSLRef]
	FOREIGN KEY (DepreciationSLRef) REFERENCES [ACC].[Account] ([AccountId])
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name='FK_AssetClass_AccumulatedDepreciationSLRef')
	ALTER TABLE [AST].[AssetClass]
	ADD CONSTRAINT [FK_AssetClass_AccumulatedDepreciationSLRef]
	FOREIGN KEY (AccumulatedDepreciationSLRef) REFERENCES [ACC].[Account] ([AccountId])
GO
--<< DROP OBJECTS >>--
