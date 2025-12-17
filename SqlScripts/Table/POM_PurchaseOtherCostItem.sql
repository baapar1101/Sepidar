--<<FileName:POM_PurchaseOtherCostItem.sql>>--
--<< TABLE DEFINITION >>--

IF Object_ID('POM.PurchaseOtherCostItem') IS NULL
  CREATE TABLE [POM].[PurchaseOtherCostItem](
	[PurchaseOtherCostItemID] [int] NOT NULL,
	[RowNumber] [int] NOT NULL,
	[PurchaseCostRef] [int] NOT NULL,
	[ServiceInventoryPurchaseInvoiceItemRef] [int] NOT NULL,
	[CostServiceAccountSLRef] [int] NULL,
	[AmountInBaseCurrency] [decimal](19, 4) NOT NULL,
	[EffectiveAmountInBaseCurrency] [decimal](19, 4) NOT NULL,
	[AllotmentType] [int] NOT NULL,
	[Version] [int] NOT NULL,
	
) ON [PRIMARY]

GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--

--<< ALTER COLUMNS >>--
if exists (select 1 from sys.columns where object_id=object_id('POM.PurchaseOtherCostItem') and [name] = 'EffectiveAmount')
begin
alter table POM.PurchaseOtherCostItem drop column EffectiveAmount
end

GO

if exists (select 1 from sys.columns where object_id=object_id('POM.PurchaseOtherCostItem') and [name] = 'Amount')
begin
alter table POM.PurchaseOtherCostItem drop column Amount
end

GO


--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_PurchaseOtherCostItem')
ALTER TABLE [POM].[PurchaseOtherCostItem] ADD  CONSTRAINT [PK_PurchaseOtherCostItem] PRIMARY KEY CLUSTERED 
(
	[PurchaseOtherCostItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_PurchaseOtherCostItem_ServiceInventoryPurchaseInvoiceItem')
CREATE NONCLUSTERED INDEX [IX_PurchaseOtherCostItem_ServiceInventoryPurchaseInvoiceItem]
ON [POM].[PurchaseOtherCostItem] ([ServiceInventoryPurchaseInvoiceItemRef])

GO

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_PurchaseOtherCostItem_PurchaseCost')
ALTER TABLE [POM].[PurchaseOtherCostItem]  ADD  CONSTRAINT [FK_PurchaseOtherCostItem_PurchaseCost] FOREIGN KEY([PurchaseCostRef])
REFERENCES [POM].[PurchaseCost] ([PurchaseCostID])
ON DELETE CASCADE

GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_PurchaseOtherCostItem_ServiceInventoryPurchaseInvoiceItem')
ALTER TABLE [POM].[PurchaseOtherCostItem]  ADD  CONSTRAINT [FK_PurchaseOtherCostItem_ServiceInventoryPurchaseInvoiceItem] FOREIGN KEY([ServiceInventoryPurchaseInvoiceItemRef])
REFERENCES INV.[InventoryPurchaseInvoiceItem] ([InventoryPurchaseInvoiceItemID])

GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_PurchaseOtherCostItem_CostServiceAccountSL')
ALTER TABLE [POM].[PurchaseOtherCostItem]  ADD  CONSTRAINT [FK_PurchaseOtherCostItem_CostServiceAccountSL] FOREIGN KEY([CostServiceAccountSLRef])
REFERENCES [ACC].[Account] ([AccountID])

GO

--<< DROP OBJECTS >>--
