--<<FileName:GNR_Grouping.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.Grouping') Is Null
CREATE TABLE [GNR].[Grouping](
	[GroupingID] [int] NOT NULL,
	[EntityType] [varchar](1000) NOT NULL,
	[Code] [varchar](400) NOT NULL,
	[FullCode] [varchar](400) NOT NULL,
	[Title] [nvarchar](400) NOT NULL,
	[Title_En] [nvarchar](400) NOT NULL,
	[MaximumCredit] [decimal](19, 4) NULL,
	[HasCredit] [bit] NOT NULL DEFAULT 0,
	[CreditCheckingType] [int] NOT NULL DEFAULT 3,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[CalculationFormulaRef] [int] NULL,
	[ParentGroupRef] [int] NULL,
	[MaximumQuantityCredit] [int] NULL,
	[HasQuantityCredit] [bit] NOT NULL DEFAULT 0,
	[QuantityCreditCheckingType] [int] NOT NULL DEFAULT 3
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

if not exists (select 1 from sys.columns where object_id=object_id('GNR.Grouping') and
				[name] = 'MaximumCredit')
begin
    Alter table GNR.Grouping Add [MaximumCredit] [decimal](19, 4) NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('GNR.Grouping') and
				[name] = 'HasCredit')
begin
    Alter table GNR.Grouping ADD [HasCredit] [bit] NOT NULL DEFAULT 0
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('GNR.Grouping') and
				[name] = 'CreditCheckingType')
begin
    Alter table GNR.Grouping Add [CreditCheckingType] [int] NOT NULL DEFAULT 3
end

GO

if not exists (select 1 from sys.columns where object_id=object_id('GNR.Grouping') and
				[name] = 'MaximumQuantityCredit')
BEGIN
    Alter TABLE [GNR].[Grouping] ADD [MaximumQuantityCredit] [int] NULL 
END
GO

if not exists (select 1 from sys.columns where object_id=object_id('GNR.Grouping') and
				[name] = 'HasQuantityCredit')
BEGIN
    Alter TABLE [GNR].[Grouping] ADD [HasQuantityCredit] [bit] NOT NULL DEFAULT 0
END
GO

if not exists (select 1 from sys.columns where object_id=object_id('GNR.Grouping') and
				[name] = 'QuantityCreditCheckingType')
BEGIN
    Alter TABLE [GNR].[Grouping] ADD [QuantityCreditCheckingType] [int] NOT NULL DEFAULT 3
END
GO



--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('GNR.Grouping') and
				[name] = 'ColumnName')
begin
    Alter table GNR.Grouping Add ColumnName DataType Nullable
end
GO*/

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.Grouping') AND [name]='CalculationFormulaRef')
	ALTER TABLE [GNR].[Grouping] ADD [CalculationFormulaRef] [int] NULL
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.Grouping') AND [name]='ParentGroupRef')
	ALTER TABLE [GNR].[Grouping] ADD [ParentGroupRef] [int] NULL
GO

if NOT EXISTS (SELECT 1 
				FROM sys.columns c
				INNER JOIN sys.types t 
					ON c.user_type_id = t.user_type_id
				WHERE object_id=object_id('GNR.Grouping')
				 AND c.[name] = 'Code' AND t.name='varchar')
begin
	EXEC sp_executesql N'ALTER TABLE GNR.Grouping  ALTER COLUMN Code[varchar](250) NOT NULL'
END

if NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.Grouping') AND
				[name] = 'FullCode')
begin

    ALTER TABLE GNR.Grouping ADD [FullCode] [varchar](250) NOT NULL  DEFAULT ((''))
end
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Grouping')
ALTER TABLE [GNR].[Grouping] ADD  CONSTRAINT [PK_Grouping] PRIMARY KEY CLUSTERED 
(
	[GroupingID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF EXISTS(select 1 from sys.indexes where name = 'UIX_Grouping_Code')
	ALTER TABLE [GNR].[Grouping] DROP CONSTRAINT [UIX_Grouping_Code]
GO
If Exists (select 1 from sys.indexes where name = 'UIX_Grouping_Title')
	ALTER TABLE [GNR].[Grouping] DROP CONSTRAINT [UIX_Grouping_Title]
GO
If Exists (select 1 from sys.indexes where name = 'UIX_Grouping_Title_En')
	ALTER TABLE [GNR].[Grouping] DROP CONSTRAINT [UIX_Grouping_Title_En]
GO

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name='FK_Grouping_CalculationFormulaRef')
	ALTER TABLE [GNR].[Grouping]
	ADD CONSTRAINT [FK_Grouping_CalculationFormulaRef]
	FOREIGN KEY (CalculationFormulaRef) REFERENCES [GNR].[CalculationFormula] ([CalculationFormulaID])
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name='FK_Grouping_ParentGroupRef')
	ALTER TABLE [GNR].[Grouping]
	ADD CONSTRAINT [FK_Grouping_ParentGroupRef]
	FOREIGN KEY (ParentGroupRef) REFERENCES [GNR].[Grouping] ([GroupingID])
GO
--<< DROP OBJECTS >>--
