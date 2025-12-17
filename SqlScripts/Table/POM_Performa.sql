--<<FileName:INV_Performa.sql>>--
--<< TABLE DEFINITION >>--
If Object_ID('POM.Performa') Is Null
CREATE  TABLE [POM].[Performa](
	[PerformaID] [int] NOT NULL,
	[FiscalYearRef] [int] NOT NULL,
	[PurchasingType] [int] NOT NULL,
	[VendorDLRef] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[PerformaNumber]  [nvarchar](100)  NULL,
	[Date] [datetime] NOT NULL,
	[ValidityDate] [datetime] NULL,
	[CurrencyRef] [int] NOT NULL,
	[CurrencyRate] [decimal](26, 16) NOT NULL,

	[ContractType] [int]  NULL,
	[TransportType]  [nvarchar](100)  NULL,
	[PaymentMethod] [nvarchar](100)  NULL,

	[Description] [nvarchar](4000)  NULL,

	[Price] [decimal](19, 4) NULL,
	[PriceInBaseCurrency] [decimal](19, 4) NULL,

	[NetPrice] [decimal](19, 4) NULL,
	[NetPriceInBaseCurrency] [decimal](19, 4) NULL,

	[Tax] [decimal](19, 4) NULL,
	[TaxInBaseCurrency] [decimal](19, 4) NULL,

	[Duty] [decimal](19, 4) NULL,
	[DutyInBaseCurrency] [decimal](19, 4) NULL,

	[InsuranceAmount] [decimal](19, 4) NULL,
	[InsuranceAmountInBaseCurrency] [decimal](19, 4) NULL,

	[Discount] [decimal](19, 4) NULL,
	[DiscountInBaseCurrency] [decimal](19, 4) NULL,

	[Addition] [decimal](19, 4) NULL,
	[AdditionInBaseCurrency] [decimal](19, 4) NULL,

	[State] [int] NOT NULL,
	[PurchasingAgentPartyRef] [int] null,

	
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL,
	
) ON [PRIMARY]


--<< ADD CLOLUMNS >>--
--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('POM.Performa') and
				[name] = 'ColumnName')
begin
    Alter table POM.Performa Add ColumnName DataType Nullable
end
GO*/
if not exists (select 1 from sys.columns where object_id=object_id('POM.Performa') and
				[name] = 'FiscalYearRef')
begin
    Alter table POM.Performa Add [FiscalYearRef] [int] NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('POM.Performa') and
				[name] = 'NetPrice')
begin
    Alter table POM.Performa Add [NetPrice] [decimal](19, 4) NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('POM.Performa') and
				[name] = 'NetPriceInBaseCurrency')
begin
    Alter table POM.Performa Add [NetPriceInBaseCurrency] [decimal](19, 4) NULL
end
GO


if not exists (select 1 from sys.columns where object_id=object_id('POM.Performa') and
				[name] = 'PurchasingType')
begin
    Alter table POM.Performa Add [PurchasingType] [int] NOT NULL DEFAULT(1)
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('POM.Performa') and
		[name] = 'PurchasingAgentPartyRef')
begin
    Alter table POM.Performa Add PurchasingAgentPartyRef INT NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('POM.Performa') and
				[name] = 'Duty')
begin
    Alter table POM.Performa Add [Duty] [decimal](19, 4) NULL DEFAULT(0)
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('POM.Performa') and
				[name] = 'DutyInBaseCurrency')
begin
    Alter table POM.Performa Add [DutyInBaseCurrency] [decimal](19, 4) NULL DEFAULT(0)
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('POM.Performa') and
				[name] = 'InsuranceAmount')
begin
    Alter table POM.Performa Add [InsuranceAmount] [decimal](19, 4) NULL DEFAULT(0)
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('POM.Performa') and
				[name] = 'InsuranceAmountInBaseCurrency')
begin
    Alter table POM.Performa Add [InsuranceAmountInBaseCurrency] [decimal](19, 4) NULL DEFAULT(0)
end
GO


--<< ALTER COLUMNS >>--
if  exists (select 1 from sys.columns where object_id=object_id('POM.Performa') and
				[name] = 'PerformaNumber')
begin
    Alter table POM.Performa Alter Column [PerformaNumber]  [nvarchar](100)  NULL
end
GO

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_Performa')
BEGIN
ALTER TABLE [POM].[Performa] ADD CONSTRAINT [PK_Performa] PRIMARY KEY CLUSTERED 
(
	[PerformaID] ASC
) ON [PRIMARY]
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'DF_Performa_CurrencyRate')
	ALTER TABLE [POM].[Performa]
	ADD CONSTRAINT [DF_Performa_CurrencyRate]  DEFAULT ((1)) FOR CurrencyRate

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Performa_PurchasingType')
CREATE NONCLUSTERED INDEX [IX_Performa_PurchasingType]
ON [POM].[Performa] ([PurchasingType])
GO
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Performa_Currency')
ALTER TABLE [POM].[Performa]  WITH CHECK ADD  CONSTRAINT [FK_Performa_Currency] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_Performa_DL')
ALTER TABLE [POM].[Performa]  WITH CHECK ADD  CONSTRAINT [FK_Performa_DL] FOREIGN KEY([VendorDLRef])
REFERENCES [ACC].[DL] ([DLId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_Performa_PurchasingAgentPartyRef')
ALTER TABLE [POM].[Performa]  WITH CHECK ADD  CONSTRAINT [FK_Performa_PurchasingAgentPartyRef] FOREIGN KEY([PurchasingAgentPartyRef])
REFERENCES [GNR].[Party] ([PartyId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_Performar_FiscalYearRef')
ALTER TABLE [POM].[Performa]  WITH CHECK ADD  CONSTRAINT [FK_Performar_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [Fmk].[FiscalYear] ([FiscalYearId])
GO
