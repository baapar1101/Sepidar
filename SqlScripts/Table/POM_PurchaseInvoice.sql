--<<FileName:POM_PurchaseInvoice.sql>>--
--<< TABLE DEFINITION >>--
If Object_ID('POM.PurchaseInvoice') Is Null
CREATE  TABLE [POM].[PurchaseInvoice](
	[PurchaseInvoiceID] [int] NOT NULL,
	[VendorDLRef] [int] NOT NULL,
	[PurchasingAgentPartyRef] [int] NULL,
    [PurchaseOrderRef] INT NOT NULL,
    [DLRef] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[PurchaseNumber] [nvarchar](100)  NULL,
	[Date] [datetime] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[CurrencyRate] [decimal](26, 16) NOT NULL,
	[Description] [nvarchar](4000)  NULL,
	[Price] [decimal](19, 4) NULL,
	[PriceInBaseCurrency] [decimal](19, 4) NULL,
	[Discount] [decimal](19, 4) NULL,
	[DiscountInBaseCurrency] [decimal](19, 4) NULL,
	[Addition] [decimal](19, 4) NULL,
	[AdditionInBaseCurrency] [decimal](19, 4) NULL,
    [NetPrice] [decimal](19, 4) NULL,
	[NetPriceInBaseCurrency] [decimal](19, 4) NULL,
    [FiscalYearRef] [int] NOT NULL,
	[CanTransferNextPeriod] [bit] NOT NULL DEFAULT 0,
	[BasePurchaseInvoiceRef] [int] NULL,
	[IsInitial] [bit] NOT NULL DEFAULT 0,
	[PaymentHeaderRef] [int] NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL,
	
) ON [PRIMARY]


--<< ADD CLOLUMNS >>--
--<<Sample>>--

--<< ALTER COLUMNS >>--

if  exists (select 1 from sys.columns where object_id=object_id('POM.PurchaseInvoice') and
				[name] = 'PurchaseNumber')
begin
    Alter table POM.PurchaseInvoice Alter Column [PurchaseNumber]  [nvarchar](100)  NULL
end
GO

if  not exists (select 1 from sys.columns where object_id=object_id('POM.PurchaseInvoice') and
				[name] = 'CanTransferNextPeriod')
begin
    Alter table POM.PurchaseInvoice ADD  [CanTransferNextPeriod]  [bit] NOT NULL DEFAULT 0
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('POM.PurchaseInvoice') and
				[name] = 'IsInitial')
begin
    Alter table POM.PurchaseInvoice ADD  [IsInitial]  [bit] NOT NULL DEFAULT 0
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('POM.PurchaseInvoice') and
				[name] = 'BasePurchaseInvoiceRef')
begin
    Alter table POM.PurchaseInvoice ADD  [BasePurchaseInvoiceRef]  [int]  NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('POM.PurchaseInvoice') and
				[name] = 'PaymentHeaderRef')
begin
    Alter table POM.PurchaseInvoice ADD  [PaymentHeaderRef]  [int]  NULL
end
GO
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('POM.PurchaseInvoice') AND
				[name] = 'PurchasingAgentPartyRef')
BEGIN
    ALTER TABLE [POM].[PurchaseInvoice] ADD [PurchasingAgentPartyRef] INT NULL
END	
Go
--<< Delete Column>>--
if  exists (select 1 from sys.columns where object_id=object_id('POM.PurchaseInvoice') and
				[name] = 'state')
begin
    Alter table POM.PurchaseInvoice DROP COLUMN [state];
end
GO
--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_PurchaseInvoice')
BEGIN
ALTER TABLE [POM].[PurchaseInvoice] ADD CONSTRAINT [PK_PurchaseInvoice] PRIMARY KEY CLUSTERED 
(
	[PurchaseInvoiceID] ASC
) ON [PRIMARY]
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'DF_PurchaseInvoice_CurrencyRate')
	ALTER TABLE [POM].[PurchaseInvoice]
	ADD CONSTRAINT [DF_PurchaseInvoice_CurrencyRate]  DEFAULT ((1)) FOR CurrencyRate

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_PurchaseInvoice_Currency')
ALTER TABLE [POM].[PurchaseInvoice]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseInvoice_Currency] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_PurchaseInvoice_VendorDLRef')
ALTER TABLE [POM].[PurchaseInvoice]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseInvoice_VendorDLRef] FOREIGN KEY([VendorDLRef])
REFERENCES [ACC].[DL] ([DLId])
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_PurchaseInvoice_DL')
ALTER TABLE [POM].[PurchaseInvoice]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseInvoice_DL] FOREIGN KEY([DLRef])
REFERENCES [ACC].[DL] ([DLId])
GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_PurchaseInvoice_FiscalYear')
ALTER TABLE [POM].[PurchaseInvoice]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseInvoice_FiscalYear] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_PurchaseInvoice_BasePurchaseInvoiceRef')
ALTER TABLE [POM].[PurchaseInvoice]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseInvoice_BasePurchaseInvoiceRef] FOREIGN KEY([BasePurchaseInvoiceRef])
REFERENCES [POM].[PurchaseInvoice] ([PurchaseInvoiceID])
GO
IF NOT EXISTS (select 1 from sys.objects where name = 'FK_PurchaseInvoice_PaymentHeader')
ALTER TABLE [POM].[PurchaseInvoice]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseInvoice_PaymentHeader] FOREIGN KEY([PaymentHeaderRef])
REFERENCES [RPA].[PaymentHeader] ([PaymentHeaderId])
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_PurchaseInvoice_PurchasingAgentPartyRef')
ALTER TABLE [POM].[PurchaseInvoice] ADD  CONSTRAINT [FK_PurchaseInvoice_PurchasingAgentPartyRef] FOREIGN KEY([PurchasingAgentPartyRef])
REFERENCES [GNR].[Party] ([PartyId])
GO