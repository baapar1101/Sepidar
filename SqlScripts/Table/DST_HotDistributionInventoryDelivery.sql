--<<FileName:DST_HotDistributionInventoryDelivery.sql>>--

--<< TABLE DEFINITION >>--
IF OBJECT_ID('DST.HotDistributionInventoryDelivery') IS NULL
CREATE TABLE [DST].[HotDistributionInventoryDelivery](
	[HotDistributionInventoryDeliveryId]	[INT]	NOT NULL,
	[HotDistributionRef]					[INT]	NOT NULL,
	[InventoryDeliveryRef]					[INT]	NOT NULL,
	[ReturnedInvoiceRef]					[INT]	NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO

--<< ADD CLOLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('DST.HotDistributionInventoryDelivery') 
				AND [name] = 'ReturnedInvoiceRef')
BEGIN
	ALTER TABLE [DST].[HotDistributionInventoryDelivery] ADD [ReturnedInvoiceRef] [INT] NULL
END
--<<Sample>>--
/*IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID=OBJECT_ID('SLS.HotDistributionInventoryDelivery') AND
				[name] = 'ColumnName')
BEGIN
    ALTER TABLE SLS.HotDistributionInventoryDelivery ADD ColumnName DataType Nullable
END
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_HotDistributionInventoryDelivery')
ALTER TABLE [DST].[HotDistributionInventoryDelivery] ADD CONSTRAINT [PK_HotDistributionInventoryDelivery] PRIMARY KEY CLUSTERED 
(
	[HotDistributionInventoryDeliveryId] ASC
) ON [PRIMARY]

GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_HotDistributionInventoryDelivery_HotDistributionRef_InventoryDeliveryRef')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_HotDistributionInventoryDelivery_HotDistributionRef_InventoryDeliveryRef] ON [DST].[HotDistributionInventoryDelivery] 
(
	[HotDistributionRef] ASC,
	[InventoryDeliveryRef] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1	FROM sys.objects WHERE name = 'FK_HotDistributionInventoryDelivery_HotDistributionRef')
	ALTER TABLE [DST].[HotDistributionInventoryDelivery] ADD CONSTRAINT [FK_HotDistributionInventoryDelivery_HotDistributionRef] FOREIGN KEY ([HotDistributionRef])
	REFERENCES [DST].[HotDistribution] ([HotDistributionId])
	ON DELETE CASCADE

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_HotDistributionInventoryDelivery_InventoryDeliveryRef')
	ALTER TABLE [DST].[HotDistributionInventoryDelivery] ADD CONSTRAINT [FK_HotDistributionInventoryDelivery_InventoryDeliveryRef] FOREIGN KEY([InventoryDeliveryRef])
	REFERENCES [INV].[InventoryDelivery] ([InventoryDeliveryID])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [name] = 'FK_HotDistributionInventoryDelivery_ReturnedInvoiceRef')
	ALTER TABLE [DST].[HotDistributionInventoryDelivery] ADD CONSTRAINT [FK_HotDistributionInventoryDelivery_ReturnedInvoiceRef] FOREIGN KEY ([ReturnedInvoiceRef])
	REFERENCES [SLS].[ReturnedInvoice] ([ReturnedInvoiceId])
	ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
