--<<FileName:CNT_ContractRelatedPurchaseInvoice.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('CNT.ContractRelatedPurchaseInvoice') Is Null
CREATE TABLE [CNT].[ContractRelatedPurchaseInvoice](
	[ContractRelatedPurchaseInvoiceId]		[INT]					NOT NULL,
	[PurchaseInvoiceRef]					[INT]					NOT NULL,
	[TenderRef]								[INT]			        NOT NULL,	
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
 
--<<Sample>>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ContractRelatedPurchaseInvoice')
	ALTER TABLE [CNT].[ContractRelatedPurchaseInvoice] ADD  CONSTRAINT [PK_ContractRelatedPurchaseInvoice] 
		PRIMARY KEY CLUSTERED (	[ContractRelatedPurchaseInvoiceId] ASC	) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
 
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_CNT_ContractRelatedPurchaseInvoice_InventoryPurchaseInvoice_PurchaseInvoiceRef')
	ALTER TABLE [CNT].[ContractRelatedPurchaseInvoice]  ADD  CONSTRAINT [FK_CNT_ContractRelatedPurchaseInvoice_InventoryPurchaseInvoice_PurchaseInvoiceRef] 
		FOREIGN KEY([PurchaseInvoiceRef])
		REFERENCES [INV].[InventoryPurchaseInvoice] ([InventoryPurchaseInvoiceId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_CNT_ContractRelatedPurchaseInvoice_Tender_TenderRef')
	ALTER TABLE [CNT].[ContractRelatedPurchaseInvoice]  ADD  CONSTRAINT [FK_CNT_ContractRelatedPurchaseInvoice_Tender_TenderRef] 
		FOREIGN KEY([TenderRef])
		REFERENCES [CNT].[Tender] ([TenderId])
		ON DELETE CASCADE

GO



--<< DROP OBJECTS >>--
