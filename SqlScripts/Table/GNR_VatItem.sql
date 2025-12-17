--<<FileName:GNR_VatItem.sql>>--
--<< TABLE DEFINITION >>--
If Object_ID('GNR.VatItem') Is Null
CREATE TABLE [GNR].[VatItem](
	[VatItemID] [int] NOT NULL,
	[VatRef] [int] NOT NULL,
	[RowID] [int] NOT NULL,
	[VatItemType] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[Date] [DateTime] NOT NULL,
	[InvoiceRef] [int] NULL,
	[ReturnedInvoiceRef] [int] NULL,
	[InventoryReceiptRef] [int] NULL,
	[InventoryReceiptReturnRef] [int] NULL,
	[ServiceInventoryPurchaseInvoiceRef] [int] NULL,
	[AssetPurchaseInvoiceRef] [int] NULL,
	[AssetSaleRef] [int] NULL,
	[StatusRef] [int] NULL,
	[CustomsClearanceRef] [int] NULL,
	[BillOfLoadingRef] [int] NULL,
	[InsurancePolicyRef] [int] NULL,
	TotalPriceInBaseCurrency decimal(19, 4) NOT NULL,
	TaxExemptItemPriceInBaseCurrency decimal(19, 4) NOT NULL,
	TaxExemptServicePriceInBaseCurrency decimal(19, 4) NOT NULL,
	NonTaxExemptItemPriceInBaseCurrency decimal(19, 4) NOT NULL,
	NonTaxExemptServicePriceInBaseCurrency decimal(19, 4) NOT NULL,
	NonTaxExemptItemTaxInBaseCurrency decimal(19, 4) NOT NULL,
	TaxExemptItemTaxInBaseCurrency decimal(19, 4) NOT NULL,
	NonTaxExemptItemDutyInBaseCurrency decimal(19, 4) NOT NULL,
	TaxExemptItemDutyInBaseCurrency decimal(19, 4) NOT NULL,
	NonTaxExemptServiceTaxInBaseCurrency decimal(19, 4) NOT NULL,
	TaxExemptServiceTaxInBaseCurrency decimal(19, 4) NOT NULL,
	NonTaxExemptServiceDutyInBaseCurrency decimal(19, 4) NOT NULL,
	TaxExemptServiceDutyInBaseCurrency decimal(19, 4) NOT NULL,
	DomesticType int NOT NULL,
	EntityFullName varchar(500)
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('GNR.VatItem') AND
				[name] = 'ServiceInventoryPurchaseInvoiceRef')
BEGIN
    ALTER TABLE GNR.VatItem ADD ServiceInventoryPurchaseInvoiceRef [int] NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('GNR.VatItem') AND [name] = 'AssetPurchaseInvoiceRef')
BEGIN
    ALTER TABLE GNR.VatItem ADD AssetPurchaseInvoiceRef [int] NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('GNR.VatItem') AND [name] = 'AssetSaleRef')
BEGIN
    ALTER TABLE GNR.VatItem ADD AssetSaleRef [int] NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('GNR.VatItem') AND [name] = 'StatusRef')
BEGIN
    ALTER TABLE GNR.VatItem ADD StatusRef [int] NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('GNR.VatItem') AND [name] = 'CustomsClearanceRef')
BEGIN
    ALTER TABLE GNR.VatItem ADD CustomsClearanceRef [int] NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('GNR.VatItem') AND [name] = 'BillOfLoadingRef')
BEGIN
    ALTER TABLE GNR.VatItem ADD BillOfLoadingRef [int] NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('GNR.VatItem') AND [name] = 'InsurancePolicyRef')
BEGIN
    ALTER TABLE GNR.VatItem ADD InsurancePolicyRef [int] NULL
END
GO

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_VatItem')
ALTER TABLE [GNR].[VatItem] ADD  CONSTRAINT [PK_VatItem] PRIMARY KEY CLUSTERED 
(
	[VatItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_VatItem_VatRef')
ALTER TABLE [GNR].[VatItem]  ADD  CONSTRAINT [FK_VatItem_VatRef] FOREIGN KEY([VatRef])
REFERENCES [GNR].[Vat] ([VatID])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_VatItem_InventoryReceiptRef')
ALTER TABLE [GNR].[VatItem]  ADD  CONSTRAINT [FK_VatItem_InventoryReceiptRef] FOREIGN KEY([InventoryReceiptRef])
REFERENCES [INV].[InventoryReceipt] ([InventoryReceiptID])
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects where name = 'FK_VatItem_ServiceInventoryPurchaseInvoiceRef')
ALTER TABLE [GNR].[VatItem]  ADD  CONSTRAINT [FK_VatItem_ServiceInventoryPurchaseInvoiceRef] FOREIGN KEY([ServiceInventoryPurchaseInvoiceRef])
REFERENCES [INV].[InventoryPurchaseInvoice] ([InventoryPurchaseInvoiceID])
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects where name = 'FK_VatItem_AssetPurchaseInvoiceRef')
ALTER TABLE [GNR].[VatItem]  ADD  CONSTRAINT [FK_VatItem_AssetPurchaseInvoiceRef] FOREIGN KEY([AssetPurchaseInvoiceRef])
REFERENCES [INV].[InventoryPurchaseInvoice] ([InventoryPurchaseInvoiceID])
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects where name = 'FK_VatItem_AssetSaleRef')
ALTER TABLE [GNR].[VatItem]  ADD  CONSTRAINT FK_VatItem_AssetSaleRef FOREIGN KEY([AssetSaleRef])
REFERENCES [AST].[Sale] ([SaleID])
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects where name = 'FK_VatItem_ServiceInventoryPurchaseInvoiceRef')
ALTER TABLE [GNR].[VatItem]  ADD  CONSTRAINT [FK_VatItem_ServiceInventoryPurchaseInvoiceRef] FOREIGN KEY([ServiceInventoryPurchaseInvoiceRef])
REFERENCES [INV].[InventoryPurchaseInvoice] ([InventoryPurchaseInvoiceID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_VatItem_InventoryReceiptReturnRef')
ALTER TABLE [GNR].[VatItem]  ADD  CONSTRAINT [FK_VatItem_InventoryReceiptReturnRef] FOREIGN KEY([InventoryReceiptReturnRef])
REFERENCES [INV].[InventoryReceipt] ([InventoryReceiptID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_VatItem_InvoiceRef')
ALTER TABLE [GNR].[VatItem]  ADD  CONSTRAINT [FK_VatItem_InvoiceRef] FOREIGN KEY([InvoiceRef])
REFERENCES [SLS].[Invoice] ([InvoiceId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_VatItem_ReturnedInvoiceRef')
ALTER TABLE [GNR].[VatItem]  ADD  CONSTRAINT [FK_VatItem_ReturnedInvoiceRef] FOREIGN KEY([ReturnedInvoiceRef])
REFERENCES [SLS].[ReturnedInvoice] ([ReturnedInvoiceId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_VatItem_CustomsClearanceRef')
ALTER TABLE [GNR].[VatItem]  ADD  CONSTRAINT [FK_VatItem_CustomsClearanceRef] FOREIGN KEY([CustomsClearanceRef])
REFERENCES [POM].[CustomsClearance] ([CustomsClearanceID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_VatItem_BillOfLoadingRef')
ALTER TABLE [GNR].[VatItem]  ADD  CONSTRAINT [FK_VatItem_BillOfLoadingRef] FOREIGN KEY([BillOfLoadingRef])
REFERENCES [POM].[BillOfLoading] ([BillOfLoadingID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_VatItem_InsurancePolicyRef')
ALTER TABLE [GNR].[VatItem]  ADD  CONSTRAINT [FK_VatItem_InsurancePolicyRef] FOREIGN KEY([InsurancePolicyRef])
REFERENCES [POM].[InsurancePolicy] ([InsurancePolicyID])
GO

--<< DROP OBJECTS >>--
