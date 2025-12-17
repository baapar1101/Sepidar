If Object_ID('INV.ServiceInventoryPurchaseInvoiceInventoryReceipt') Is NOT Null
	DROP TABLE INV.ServiceInventoryPurchaseInvoiceInventoryReceipt

----<<FileName:INV_ServiceInventoryPurchaseInvoiceInventoryReceipt.sql>>--
----<< TABLE DEFINITION >>--

--If Object_ID('INV.ServiceInventoryPurchaseInvoiceInventoryReceipt') Is Null
--  CREATE TABLE [INV].[ServiceInventoryPurchaseInvoiceInventoryReceipt](
--	[ServiceInventoryPurchaseInvoiceInventoryReceiptID] [int] NOT NULL,
--	[InventoryReceiptRef] [int] NOT NULL,
--	[ServiceInventoryPurchaseInvoiceRef] [int] NOT NULL
	
--) ON [PRIMARY]

----TEXTIMAGE_ON [SGBlob_Data]
----When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
--GO
----<< ADD CLOLUMNS >>--

----<<Sample>>--
--/*if not exists (select 1 from sys.columns where object_id=object_id('INV.InventoryReceiptOtherCosts') and
--				[name] = 'ColumnName')
--begin
--    Alter table INV.InventoryReceiptOtherCosts Add ColumnName DataType Nullable
--end
--GO*/

----<< ALTER COLUMNS >>--

----<< PRIMARYKEY DEFINITION >>--

--If not Exists (select 1 from sys.objects where name = 'PK_ServiceInventoryPurchaseInvoiceInventoryReceiptID')
--ALTER TABLE [INV].[ServiceInventoryPurchaseInvoiceInventoryReceipt] ADD  CONSTRAINT [PK_ServiceInventoryPurchaseInvoiceInventoryReceiptID] PRIMARY KEY CLUSTERED 
--(
--	[ServiceInventoryPurchaseInvoiceInventoryReceiptID] ASC
--) ON [PRIMARY]
--GO

----<< DEFAULTS CHECKS DEFINITION >>--

----<< RULES DEFINITION >>--

----<< INDEXES DEFINITION >>--


----<< FOREIGNKEYS DEFINITION >>--

--IF NOT EXISTS (select 1 from sys.objects where name = 'FK_ServiceInventoryPurchaseInvoiceInventoryReceipt_InventoryReceiptRef')
--ALTER TABLE [INV].[ServiceInventoryPurchaseInvoiceInventoryReceipt]  ADD  CONSTRAINT [FK_ServiceInventoryPurchaseInvoiceInventoryReceipt_InventoryReceiptRef] FOREIGN KEY([InventoryReceiptRef])
--REFERENCES [INV].[InventoryReceipt] ([InventoryReceiptID])
--ON DELETE CASCADE
--GO

--IF NOT EXISTS (select 1 from sys.objects where name = 'FK_ServiceInventoryPurchaseInvoiceInventoryReceipt_ServiceInventoryPurchaseInvoiceRef')
--ALTER TABLE [INV].[ServiceInventoryPurchaseInvoiceInventoryReceipt]  ADD  CONSTRAINT [FK_ServiceInventoryPurchaseInvoiceInventoryReceipt_ServiceInventoryPurchaseInvoiceRef] FOREIGN KEY([ServiceInventoryPurchaseInvoiceRef])
--REFERENCES INV.InventoryPurchaseInvoice ([InventoryPurchaseInvoiceID])
--GO

----<< DROP OBJECTS >>--