--<<FileName:INV_InventoryDelivery.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('INV.InventoryDelivery') Is Null
CREATE TABLE [INV].[InventoryDelivery](
	[InventoryDeliveryID] [int] NOT NULL,
	[IsReturn] [bit] NOT NULL CONSTRAINT [DF_InventoryDelivery_IsReturn]  DEFAULT ((0)),
	[Type] [int] NOT NULL,
	[StockRef] [int] NOT NULL,
	[ReceiverDLRef] [int] NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[TotalPrice] [decimal](19, 4) NULL,
	[AccountingVoucherRef] [int] NULL,
	[FiscalYearRef] [int] NOT NULL,
	[DestinationStockRef] [int] NULL,
	[CreatorForm] [int] NOT NULL CONSTRAINT [DF_InventoryDelivery_CreatorForm] DEFAULT ((1)),
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL,
	[Description] [nvarchar](4000) NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('INV.InventoryDelivery') and
				[name] = 'ColumnName')
begin
    Alter table INV.InventoryDelivery Add ColumnName DataType Nullable
end
GO*/

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryDelivery') AND
	[name] = 'Description' )
BEGIN
	ALTER TABLE INV.InventoryDelivery ADD [Description] [nvarchar](4000) NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryDelivery') AND
	[name] = 'AccountingVoucherRef' )
BEGIN
	ALTER TABLE INV.InventoryDelivery ADD AccountingVoucherRef int NULL
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryDelivery') AND
	[name] = 'TotalPrice' )
BEGIN
	ALTER TABLE INV.InventoryDelivery ADD TotalPrice [decimal](19, 4) NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryDelivery') AND
	[name] = 'CreatorForm' )
	ALTER TABLE INV.InventoryDelivery ADD 
		[CreatorForm] [int] NOT NULL CONSTRAINT [DF_InventoryDelivery_CreatorForm] DEFAULT ((1))
GO

IF NOT EXISTS (SELECT 1 FROM sys.all_columns C
					JOIN sys.default_constraints D on C.default_object_id = D.object_id
				WHERE C.object_id = object_id('INV.InventoryDelivery')
					AND C.[name] = 'CreatorForm' 
				)
	ALTER TABLE [INV].[InventoryDelivery]
		ADD  CONSTRAINT [DF_InventoryDelivery_CreatorForm]  DEFAULT ((1)) FOR [CreatorForm]
GO
		
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryDelivery') AND
	[name] = 'DestinationStockRef' )
	ALTER TABLE INV.InventoryDelivery ADD [DestinationStockRef] [int] NULL
GO
--<< ALTER COLUMNS >>--

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryDelivery') AND
	[name] = 'ReceiverDLRef' AND is_nullable = 0)
	ALTER TABLE INV.InventoryDelivery ALTER COLUMN 
		[ReceiverDLRef] [int] NULL
GO

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_InventoryDelivery')
ALTER TABLE [INV].[InventoryDelivery] ADD  CONSTRAINT [PK_InventoryDelivery] PRIMARY KEY CLUSTERED 
(
	[InventoryDeliveryID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME='DF_InventoryDelivery_IsReturn')
	ALTER TABLE INV.InventoryDelivery ADD CONSTRAINT [DF_InventoryDelivery_IsReturn]  DEFAULT ((0)) FOR IsReturn

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_InventoryDelivery_AccountingVoucherRef')
	CREATE NONCLUSTERED INDEX IX_InventoryDelivery_AccountingVoucherRef
ON [INV].[InventoryDelivery] ([AccountingVoucherRef])
go 

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_InventoryDelivery_DL')
ALTER TABLE [INV].[InventoryDelivery]  ADD  CONSTRAINT [FK_InventoryDelivery_DL] FOREIGN KEY([ReceiverDLRef])
REFERENCES [ACC].[DL] ([DLId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_InventoryDelivery_FiscalYear')
ALTER TABLE [INV].[InventoryDelivery]  ADD  CONSTRAINT [FK_InventoryDelivery_FiscalYear] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_InventoryDelivery_Stock')
ALTER TABLE [INV].[InventoryDelivery]  ADD  CONSTRAINT [FK_InventoryDelivery_Stock] FOREIGN KEY([StockRef])
REFERENCES [INV].[Stock] ([StockID])

GO

If not Exists (select 1 from sys.objects where name = 'FK_InventoryDelivery_Voucher')
ALTER TABLE INV.InventoryDelivery ADD CONSTRAINT FK_InventoryDelivery_Voucher FOREIGN KEY ( AccountingVoucherRef )
	REFERENCES ACC.Voucher ( VoucherId ) ON UPDATE  NO ACTION ON DELETE  NO ACTION 
GO
	
If not Exists (select 1 from sys.objects where name = 'FK_InventoryDelivery_DestinationStock')
ALTER TABLE [INV].[InventoryDelivery]  ADD  CONSTRAINT [FK_InventoryDelivery_DestinationStock] FOREIGN KEY([DestinationStockRef])
REFERENCES [INV].[Stock] ([StockID])

GO

--<< DROP OBJECTS >>--
