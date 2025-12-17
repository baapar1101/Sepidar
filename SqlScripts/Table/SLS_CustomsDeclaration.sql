--<<FileName:SLS_CustomsDeclaration.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.CustomsDeclaration') Is Null
CREATE TABLE [SLS].[CustomsDeclaration]
(
    [CustomsDeclarationId]          [int]                   NOT NULL,
    [Number]                        [int]                   NOT NULL,
    [CottageNumber]                 [NVARCHAR](100)         NULL,
    [CottageDate]                   [DateTime]              NULL,
    [Rate]                          [decimal](26, 16)       NOT NULL,
    [Price]                         [Decimal](19,4)         NOT NULL,
	[PriceInBaseCurrency]           [Decimal](19,4)         NOT NULL,
    [OtherTaxes]                    [decimal](19, 4)        NULL,
    [OtherAmounts]                  [decimal](19, 4)        NULL,
    [State]                         [INT]                   NOT NULL DEFAULT 1,
    [CurrencyRef]                   [int]                   NOT NULL,
    [TaxPayerBillIssueDateTime]     [DateTime]              NULL,
    [SellerCustomsDeclarationCode]  [NVARCHAR](100)         NULL,
    [FiscalYearRef]                 [int]                   NOT NULL,
    [Version]                       [int]                   NOT NULL,
    [Creator]                       [int]                   NOT NULL,
    [CreationDate]                  [datetime]              NOT NULL,
    [LastModifier]                  [int]                   NOT NULL,
    [LastModificationDate]          [datetime]              NOT NULL,
) ON [PRIMARY]

GO
--<< ADD CLOLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.CustomsDeclaration') AND
				[NAME] = 'State')
BEGIN
    ALTER TABLE SLS.CustomsDeclaration ADD [State] INT NOT NULL DEFAULT 1
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.CustomsDeclaration') and
	[name]='SellerCustomsDeclarationCode')
BEGIN
	ALTER TABLE SLS.CustomsDeclaration ADD [SellerCustomsDeclarationCode] [NVARCHAR](100) NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.CustomsDeclaration') and
	[name]='TaxPayerBillIssueDateTime')
BEGIN
	ALTER TABLE SLS.CustomsDeclaration ADD [TaxPayerBillIssueDateTime] [DateTime] NULL
END
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_CustomsDeclaration')
ALTER TABLE [SLS].[CustomsDeclaration] ADD  CONSTRAINT [PK_CustomsDeclaration] PRIMARY KEY CLUSTERED
(
	[CustomsDeclarationId] ASC
) ON [PRIMARY]
GO

If not Exists (select 1 from sys.objects where name = 'FK_CustomsDeclaration_FiscalYear')
ALTER TABLE [SLS].[CustomsDeclaration]  ADD  CONSTRAINT [FK_CustomsDeclaration_FiscalYear] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_CustomsDeclaration_CurrencyRef')
ALTER TABLE [SLS].[CustomsDeclaration]  ADD  CONSTRAINT [FK_CustomsDeclaration_CurrencyRef] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO
--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

--<< DROP OBJECTS >>--
--<< DROP OBJECTS >>--