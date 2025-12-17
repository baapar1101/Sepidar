--<<FileName:INV_InventoryReceiptOtherCostItem.sql>>--
--<< TABLE DEFINITION >>--

IF Object_ID('INV.InventoryReceiptOtherCostItem') IS NULL
  CREATE TABLE [INV].[InventoryReceiptOtherCostItem](
	[InventoryReceiptOtherCostItemID] [int] NOT NULL,
	[RowNumber] [int] NOT NULL,
	[InventoryReceiptRef] [int] NOT NULL,
	[ServiceInventoryPurchaseInvoiceItemRef] [int] NOT NULL,
	[CostServiceAccountSLRef] [int] NULL,
	[CostCenterDlRef] [int] NULL,
	[EffectiveAmountInBaseCurrency] [decimal](19, 4) NOT NULL,
	[AllotmentType] [int] NOT NULL
	
) ON [PRIMARY]

GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_InventoryReceiptOtherCostItem')
ALTER TABLE [INV].[InventoryReceiptOtherCostItem] ADD  CONSTRAINT [PK_InventoryReceiptOtherCostItem] PRIMARY KEY CLUSTERED 
(
	[InventoryReceiptOtherCostItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_InventoryReceiptOtherCostItem_ServiceInventoryPurchaseInvoiceItem')
CREATE NONCLUSTERED INDEX [IX_InventoryReceiptOtherCostItem_ServiceInventoryPurchaseInvoiceItem]
ON [INV].[InventoryReceiptOtherCostItem] ([ServiceInventoryPurchaseInvoiceItemRef]) INCLUDE ([EffectiveAmountInBaseCurrency])

GO

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_InventoryReceiptOtherCostItem_InventoryReceiptRef')
ALTER TABLE [INV].[InventoryReceiptOtherCostItem]  ADD  CONSTRAINT [FK_InventoryReceiptOtherCostItem_InventoryReceiptRef] FOREIGN KEY([InventoryReceiptRef])
REFERENCES [INV].[InventoryReceipt] ([InventoryReceiptID])
ON DELETE CASCADE

GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_InventoryReceiptOtherCostItem_ServiceInventoryPurchaseInvoiceItemRef')
ALTER TABLE [INV].[InventoryReceiptOtherCostItem]  ADD  CONSTRAINT [FK_InventoryReceiptOtherCostItem_ServiceInventoryPurchaseInvoiceItemRef] FOREIGN KEY([ServiceInventoryPurchaseInvoiceItemRef])
REFERENCES INV.[InventoryPurchaseInvoiceItem] ([InventoryPurchaseInvoiceItemID])

GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_InventoryReceiptOtherCostItem_CostServiceAccountSLRef')
ALTER TABLE [INV].[InventoryReceiptOtherCostItem]  ADD  CONSTRAINT [FK_InventoryReceiptOtherCostItem_CostServiceAccountSLRef] FOREIGN KEY([CostServiceAccountSLRef])
REFERENCES [ACC].[Account] ([AccountID])

GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_InventoryReceiptOtherCostItem_CostCenterDlRef')
ALTER TABLE [INV].[InventoryReceiptOtherCostItem]  ADD  CONSTRAINT [FK_InventoryReceiptOtherCostItem_CostCenterDlRef] FOREIGN KEY([CostCenterDlRef])
REFERENCES [ACC].[DL] ([DLID])

GO

--<< DROP OBJECTS >>--
