--<<FileName:POM_BillOfLoading.sql>>--
--<< TABLE DEFINITION >>--
If Object_ID('POM.BillOfLoading') Is Null
CREATE  TABLE [POM].[BillOfLoading](
	[BillOfLoadingID] [int] NOT NULL,
    [TransporterDLRef] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[CurrencyRate] [decimal](26, 16) NOT NULL,
	[AllotmentType] int NOT NULL,
	[Description] [nvarchar](4000)  NULL,
	[TransportSourceRef] [int] NULL,
	[TransportDestinationRef] [int] NULL,
	[TransportType] [nvarchar](100)  NULL,
	[TotalPrice] [decimal](19, 4) NULL,
	[TotalPriceInBaseCurrency] [decimal](19, 4) NULL,
	[TotalDiscount] [decimal](19, 4) NULL,
	[TotalDiscountInBaseCurrency] [decimal](19,4) NULL,
	[TotalAddition] [decimal](19, 4) NULL,
	[TotalAdditionInBaseCurrency] [decimal](19,4)NULL,
	[TotalTax] [decimal](19, 4) NULL,
	[TotalTaxInBaseCurrency] [decimal](19, 4) NULL,
	[TotalDuty] [decimal](19, 4) NULL,
	[TotalDutyInBaseCurrency] [decimal](19, 4) NULL,
    [TotalNetPrice] [decimal](19, 4) NULL,
	[TotalNetPriceInBaseCurrency] [decimal](19, 4) NULL,
	[VoucherRef] [int] NULL,
	[SLAccountRef] [int] NULL,
	[PaymentHeaderRef] [int] NULL,
    [FiscalYearRef] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL,
	
) ON [PRIMARY]


--<< ADD CLOLUMNS >>--
--<<Sample>>--

--<< ALTER COLUMNS >>--

if not exists (select 1 from sys.columns where object_id=object_id('POM.BillOfLoading') and
				[name] = 'AllotmentType')
begin
    Alter table POM.BillOfLoading add [AllotmentType] int NULL
end

GO

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_BillOfLoading')
BEGIN
ALTER TABLE [POM].[BillOfLoading] ADD CONSTRAINT [PK_BillOfLoading] PRIMARY KEY CLUSTERED 
(
	[BillOfLoadingID] ASC
) ON [PRIMARY]
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'DF_BillOfLoading_CurrencyRate')
	ALTER TABLE [POM].[BillOfLoading]
	ADD CONSTRAINT [DF_BillOfLoading_CurrencyRate]  DEFAULT ((1)) FOR CurrencyRate

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_BillOfLoading_Voucher')
BEGIN
	CREATE NONCLUSTERED INDEX [IX_BillOfLoading_Voucher]
		ON [POM].[BillOfLoading] ([VoucherRef])
END

Go


--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_BillOfLoading_Currency')
ALTER TABLE [POM].[BillOfLoading]  WITH CHECK ADD  CONSTRAINT [FK_BillOfLoading_Currency] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_BillOfLoading_TransporterDL')
ALTER TABLE [POM].[BillOfLoading]  WITH CHECK ADD  CONSTRAINT [FK_BillOfLoading_TransporterDL] FOREIGN KEY([TransporterDLRef])
REFERENCES [ACC].[DL] ([DLId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_BillOfLoading_TransportSource')
ALTER TABLE [POM].[BillOfLoading]  WITH CHECK ADD  CONSTRAINT [FK_BillOfLoading_TransportSource] FOREIGN KEY([TransportSourceRef])
REFERENCES GNR.[Location]  ([LocationId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_BillOfLoading_TransportDestination')
ALTER TABLE [POM].[BillOfLoading]  WITH CHECK ADD  CONSTRAINT [FK_BillOfLoading_TransportDestination] FOREIGN KEY([TransportDestinationRef])
REFERENCES GNR.[Location]  ([LocationId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_BillOfLoading_SLAccount')
ALTER TABLE [POM].[BillOfLoading]  WITH CHECK ADD  CONSTRAINT FK_BillOfLoading_SLAccount FOREIGN KEY([SLAccountRef])
REFERENCES [ACC].[Account] ([AccountId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_BillOfLoading_Voucher')
ALTER TABLE [POM].[BillOfLoading]  WITH CHECK ADD  CONSTRAINT FK_BillOfLoading_Voucher FOREIGN KEY([VoucherRef])
	REFERENCES ACC.Voucher (VoucherId) 
	ON UPDATE	NO ACTION  
	ON DELETE	NO ACTION 

GO

If not Exists (select 1 from sys.objects where name = 'FK_BillOfLoading_PaymentHeader')
ALTER TABLE [POM].[BillOfLoading]  WITH CHECK ADD  CONSTRAINT FK_BillOfLoading_PaymentHeader FOREIGN KEY([PaymentHeaderRef])
REFERENCES [RPA].[PaymentHeader] ([PaymentHeaderId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_BillOfLoading_FiscalYear')
ALTER TABLE [POM].[BillOfLoading]  WITH CHECK ADD  CONSTRAINT [FK_BillOfLoading_FiscalYear] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO