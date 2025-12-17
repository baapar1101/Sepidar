--<<FileName:POM_InsurancePolicyItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('POM.InsurancePolicyItem') Is Null
CREATE TABLE [POM].[InsurancePolicyItem](
	[InsurancePolicyItemID] [int] NOT NULL,
	[InsurancePolicyRef] [int] NOT NULL,
	[RowNumber] [int] NOT NULL,
	[BasePurchaseOrderItemRef] [int] NOT NULL,
	[Price] [decimal](19, 4) NOT NULL,
	[PriceInBaseCurrency] [decimal](19,4) NULL,
	[Description] [nvarchar](500) NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

GO

--<< ADD CLOLUMNS >>--

--<<Sample>>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_InsurancePolicyItem')
ALTER TABLE [POM].[InsurancePolicyItem] ADD CONSTRAINT [PK_InsurancePolicyItem] PRIMARY KEY CLUSTERED 
(
	[InsurancePolicyItemID] ASC
) ON [PRIMARY]

GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_InsurancePolicyItem_BasePurchaseOrderItemRef')
CREATE NONCLUSTERED INDEX [IX_InsurancePolicyItem_BasePurchaseOrderItemRef]
ON [POM].[InsurancePolicyItem] ([BasePurchaseOrderItemRef])

GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_InsurancePolicyItem_InsurancePolicy')
ALTER TABLE POM.InsurancePolicyItem  ADD  CONSTRAINT [FK_InsurancePolicyItem_InsurancePolicy] FOREIGN KEY([InsurancePolicyRef])
REFERENCES POM.InsurancePolicy ([InsurancePolicyID])
ON DELETE CASCADE

GO

If not Exists (select 1 from sys.objects where name = 'FK_InsurancePolicyItem_PurchaseOrderItem')
ALTER TABLE POM.InsurancePolicyItem ADD CONSTRAINT FK_InsurancePolicyItem_PurchaseOrderItem FOREIGN KEY	( BasePurchaseOrderItemRef ) 
REFERENCES POM.PurchaseOrderItem ( PurchaseOrderItemID )
	 ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION

GO

