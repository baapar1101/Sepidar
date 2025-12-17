--<<FileName:AST_AssetRelatedInvoice.sql>>--
--<< TABLE DEFINITION >>--
         
If Object_ID('AST.AssetRelatedPurchaseInvoice') Is Null
CREATE TABLE [AST].[AssetRelatedPurchaseInvoice](
	[AssetRelatedPurchaseInvoiceId]					[INT]					NOT NULL,
	[AssetPurchaseInvoiceItemRef]					[INT]					NULL,
	[PurchaseInvoiceItemRef]					    [INT]					NULL,
	[AcquisitionReceiptItemRef]						[INT]			        NULL,
	[RepairItemRef]									[INT]			        NULL,
	[Price]											[Decimal](19, 4)		NOT NULL,
	[PriceInBaseCurrency]							[Decimal](19, 4)		NOT NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
 
--<<Sample>>--
if not exists (select 1 from sys.columns where object_id=object_id('AST.AssetRelatedPurchaseInvoice') and
				[name] = 'PriceInBaseCurrency')
begin
    Alter table AST.AssetRelatedPurchaseInvoice Add PriceInBaseCurrency [Decimal](19, 4) NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('AST.AssetRelatedPurchaseInvoice') and
				[name] = 'AssetPurchaseInvoiceItemRef')
begin
    Alter table AST.AssetRelatedPurchaseInvoice Add AssetPurchaseInvoiceItemRef [INT] NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('AST.AssetRelatedPurchaseInvoice') and
				[name] = 'PurchaseInvoiceItemRef')
begin
    Alter table AST.AssetRelatedPurchaseInvoice Add PurchaseInvoiceItemRef [INT] NULL
end
GO

--<< ALTER COLUMNS >>--

if exists (select 1 from sys.columns where object_id=object_id('AST.AssetRelatedPurchaseInvoice') and
				[name] = 'AssetPurchaseInvoiceItemRef')
begin
    Alter table AST.AssetRelatedPurchaseInvoice Alter Column AssetPurchaseInvoiceItemRef [INT] NULL
end
GO

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_AssetRelatedPurchaseInvoice')
	ALTER TABLE [AST].[AssetRelatedPurchaseInvoice] ADD  CONSTRAINT [PK_AssetRelatedPurchaseInvoice] 
		PRIMARY KEY CLUSTERED (	[AssetRelatedPurchaseInvoiceId] ASC	) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
 
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_AST_AssetRelatedPurchaseInvoice_InventoryPurchaseInvoiceItem_AssetPurchaseInvoiceItemRef')
	ALTER TABLE [AST].[AssetRelatedPurchaseInvoice]  ADD  CONSTRAINT [FK_AST_AssetRelatedPurchaseInvoice_InventoryPurchaseInvoiceItem_AssetPurchaseInvoiceItemRef] 
		FOREIGN KEY([AssetPurchaseInvoiceItemRef])
		REFERENCES [INV].[InventoryPurchaseInvoiceItem] ([InventoryPurchaseInvoiceItemId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_AST_AssetRelatedPurchaseInvoice_PurchaseInvoiceItem_PurchaseInvoiceItemRef')
	ALTER TABLE [AST].[AssetRelatedPurchaseInvoice]  ADD  CONSTRAINT FK_AST_AssetRelatedPurchaseInvoice_PurchaseInvoiceItem_PurchaseInvoiceItemRef 
		FOREIGN KEY([PurchaseInvoiceItemRef])
		REFERENCES [POM].[PurchaseInvoiceItem] ([PurchaseInvoiceItemId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_AST_AssetRelatedPurchaseInvoice_AcquisitionReceiptItem_AcquisitionReceiptItemRef')
	ALTER TABLE [AST].[AssetRelatedPurchaseInvoice]  ADD  CONSTRAINT [FK_AST_AssetRelatedPurchaseInvoice_AcquisitionReceiptItem_AcquisitionReceiptItemRef] 
		FOREIGN KEY([AcquisitionReceiptItemRef])
		REFERENCES [AST].[AcquisitionReceiptItem] ([AcquisitionReceiptItemId])
		ON DELETE CASCADE

GO

If not Exists (select 1 from sys.objects where name = 'FK_AST_AssetRelatedPurchaseInvoice_RepairItem_RepairItemRef')
	ALTER TABLE [AST].[AssetRelatedPurchaseInvoice]  ADD  CONSTRAINT [FK_AST_AssetRelatedPurchaseInvoice_RepairItem_RepairItemRef] 
		FOREIGN KEY([RepairItemRef])
		REFERENCES [AST].[RepairItem] ([RepairItemId])
		ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--

If  Exists (select 1 from sys.objects where name = 'FK_AST_AssetRelatedPurchaseInvoice_InventoryPurchaseInvoiceItem_InventoryPurchaseInvoiceItemRef')
	ALTER TABLE [AST].[AssetRelatedPurchaseInvoice]  Drop  CONSTRAINT [FK_AST_AssetRelatedPurchaseInvoice_InventoryPurchaseInvoiceItem_InventoryPurchaseInvoiceItemRef] 

GO
if  exists (select 1 from sys.columns where object_id=object_id('AST.AssetRelatedPurchaseInvoice') and
				[name] = 'InventoryPurchaseInvoiceItemRef')
begin
    Alter table AST.AssetRelatedPurchaseInvoice Drop Column InventoryPurchaseInvoiceItemRef 
end
GO