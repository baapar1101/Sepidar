--<<FileName:POM_InsurancePolicy.sql>>--
--<< TABLE DEFINITION >>--
If Object_ID('POM.InsurancePolicy') Is Null
CREATE  TABLE [POM].[InsurancePolicy](
	[InsurancePolicyID] [int] NOT NULL,
	[PurchaseOrderRef] [int] NOT NULL,
    [AgencyDLRef] [int] NOT NULL,
	[CoverType] [int] NOT NULL,
	[SLAccountRef] [int] NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[ValidityDate] [datetime] NULL,
	[CurrencyRef] [int] NOT NULL,
	[CurrencyRate] [decimal](26, 16) NOT NULL,
	[Description] [nvarchar](4000)  NULL,
	[InputCustomsRef] [int] NULL,
	[TransportSourceRef] [int] NULL,
	[TransportDestinationRef] [int] NULL,
	[TotalPrice] [decimal](19, 4) NOT NULL,
	[TotalPriceInBaseCurrency] [decimal](19, 4) NULL,
	[TotalNetPrice] [decimal](19, 4) Not NULL,
	[TotalNetPriceInBaseCurrency] [decimal](19, 4) NULL,
	[TotalTax] [decimal](19, 4) NULL,
	[TotalTaxInBaseCurrency] [decimal](19, 4) NULL,
	[TotalDuty] [decimal](19, 4) NULL,
	[TotalDutyInBaseCurrency] [decimal](19, 4) NULL,
	[AllotmentType] int NOT NULL,
	[VoucherRef] [int] NULL,
	[PaymentHeaderRef] [int] NULL,
    [FiscalYearRef] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL,
	
) ON [PRIMARY]


--<< ADD CLOLUMNS >>--


if not exists (select 1 from sys.columns where object_id=object_id('POM.InsurancePolicy') and
				[name] = 'TotalPrice')
begin
    Alter table POM.InsurancePolicy add  [TotalPrice] [decimal](19, 4) NULL
end

GO

if exists (select 1 from sys.columns where object_id=object_id('POM.InsurancePolicy') and
				[name] = 'TotalPriceInBaseCurrency')
begin
    Alter table POM.InsurancePolicy alter column [TotalPriceInBaseCurrency] [decimal](19, 4) NULL
end

GO

if not exists (select 1 from sys.columns where object_id=object_id('POM.InsurancePolicy') and
				[name] = 'TotalNetPrice')
begin
    Alter table POM.InsurancePolicy Add [TotalNetPrice] [decimal](19, 4) NOT NULL
end

GO

if not exists (select 1 from sys.columns where object_id=object_id('POM.InsurancePolicy') and
				[name] = 'TotalNetPriceInBaseCurrency')
begin
    Alter table POM.InsurancePolicy Add [TotalNetPriceInBaseCurrency] [decimal](19, 4) NULL
end

GO


if exists (select 1 from sys.columns where object_id=object_id('POM.InsurancePolicy') and
				[name] = 'InsuredPrice')
begin
    Alter table POM.InsurancePolicy drop column InsuredPrice
end

GO

if exists (select 1 from sys.columns where object_id=object_id('POM.InsurancePolicy') and
				[name] = 'InsuredPriceInBaseCurrency')
begin
    Alter table POM.InsurancePolicy drop column InsuredPriceInBaseCurrency
end

GO

if exists (select 1 from sys.columns where object_id=object_id('POM.InsurancePolicy') and
				[name] = 'LodingPremium')
begin
    Alter table POM.InsurancePolicy drop column LodingPremium
end

GO

if exists (select 1 from sys.columns where object_id=object_id('POM.InsurancePolicy') and
				[name] = 'LodingPremiumInBaseCurrency')
begin
    Alter table POM.InsurancePolicy drop column LodingPremiumInBaseCurrency
end

GO

if exists (select 1 from sys.columns where object_id=object_id('POM.InsurancePolicy') and
				[name] = 'OtherCoverPrice')
begin
    Alter table POM.InsurancePolicy drop column OtherCoverPrice
end

GO

if exists (select 1 from sys.columns where object_id=object_id('POM.InsurancePolicy') and
				[name] = 'OtherCoverPriceInBaseCurrency')
begin
    Alter table POM.InsurancePolicy drop column OtherCoverPriceInBaseCurrency
end

GO


--<< ALTER COLUMNS >>--

if exists (select 1 from sys.columns where object_id=object_id('POM.InsurancePolicy') and
				[name] = 'Tax')
begin
    EXEC sp_rename 'POM.InsurancePolicy.Tax', 'TotalTax', 'COLUMN';
end

GO

if exists (select 1 from sys.columns where object_id=object_id('POM.InsurancePolicy') and
				[name] = 'TaxInBaseCurrency')
begin
    EXEC sp_rename 'POM.InsurancePolicy.TaxInBaseCurrency', 'TotalTaxInBaseCurrency', 'COLUMN';
end

GO

if exists (select 1 from sys.columns where object_id=object_id('POM.InsurancePolicy') and
				[name] = 'Duty')
begin
    EXEC sp_rename 'POM.InsurancePolicy.Duty', 'TotalDuty', 'COLUMN';
end

GO

if exists (select 1 from sys.columns where object_id=object_id('POM.InsurancePolicy') and
				[name] = 'DutyInBaseCurrency')
begin
    EXEC sp_rename 'POM.InsurancePolicy.DutyInBaseCurrency', 'TotalDutyInBaseCurrency', 'COLUMN';
end

GO


if exists (select 1 from sys.columns where object_id=object_id('POM.InsurancePolicy') and
				[name] = 'InputCustomsDLRef')
begin
    EXEC sp_rename 'POM.InsurancePolicy.InputCustomsDLRef', 'InputCustomsRef', 'COLUMN';
end

GO

If Exists (select 1 from sys.objects where name = 'FK_InsurancePolicy_InputCustomsDL')
ALTER TABLE [POM].[InsurancePolicy] DROP CONSTRAINT FK_InsurancePolicy_InputCustomsDL
GO


--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_InsurancePolicy')
BEGIN
ALTER TABLE [POM].[InsurancePolicy] ADD CONSTRAINT [PK_InsurancePolicy] PRIMARY KEY CLUSTERED 
(
	[InsurancePolicyID] ASC
) ON [PRIMARY]
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'DF_InsurancePolicy_CurrencyRate')
	ALTER TABLE [POM].[InsurancePolicy]
	ADD CONSTRAINT [DF_InsurancePolicy_CurrencyRate]  DEFAULT ((1)) FOR CurrencyRate

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_InsurancePolicy_Voucher')
	CREATE NONCLUSTERED INDEX [IX_InsurancePolicy_Voucher]
		ON [POM].[InsurancePolicy] ([VoucherRef])

Go

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UX_InsurancePolicy_PurchaseOrder')
CREATE UNIQUE NONCLUSTERED INDEX [UX_InsurancePolicy_PurchaseOrder] ON [POM].[InsurancePolicy]
(
	[PurchaseOrderRef] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_InsurancePolicy_Currency')
ALTER TABLE [POM].[InsurancePolicy]  WITH CHECK ADD  CONSTRAINT [FK_InsurancePolicy_Currency] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_InsurancePolicy_AgencyDL')
ALTER TABLE [POM].[InsurancePolicy]  WITH CHECK ADD  CONSTRAINT [FK_InsurancePolicy_AgencyDL] FOREIGN KEY([AgencyDLRef])
REFERENCES [ACC].[DL] ([DLId])
GO


If not Exists (select 1 from sys.objects where name = 'FK_InsurancePolicy_InputCustoms')
ALTER TABLE [POM].[InsurancePolicy]  WITH CHECK ADD  CONSTRAINT [FK_InsurancePolicy_InputCustoms] FOREIGN KEY([InputCustomsRef])
REFERENCES [POM].[Customs] ([CustomsID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_InsurancePolicy_TransportSource')
ALTER TABLE [POM].[InsurancePolicy]  WITH CHECK ADD  CONSTRAINT [FK_InsurancePolicy_TransportSource] FOREIGN KEY([TransportSourceRef])
REFERENCES GNR.[Location]  ([LocationId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_InsurancePolicy_TransportDestination')
ALTER TABLE [POM].[InsurancePolicy]  WITH CHECK ADD  CONSTRAINT [FK_InsurancePolicy_TransportDestination] FOREIGN KEY([TransportDestinationRef])
REFERENCES GNR.[Location]  ([LocationId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_InsurancePolicy_SLAccount')
ALTER TABLE [POM].[InsurancePolicy]  WITH CHECK ADD  CONSTRAINT FK_InsurancePolicy_SLAccount FOREIGN KEY([SLAccountRef])
REFERENCES [ACC].[Account] ([AccountId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_InsurancePolicy_Voucher')
ALTER TABLE [POM].[InsurancePolicy]  WITH CHECK ADD  CONSTRAINT FK_InsurancePolicy_Voucher FOREIGN KEY([VoucherRef])
	REFERENCES ACC.Voucher (VoucherId) 
	ON UPDATE	NO ACTION  
	ON DELETE	NO ACTION 

GO

If not Exists (select 1 from sys.objects where name = 'FK_InsurancePolicy_PaymentHeader')
ALTER TABLE [POM].[InsurancePolicy]  WITH CHECK ADD  CONSTRAINT FK_InsurancePolicy_PaymentHeader FOREIGN KEY([PaymentHeaderRef])
REFERENCES [RPA].[PaymentHeader] ([PaymentHeaderId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_InsurancePolicy_FiscalYear')
ALTER TABLE [POM].[InsurancePolicy]  WITH CHECK ADD  CONSTRAINT [FK_InsurancePolicy_FiscalYear] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO