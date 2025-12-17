IF OBJECT_ID('INV.VoucherItemTracking') IS NULL
	CREATE TABLE [INV].[VoucherItemTracking](
		VoucherItemTrackingID            INT            NOT NULL,
		Serial				             NVARCHAR(250)  NOT NULL,
		InvoiceItemRef                   INT                NULL,
		ReturnedInvoiceItemRef           INT                NULL,
		InventoryReceiptItemRef          INT                NULL,
		InventoryDeliveryItemRef         INT                NULL,
	) ON [PRIMARY]
GO
IF OBJECT_ID('INV.PK_VoucherItemTracking') IS NULL
	ALTER TABLE [INV].[VoucherItemTracking] ADD  CONSTRAINT [PK_VoucherItemTracking] PRIMARY KEY CLUSTERED ([VoucherItemTrackingID] ASC) ON [PRIMARY]
GO

--<< ADD COLUMNS >>--
IF COLUMNPROPERTY(OBJECT_ID('INV.VoucherItemTracking') , 'InvoiceItemRef', 'AllowsNull') IS NULL
	ALTER TABLE [INV].[VoucherItemTracking] ADD InvoiceItemRef INT NULL
GO

IF COLUMNPROPERTY(OBJECT_ID('INV.VoucherItemTracking') , 'ReturnedInvoiceItemRef', 'AllowsNull') IS NULL
	ALTER TABLE [INV].[VoucherItemTracking] ADD ReturnedInvoiceItemRef INT NULL
GO

IF COLUMNPROPERTY(OBJECT_ID('INV.VoucherItemTracking') , 'InventoryReceiptItemRef', 'AllowsNull') IS NULL
	ALTER TABLE [INV].[VoucherItemTracking] ADD InventoryReceiptItemRef INT NULL
GO

IF COLUMNPROPERTY(OBJECT_ID('INV.VoucherItemTracking') , 'InventoryDeliveryItemRef', 'AllowsNull') IS NULL
	ALTER TABLE [INV].[VoucherItemTracking] ADD InventoryDeliveryItemRef INT NULL
GO

--<< FOREIGNKEYS DEFINITION >>--
If OBJECT_ID('INV.FK_VoucherItemTracking_InvoiceItemRef') IS NULL
	ALTER TABLE [INV].[VoucherItemTracking]  ADD  CONSTRAINT [FK_VoucherItemTracking_InvoiceItemRef] FOREIGN KEY([InvoiceItemRef])
REFERENCES [SLS].[InvoiceItem] ([InvoiceItemID])
ON DELETE CASCADE
GO

If OBJECT_ID('INV.FK_VoucherItemTracking_ReturnedInvoiceItemRef') IS NULL
	ALTER TABLE [INV].[VoucherItemTracking]  ADD  CONSTRAINT [FK_VoucherItemTracking_ReturnedInvoiceItemRef] FOREIGN KEY([ReturnedInvoiceItemRef])
REFERENCES [SLS].[ReturnedInvoiceItem] ([ReturnedInvoiceItemID])
ON DELETE CASCADE
GO

If OBJECT_ID('INV.FK_VoucherItemTracking_InventoryReceiptItemRef') IS NULL
	ALTER TABLE [INV].[VoucherItemTracking]  ADD  CONSTRAINT [FK_VoucherItemTracking_InventoryReceiptItemRef] FOREIGN KEY([InventoryReceiptItemRef])
REFERENCES [INV].[InventoryReceiptItem] ([InventoryReceiptItemID])
ON DELETE CASCADE
GO

If OBJECT_ID('INV.FK_VoucherItemTracking_InventoryDeliveryItemRef') IS NULL
	ALTER TABLE [INV].[VoucherItemTracking]  ADD  CONSTRAINT [FK_VoucherItemTracking_InventoryDeliveryItemRef] FOREIGN KEY([InventoryDeliveryItemRef])
REFERENCES [INV].[InventoryDeliveryItem] ([InventoryDeliveryItemID])
ON DELETE CASCADE
GO

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM SYS.INDEXES WHERE NAME = 'IX_VoucherItemTracking_InvoiceItemRef')
	CREATE NONCLUSTERED INDEX [IX_VoucherItemTracking_InvoiceItemRef] ON [INV].[VoucherItemTracking] ([InvoiceItemRef] ASC) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT 1 FROM SYS.INDEXES WHERE NAME = 'IX_VoucherItemTracking_ReturnedInvoiceItemRef')
	CREATE NONCLUSTERED INDEX [IX_VoucherItemTracking_ReturnedInvoiceItemRef] ON [INV].[VoucherItemTracking] ([ReturnedInvoiceItemRef] ASC) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT 1 FROM SYS.INDEXES WHERE NAME = 'IX_VoucherItemTracking_InventoryReceiptItemRef')
	CREATE NONCLUSTERED INDEX [IX_VoucherItemTracking_InventoryReceiptItemRef] ON [INV].[VoucherItemTracking] ([InventoryReceiptItemRef] ASC) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT 1 FROM SYS.INDEXES WHERE NAME = 'IX_VoucherItemTracking_InventoryDeliveryItemRef')
	CREATE NONCLUSTERED INDEX [IX_VoucherItemTracking_InventoryDeliveryItemRef] ON [INV].[VoucherItemTracking] ([InventoryDeliveryItemRef] ASC) ON [PRIMARY]
GO

--<< CONSTRAINT CHECKS DEFINITION >>--

IF OBJECT_ID('INV.[CK_VoucherItemTracking_VoucherExistance]', 'C') IS NULL 
ALTER TABLE INV.VoucherItemTracking ADD CONSTRAINT
	CK_VoucherItemTracking_VoucherExistance CHECK (
			SIGN(ISNULL(InvoiceItemRef                   ,0)) + 
			SIGN(ISNULL(ReturnedInvoiceItemRef           ,0)) + 
			SIGN(ISNULL(InventoryReceiptItemRef          ,0)) + 
			SIGN(ISNULL(InventoryDeliveryItemRef         ,0)) = 1
			)
GO