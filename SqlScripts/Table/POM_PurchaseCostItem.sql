--<<FileName:POM_PurchaseCostItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('POM.PurchaseCostItem') Is Null
CREATE TABLE [POM].[PurchaseCostItem](
	[PurchaseCostItemID] [int] NOT NULL,
	[PurchaseCostRef] [int] NOT NULL,
    [PurchaseInvoiceItemRef] [int] NOT NULL,
	[CommercialOrderItemRef] [int] NULL,
	[InsurancePolicyItemRef] [int] NULL,	
	[PurchaseInvoiceItemNetPriceInBaseCurrency][decimal](19, 4) NOT NULL,
	[TotalCommercialOrder] [decimal](19,4) NOT NULL,
	[TotalCommercialOrderInBaseCurrency] [decimal](19, 4) NOT NULL,
	[TotalInsurancePolicy] [decimal](19, 4) NOT NULL,
	[TotalInsurancePolicyInBaseCurrency] [decimal](19,4) NOT NULL,
	[TotalBillOfLoading] [decimal](19, 4) NOT NULL,
	[TotalBillOfLoadingInBaseCurrency] [decimal](19,4) NOT NULL,
	[TotalCustomsClearance] [decimal](19, 4) NOT NULL,
	[TotalCustomsClearanceInBaseCurrency] [decimal](19,4) NOT NULL,
	[TotalOtherCostsInBaseCurrency] [decimal](19, 4) NOT NULL,
	[AllotmenedAmountInBaseCurrency] [decimal](19, 4) NULL,
	[NetPriceInBaseCurrency] AS CONVERT([decimal](19,4), (PurchaseInvoiceItemNetPriceInBaseCurrency + TotalCommercialOrderInBaseCurrency + TotalInsurancePolicyInBaseCurrency + TotalBillOfLoadingInBaseCurrency + TotalCustomsClearanceInBaseCurrency + TotalOtherCostsInBaseCurrency)) PERSISTED,
	[FinalFeeInBaseCurrency][decimal](19, 4) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[Version] [int] NOT NULL	
) ON [PRIMARY]

GO

--<< ADD CLOLUMNS >>--

--<<Sample>>--

--<< ALTER COLUMNS >>--
if exists (select 1 from sys.columns where object_id=object_id('POM.PurchaseCostItem') and [name] = 'FinalFee')
begin
alter table POM.PurchaseCostItem drop column FinalFee
end

GO

if exists (select 1 from sys.columns where object_id=object_id('POM.PurchaseCostItem') and [name] = 'NetPrice')
begin
alter table POM.PurchaseCostItem drop column NetPrice
end

GO

if exists (select 1 from sys.columns where object_id=object_id('POM.PurchaseCostItem') and [name] = 'TotalOtherCosts')
begin
alter table POM.PurchaseCostItem drop column TotalOtherCosts
end

GO

if not exists (select 1 from sys.columns where object_id=object_id('POM.PurchaseCostItem') and [name] = 'AllotmenedAmountInBaseCurrency')
begin
alter table POM.PurchaseCostItem ADD [AllotmenedAmountInBaseCurrency] [decimal](19, 4) NULL
end

GO


if exists (select 1 from sys.columns where object_id=object_id('POM.PurchaseCostItem') and [name] = 'PurchaseInvoiceItemNetPrice')
begin
alter table POM.PurchaseCostItem drop column PurchaseInvoiceItemNetPrice
end

GO

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_PurchaseCostItem')
ALTER TABLE [POM].[PurchaseCostItem] ADD CONSTRAINT [PK_PurchaseCostItem] PRIMARY KEY CLUSTERED 
(
	[PurchaseCostItemID] ASC
) ON [PRIMARY]

GO

--<< DEFAULTS CHECKS DEFINITION >>--


--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--


IF NOT EXISTS (select 1 from sys.indexes where name = 'IX_PurchaseCostItem_PurchaseInvoiceItem')
CREATE NONCLUSTERED INDEX [IX_PurchaseCostItem_PurchaseInvoiceItem] ON [POM].[PurchaseCostItem] 
(
	[PurchaseInvoiceItemRef] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_PurchaseCostItem_PurchaseCost')
ALTER TABLE POM.PurchaseCostItem ADD CONSTRAINT FK_PurchaseCostItem_PurchaseCost FOREIGN KEY	( PurchaseCostRef ) 
REFERENCES POM.PurchaseCost ( PurchaseCostID )
	 ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
GO

IF NOT Exists (select 1 from sys.objects where name = 'FK_PurchaseCostItem_PurchaseInvoiceItem')
ALTER TABLE [POM].[PurchaseCostItem]  ADD  CONSTRAINT [FK_PurchaseCostItem_PurchaseInvoiceItem] FOREIGN KEY([PurchaseInvoiceItemRef])
REFERENCES [POM].[PurchaseInvoiceItem] ([PurchaseInvoiceItemID])
GO

IF NOT Exists (select 1 from sys.objects where name = 'FK_PurchaseCostItem_CommercialOrderItem')
ALTER TABLE [POM].[PurchaseCostItem]  ADD  CONSTRAINT [FK_PurchaseCostItem_CommercialOrderItem] FOREIGN KEY([CommercialOrderItemRef])
REFERENCES [POM].[CommercialOrderItem] ([CommercialOrderItemID])
GO

IF NOT Exists (select 1 from sys.objects where name = 'FK_PurchaseCostItem_InsurancePolicyItem')
ALTER TABLE [POM].[PurchaseCostItem]  ADD  CONSTRAINT [FK_PurchaseCostItem_InsurancePolicyItem] FOREIGN KEY([InsurancePolicyItemRef])
REFERENCES [POM].[InsurancePolicyItem] ([InsurancePolicyItemID])
GO
