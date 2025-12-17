--<<FileName:SLS_Commission.sql>>--
--<< TABLE DEFINITION >>--

IF Object_ID('SLS.Commission') IS NULL
CREATE TABLE [SLS].[Commission](
	[CommissionId]              [int] NOT NULL,
	[Number]                    [int] NOT NULL,
	[Title]                     [nvarchar](250) NOT NULL,
	[Title_En]                  [nvarchar](250) NOT NULL,
	[FromDate]                  [datetime] NOT NULL,
	[ToDate]                    [datetime] NOT NULL,
	[CalculationBase]           [int] NOT NULL,
	[InvoiceSettlementState]    [int] NOT NULL,
	[SaleVolumeCalculationBase] [int] NOT NULL,
	[CalculationType]           [int] NOT NULL,
	[Type]                      [int] NOT NULL,
	[ItemFilterType]            [int] NOT NULL,
	[SaleTypeRef]               [int]     NULL,
	[Version]                   [int] NOT NULL,
	[Creator]                   [int] NOT NULL,
	[CreationDate]              [datetime] NOT NULL,
	[LastModifier]              [int] NOT NULL,
	[LastModificationDate]      [datetime] NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('SLS.Commission') AND
				[name] = 'ColumnName')
BEGIN
    ALTER TABLE SLS.Commission ADD ColumnName DataType Nullable
END
GO*/

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('SLS.Commission') AND
				[name] = 'SaleTypeRef')
BEGIN
    ALTER TABLE SLS.Commission ADD [SaleTypeRef] [int] NULL
END
GO


--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_Commission')
ALTER TABLE [SLS].[Commission] ADD CONSTRAINT [PK_Commission] PRIMARY KEY CLUSTERED 
(
	[CommissionId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UX_Commission_Title')
CREATE UNIQUE NONCLUSTERED INDEX [UX_Commission_Title] ON [SLS].[Commission] 
(
	[Title] ASC
) ON [PRIMARY]

GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UX_Commission_Title_En')
CREATE UNIQUE NONCLUSTERED INDEX [UX_Commission_Title_En] ON [SLS].[Commission] 
(
	[Title_En] ASC
) ON [PRIMARY]
GO


--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--
