--<<FileName:INV_InventoryReceipt.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('INV.InventoryReceipt') Is Null
CREATE TABLE [INV].[InventoryReceipt](
	[InventoryReceiptID] [int] NOT NULL,
	[IsReturn] [bit] NOT NULL CONSTRAINT [DF_InventoryReceipt_IsReturn]  DEFAULT ((0)),
	[Type] [int] NOT NULL,
	[PurchaseType] [int] NOT NULL CONSTRAINT [DF_InventoryReceipt_PurchaseType] DEFAULT ((1)),
	[StockRef] [int] NOT NULL,
	[DelivererDLRef] [int] NULL,
	[SLAccountRef] [int] NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[AccountingVoucherRef] [int] NULL,
	[PaymentHeaderRef] [int] NULL,
	[TransportBrokerSLAccountRef] [int] NULL,
	[TransporterDLRef] [int] NULL,
	[TotalPrice] [decimal](19, 3) NULL,
	[TotalTax] [decimal](19, 3) NULL,
	[TotalDuty] [decimal](19, 3) NULL,
	[TotalTransportPrice] [decimal](19, 3) NULL,
	[TotalOtherCost] [decimal](19, 3) NULL,
	[TotalNetPrice] [decimal](19, 3) NULL,
	[FiscalYearRef] [int] NOT NULL,
	[CreatorForm] [int] NOT NULL CONSTRAINT [DF_InventoryReceipt_CreatorForm] DEFAULT ((1)),
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL,
	[BasePurchaseInvoiceRef] [int] NULL,
	[BaseInventoryDeliveryRef] [int] NULL,
	[BaseImportPurchaseInvoiceRef] [int] NULL,
	[Description] [nvarchar](4000) NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryReceipt') AND
	[name] = 'Description' )
BEGIN
	ALTER TABLE [INV].[InventoryReceipt] ADD [Description] [nvarchar](4000) NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryReceipt') AND
				[Name] = 'BasePurchaseInvoiceRef')

BEGIN
ALTER TABLE INV.InventoryReceipt ADD BasePurchaseInvoiceRef int NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryReceipt') AND
				[Name] = 'BaseImportPurchaseInvoiceRef')

BEGIN
ALTER TABLE INV.InventoryReceipt ADD BaseImportPurchaseInvoiceRef int NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryReceipt') AND
	[name] = 'AccountingVoucherRef' )
BEGIN
	ALTER TABLE INV.InventoryReceipt ADD AccountingVoucherRef int NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryReceipt') AND
	[name] = 'IsWastage' )
BEGIN
	ALTER TABLE INV.InventoryReceipt ADD IsWastage bit NOT NULL 
	CONSTRAINT DF_InventoryReceipt_IsWastage DEFAULT 0;
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryReceipt') AND
	[name] = 'PaymentHeaderRef' )
	ALTER TABLE INV.InventoryReceipt ADD PaymentHeaderRef INT NULL
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryReceipt') AND
	[name] = 'PurchaseType' )
	ALTER TABLE INV.InventoryReceipt ADD 
		[PurchaseType] [int] NOT NULL CONSTRAINT [DF_InventoryReceipt_PurchaseType] DEFAULT ((1))
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryReceipt') AND
	[name] = 'CreatorForm')
	ALTER TABLE INV.InventoryReceipt ADD 
		[CreatorForm] [int] NOT NULL CONSTRAINT [DF_InventoryReceipt_CreatorForm] DEFAULT ((1))
GO

IF NOT EXISTS (SELECT 1 FROM sys.all_columns C
					JOIN sys.default_constraints D on C.default_object_id = D.object_id
				WHERE C.object_id = object_id('INV.InventoryReceipt')
					AND C.[name] = 'CreatorForm' 
				)
	ALTER TABLE [INV].[InventoryReceipt]
		ADD  CONSTRAINT [DF_InventoryReceipt_CreatorForm]  DEFAULT ((1)) FOR [CreatorForm]
GO
--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('INV.InventoryReceipt') and
				[name] = 'ColumnName')
begin
    Alter table INV.InventoryReceipt Add ColumnName DataType Nullable
end
GO*/

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryReceipt') AND
			[name] = 'TotalPrice')
	ALTER TABLE INV.InventoryReceipt
		ADD [TotalPrice] [decimal](19, 3) NULL

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryReceipt') AND
			[name] = 'TotalTax')
	ALTER TABLE INV.InventoryReceipt
		ADD [TotalTax] [decimal](19, 3) NULL

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryReceipt') AND
			[name] = 'TotalDuty')
	ALTER TABLE INV.InventoryReceipt
		ADD [TotalDuty] [decimal](19, 3) NULL

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryReceipt') AND
			[name] = 'TotalTransportPrice')
	ALTER TABLE INV.InventoryReceipt
		ADD [TotalTransportPrice] [decimal](19, 3) NULL

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryReceipt') AND
			[name] = 'TotalOtherCost')
	ALTER TABLE INV.InventoryReceipt
		ADD [TotalOtherCost] [decimal](19, 3) NULL

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryReceipt') AND
			[name] = 'TotalNetPrice')
	ALTER TABLE INV.InventoryReceipt
		ADD [TotalNetPrice] [decimal](19, 3) NULL
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryReceipt') AND
			[name] = 'TotalReturnedPrice')
	ALTER TABLE INV.InventoryReceipt
		ADD [TotalReturnedPrice] [decimal](19, 4) NULL

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryReceipt') AND
			[name] = 'TotalReturnedNetPrice')
	ALTER TABLE INV.InventoryReceipt
		ADD [TotalReturnedNetPrice] [decimal](19, 4) NULL
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryReceipt') AND
			[name] = 'TransportBrokerSLAccountRef')
	ALTER TABLE INV.InventoryReceipt
		ADD [TransportBrokerSLAccountRef] [int] NULL
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryReceipt') AND
			[name] = 'TransporterDLRef')
	ALTER TABLE INV.InventoryReceipt
		ADD 	[TransporterDLRef] [int] NULL
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryReceipt') AND
	[name] = 'BaseInventoryDeliveryRef' )
	ALTER TABLE INV.InventoryReceipt
		ADD [BaseInventoryDeliveryRef] [int] NULL
GO
--<< ALTER COLUMNS >>--

IF EXISTS (SELECT 1 FROM sys.columns WHERE  object_id=object_id('INV.InventoryReceipt') AND
	[Name] = 'PurchaseType' AND is_nullable=1)
BEGIN
	UPDATE INV.InventoryReceipt SET PurchaseType = 1 WHERE PurchaseType IS NULL

	ALTER TABLE INV.InventoryReceipt ALTER COLUMN PurchaseType
		[int] NOT NULL
END

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ItemReceipt')
ALTER TABLE [INV].[InventoryReceipt] ADD  CONSTRAINT [PK_ItemReceipt] PRIMARY KEY CLUSTERED 
(
	[InventoryReceiptID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'DF_InventoryReceipt_IsReturn')
	ALTER TABLE INV.InventoryReceipt
	ADD CONSTRAINT [DF_InventoryReceipt_IsReturn]  DEFAULT ((0)) FOR IsReturn

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'DF_InventoryReceipt_PurchaseType')
	ALTER TABLE INV.InventoryReceipt
		ADD CONSTRAINT [DF_InventoryReceipt_PurchaseType] DEFAULT ((1)) FOR PurchaseType

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_InventoryReceipt_AccountingVoucherRef')
	CREATE NONCLUSTERED INDEX IX_InventoryReceipt_AccountingVoucherRef
ON [INV].[InventoryReceipt] ([AccountingVoucherRef])
GO 

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_InventoryReceipt_Account')
ALTER TABLE [INV].[InventoryReceipt]  ADD  CONSTRAINT [FK_InventoryReceipt_Account] FOREIGN KEY([SLAccountRef])
REFERENCES [ACC].[Account] ([AccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_InventoryReceipt_DL')
ALTER TABLE [INV].[InventoryReceipt]  ADD  CONSTRAINT [FK_InventoryReceipt_DL] FOREIGN KEY([DelivererDLRef])
REFERENCES [ACC].[DL] ([DLId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_InventoryReceipt_FiscalYear')
ALTER TABLE [INV].[InventoryReceipt]  ADD  CONSTRAINT [FK_InventoryReceipt_FiscalYear] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_InventoryReceipt_Stock')
ALTER TABLE [INV].[InventoryReceipt]  ADD  CONSTRAINT [FK_InventoryReceipt_Stock] FOREIGN KEY([StockRef])
REFERENCES [INV].[Stock] ([StockID])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE Name= 'FK_InventoryReceipt_InventoryPurchaseInvoice')
ALTER TABLE INV.InventoryReceipt ADD CONSTRAINT FK_InventoryReceipt_InventoryPurchaseInvoice FOREIGN KEY
	( BasePurchaseInvoiceRef ) REFERENCES INV.InventoryPurchaseInvoice ( InventoryPurchaseInvoiceID )
	 ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE Name= 'FK_InventoryReceipt_ImportPurchaseInvoice')
ALTER TABLE INV.InventoryReceipt ADD CONSTRAINT FK_InventoryReceipt_ImportPurchaseInvoice FOREIGN KEY
	( BaseImportPurchaseInvoiceRef ) REFERENCES POM.PurchaseInvoice ( PurchaseInvoiceID )
	 ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE Name= 'FK_InventoryReceipt_Voucher')
	ALTER TABLE INV.InventoryReceipt ADD CONSTRAINT FK_InventoryReceipt_Voucher FOREIGN KEY ( AccountingVoucherRef )
	REFERENCES ACC.Voucher ( VoucherId ) ON UPDATE  NO ACTION  ON DELETE  NO ACTION 
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE Name= 'FK_InventoryReceipt_PaymentHeader')
	ALTER TABLE [INV].[InventoryReceipt]  WITH CHECK ADD  CONSTRAINT [FK_InventoryReceipt_PaymentHeader] FOREIGN KEY([PaymentHeaderRef])
	REFERENCES [RPA].[PaymentHeader] ([PaymentHeaderId])
GO


If not Exists (select 1 from sys.objects where name = 'FK_InventoryReceipt_TransportBrokerAccount')
    ALTER TABLE [INV].[InventoryReceipt]  ADD  CONSTRAINT [FK_InventoryReceipt_TransportBrokerAccount] FOREIGN KEY([TransportBrokerSLAccountRef])
    REFERENCES [ACC].[Account] ([AccountId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_InventoryReceipt_TransporterDL')
    ALTER TABLE [INV].[InventoryReceipt]  ADD  CONSTRAINT [FK_InventoryReceipt_TransporterDL] FOREIGN KEY([TransporterDLRef])
    REFERENCES [ACC].[DL] ([DLId])
GO

If not Exists (select 1 from sys.objects where name = 'FK_InventoryReceipt_InventoryDelivery')
    ALTER TABLE [INV].[InventoryReceipt]  ADD  CONSTRAINT [FK_InventoryReceipt_InventoryDelivery] FOREIGN KEY([BaseInventoryDeliveryRef])
    REFERENCES [INV].[InventoryDelivery] ([InventoryDeliveryID])
GO
--<< DROP OBJECTS >>--
