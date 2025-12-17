--<<FileName:GNR_MarketingDisketteItem.sql>>--
--<< TABLE DEFINITION >>--
If Object_ID('GNR.MarketingDisketteItem') Is Null
CREATE TABLE [GNR].[MarketingDisketteItem](
	[MarketingDisketteItemID] [int] NOT NULL,
	[MarketingDisketteRef] [int] NOT NULL,
	[InvoiceRef] [int] NULL,
	[ReturnedInvoiceRef] [int] NULL,
	[InventoryReceiptRef] [int] NULL,
	[ReturnedInventoryReceiptRef] [int] NULL,
	[ServiceInventoryPurchaseInvoiceRef] [int] NULL,
	[StatusRef] [int] NULL,
	[UsedInDiskette] bit NOT NULL,
	EntityFullName varchar(500),
	ISDealTypeLowerThanTenPercent Bit Null,
	IsRefusal [bit] NULL,
	IsTransport [bit] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('GNR.MarketingDisketteItem') 
							and [name] = 'ServiceInventoryPurchaseInvoiceRef')
    ALTER TABLE GNR.MarketingDisketteItem Add [ServiceInventoryPurchaseInvoiceRef] [int] NULL
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('GNR.MarketingDisketteItem') 
							and [name] = 'StatusRef')
    ALTER TABLE GNR.MarketingDisketteItem Add [StatusRef] [int] NULL
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('GNR.MarketingDisketteItem') 
							and [name] = 'IsRefusal')
    ALTER TABLE GNR.MarketingDisketteItem Add [IsRefusal] [bit] NULL
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('GNR.MarketingDisketteItem') 
							and [name] = 'IsTransport')
    ALTER TABLE GNR.MarketingDisketteItem Add IsTransport [bit] NULL
GO

--<< ALTER COLUMNS >>--

If not Exists (select name from sys.columns where name = 'ISDealTypeLowerThanTenPercent')
  ALTER TABLE [GNR].[MarketingDisketteItem] 
    Add ISDealTypeLowerThanTenPercent Bit Null
GO

--<< PRIMARYKEY DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'PK_MarketingDisketteItem')
ALTER TABLE [GNR].[MarketingDisketteItem] ADD  CONSTRAINT [PK_MarketingDisketteItem] PRIMARY KEY CLUSTERED 
(
	[MarketingDisketteItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_MarketingDisketteItem_MarketingDisketteRef')
ALTER TABLE [GNR].[MarketingDisketteItem]  ADD  CONSTRAINT [FK_MarketingDisketteItem_MarketingDisketteRef] FOREIGN KEY([MarketingDisketteRef])
REFERENCES [GNR].[MarketingDiskette] ([MarketingDisketteID])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_MarketingDisketteItem_InventoryReceiptRef')
ALTER TABLE [GNR].[MarketingDisketteItem]  ADD  CONSTRAINT [FK_MarketingDisketteItem_InventoryReceiptRef] FOREIGN KEY([InventoryReceiptRef])
REFERENCES [INV].[InventoryReceipt] ([InventoryReceiptID])
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects where name = 'FK_MarketingDisketteItem_ServiceInventoryPurchaseInvoiceRef')
ALTER TABLE [GNR].[MarketingDisketteItem]  ADD  CONSTRAINT [FK_MarketingDisketteItem_ServiceInventoryPurchaseInvoiceRef] FOREIGN KEY([ServiceInventoryPurchaseInvoiceRef])
REFERENCES [INV].[InventoryPurchaseInvoice] ([InventoryPurchaseInvoiceID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_MarketingDisketteItem_ReturnedInventoryReceiptRef')
ALTER TABLE [GNR].[MarketingDisketteItem]  ADD  CONSTRAINT [FK_MarketingDisketteItem_ReturnedInventoryReceiptRef] FOREIGN KEY([ReturnedInventoryReceiptRef])
REFERENCES [INV].[InventoryReceipt] ([InventoryReceiptID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_MarketingDisketteItem_InvoiceRef')
ALTER TABLE [GNR].[MarketingDisketteItem]  ADD  CONSTRAINT [FK_MarketingDisketteItem_InvoiceRef] FOREIGN KEY([InvoiceRef])
REFERENCES [SLS].[Invoice] ([InvoiceId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_MarketingDisketteItem_ReturnedInvoiceRef')
ALTER TABLE [GNR].[MarketingDisketteItem]  ADD  CONSTRAINT [FK_MarketingDisketteItem_ReturnedInvoiceRef] FOREIGN KEY([ReturnedInvoiceRef])
REFERENCES [SLS].[ReturnedInvoice] ([ReturnedInvoiceId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_MarketingDisketteItem_StatusRef')
ALTER TABLE [GNR].[MarketingDisketteItem]  ADD  CONSTRAINT [FK_MarketingDisketteItem_StatusRef] FOREIGN KEY([StatusRef])
REFERENCES [CNT].[Status] ([StatusId])
GO
--<< DROP OBJECTS >>--
