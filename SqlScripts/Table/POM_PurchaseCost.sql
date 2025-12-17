--<<FileName:POM_PurchaseCost.sql>>--
--<< TABLE DEFINITION >>--
If Object_ID('POM.PurchaseCost') Is Null
CREATE  TABLE [POM].[PurchaseCost](
	[PurchaseCostID] [int] NOT NULL,
    [PurchaseInvoiceRef] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[State] [int] NOT NULL,
	[Description] [nvarchar](4000)  NULL,
	[VoucherRef] [int] NULL,
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

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_PurchaseCost')
BEGIN
ALTER TABLE [POM].[PurchaseCost] ADD CONSTRAINT [PK_PurchaseCost] PRIMARY KEY CLUSTERED 
(
	[PurchaseCostID] ASC
) ON [PRIMARY]
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UX_PurchaseCost_PurchaseInvoice_FiscalYear')
CREATE UNIQUE NONCLUSTERED INDEX [UX_PurchaseCost_PurchaseInvoice_FiscalYear] ON [POM].[PurchaseCost]
(
	[PurchaseInvoiceRef] ASC,
	[FiscalYearRef] ASC
) ON [PRIMARY]

GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_PurchaseCost_Voucher')
	CREATE NONCLUSTERED INDEX [IX_PurchaseCost_Voucher]
		ON [POM].[PurchaseCost] ([VoucherRef])

Go


--<< FOREIGNKEYS DEFINITION >>--


If not Exists (select 1 from sys.objects where name = 'FK_PurchaseCost_Voucher')
ALTER TABLE [POM].[PurchaseCost]  WITH CHECK ADD  CONSTRAINT FK_PurchaseCost_Voucher FOREIGN KEY([VoucherRef])
	REFERENCES ACC.Voucher (VoucherId) 
	ON UPDATE	NO ACTION  
	ON DELETE	NO ACTION 

GO


IF NOT EXISTS (select 1 from sys.objects where name = 'FK_PurchaseCost_PurchaseInvoice')
ALTER TABLE [POM].[PurchaseCost]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseCost_PurchaseInvoice] FOREIGN KEY([PurchaseInvoiceRef])
REFERENCES [POM].[PurchaseInvoice] ([PurchaseInvoiceId])

GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_PurchaseCost_FiscalYear')
ALTER TABLE [POM].[PurchaseCost]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseCost_FiscalYear] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO