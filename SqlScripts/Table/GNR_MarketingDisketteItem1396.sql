--<<FileName:GNR_MarketingDisketteItem1396.sql>>--
--<< TABLE DEFINITION >>--
If Object_ID('GNR.MarketingDisketteItem1396') Is Null
CREATE TABLE [GNR].[MarketingDisketteItem1396](
	[MarketingDisketteItemID] [int] NOT NULL,
	[MarketingDisketteRef] [int] NOT NULL,
	[InvoiceRef] [int] NULL,
	[ReturnedInvoiceRef] [int] NULL,
	[InventoryReceiptRef] [int] NULL,
	[ReturnedInventoryReceiptRef] [int] NULL,
	[ServiceInventoryPurchaseInvoiceRef] [int] NULL,
	[StatusRef] [int] NULL,
	[AssetPurchaseInvoiceRef] [int] NULL,
	[AssetSaleRef] [int] NULL,
	[BillOfLoadingRef] [int] NULL,
	[InsurancePolicyRef] [int] NULL,
	[CustomsClearanceItemRef] [int] NULL,
	[UsedInDiskette] bit NOT NULL,
	EntityFullName varchar(500),
	ISDealTypeLowerThanMinPercent Bit Null, --Less than 5% ?????
	IsTransport [bit] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('GNR.MarketingDisketteItem1396')
												AND [name] = 'AssetPurchaseInvoiceRef')
	ALTER TABLE [GNR].[MarketingDisketteItem1396] ADD  [AssetPurchaseInvoiceRef] [int] NULL
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('GNR.MarketingDisketteItem1396')
												AND [name] = 'AssetSaleRef')
	ALTER TABLE [GNR].[MarketingDisketteItem1396] ADD  [AssetSaleRef] [int] NULL
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('GNR.MarketingDisketteItem1396')
												AND [name] = 'BillOfLoadingRef')
	ALTER TABLE [GNR].[MarketingDisketteItem1396] ADD  [BillOfLoadingRef] [int] NULL
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('GNR.MarketingDisketteItem1396')
												AND [name] = 'InsurancePolicyRef')
	ALTER TABLE [GNR].[MarketingDisketteItem1396] ADD  [InsurancePolicyRef] [int] NULL
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('GNR.MarketingDisketteItem1396')
												AND [name] = 'CustomsClearanceItemRef')
	ALTER TABLE [GNR].[MarketingDisketteItem1396] ADD  [CustomsClearanceItemRef] [int] NULL
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'PK_MarketingDisketteItem1396')
ALTER TABLE [GNR].[MarketingDisketteItem1396] ADD  CONSTRAINT [PK_MarketingDisketteItem1396] PRIMARY KEY CLUSTERED 
(
	[MarketingDisketteItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_MarketingDisketteItem1396_MarketingDisketteRef')
ALTER TABLE [GNR].[MarketingDisketteItem1396]  ADD  CONSTRAINT [FK_MarketingDisketteItem1396_MarketingDisketteRef] FOREIGN KEY([MarketingDisketteRef])
REFERENCES [GNR].[MarketingDiskette1396] ([MarketingDisketteID])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_MarketingDisketteItem1396_InventoryReceiptRef')
ALTER TABLE [GNR].[MarketingDisketteItem1396]  ADD  CONSTRAINT [FK_MarketingDisketteItem1396_InventoryReceiptRef] FOREIGN KEY([InventoryReceiptRef])
REFERENCES [INV].[InventoryReceipt] ([InventoryReceiptID])
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects where name = 'FK_MarketingDisketteItem1396_ServiceInventoryPurchaseInvoiceRef')
ALTER TABLE [GNR].[MarketingDisketteItem1396]  ADD  CONSTRAINT [FK_MarketingDisketteItem1396_ServiceInventoryPurchaseInvoiceRef] FOREIGN KEY([ServiceInventoryPurchaseInvoiceRef])
REFERENCES [INV].[InventoryPurchaseInvoice] ([InventoryPurchaseInvoiceID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_MarketingDisketteItem1396_ReturnedInventoryReceiptRef')
ALTER TABLE [GNR].[MarketingDisketteItem1396]  ADD  CONSTRAINT [FK_MarketingDisketteItem1396_ReturnedInventoryReceiptRef] FOREIGN KEY([ReturnedInventoryReceiptRef])
REFERENCES [INV].[InventoryReceipt] ([InventoryReceiptID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_MarketingDisketteItem1396_InvoiceRef')
ALTER TABLE [GNR].[MarketingDisketteItem1396]  ADD  CONSTRAINT [FK_MarketingDisketteItem1396_InvoiceRef] FOREIGN KEY([InvoiceRef])
REFERENCES [SLS].[Invoice] ([InvoiceId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_MarketingDisketteItem1396_ReturnedInvoiceRef')
ALTER TABLE [GNR].[MarketingDisketteItem1396]  ADD  CONSTRAINT [FK_MarketingDisketteItem1396_ReturnedInvoiceRef] FOREIGN KEY([ReturnedInvoiceRef])
REFERENCES [SLS].[ReturnedInvoice] ([ReturnedInvoiceId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_MarketingDisketteItem1396_StatusRef')
ALTER TABLE [GNR].[MarketingDisketteItem1396]  ADD  CONSTRAINT [FK_MarketingDisketteItem1396_StatusRef] FOREIGN KEY([StatusRef])
REFERENCES [CNT].[Status] ([StatusId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_MarketingDisketteItem1396_AssetPurchaseInvoiceRef')
ALTER TABLE [GNR].[MarketingDisketteItem1396]  ADD  CONSTRAINT [FK_MarketingDisketteItem1396_AssetPurchaseInvoiceRef] FOREIGN KEY([AssetPurchaseInvoiceRef])
REFERENCES [INV].[InventoryPurchaseInvoice] ([InventoryPurchaseInvoiceID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_MarketingDisketteItem1396_AssetSaleRef')
ALTER TABLE [GNR].[MarketingDisketteItem1396]  ADD  CONSTRAINT [FK_MarketingDisketteItem1396_AssetSaleRef] FOREIGN KEY([AssetSaleRef])
REFERENCES [AST].[Sale] ([SaleID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_MarketingDisketteItem1396_BillOfLoading')
ALTER TABLE [GNR].[MarketingDisketteItem1396]  ADD  CONSTRAINT [FK_MarketingDisketteItem1396_BillOfLoading] FOREIGN KEY([BillOfLoadingRef])
REFERENCES [POM].[BillOfLoading] ([BillOfLoadingID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_MarketingDisketteItem1396_InsurancePolicy')
ALTER TABLE [GNR].[MarketingDisketteItem1396]  ADD  CONSTRAINT [FK_MarketingDisketteItem1396_InsurancePolicy] FOREIGN KEY([InsurancePolicyRef])
REFERENCES [POM].[InsurancePolicy] ([InsurancePolicyID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_MarketingDisketteItem1396_CustomsClearanceItem')
ALTER TABLE [GNR].[MarketingDisketteItem1396]  ADD  CONSTRAINT [FK_MarketingDisketteItem1396_CustomsClearanceItem] FOREIGN KEY([CustomsClearanceItemRef])
REFERENCES [POM].[CustomsClearanceItem] ([CustomsClearanceItemID])
GO

--<< DROP OBJECTS >>--
