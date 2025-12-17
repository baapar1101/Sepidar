--<<FileName:Weighing.sql>>--
--drop table INV.InventoryWeighing
--<< TABLE DEFINITION >>--

If Object_ID('INV.InventoryWeighing') Is Null
CREATE TABLE [INV].[InventoryWeighing](
	[InventoryWeighingID]			[int] NOT NULL,
	[WeighbridgeConfigurationRef]	[int] NOT NULL,
	[Number]						[int] NOT NULL,
	[Date]							[datetime] NOT NULL,
	[Type]							[int] NOT NULL,
	[ItemRef]						[int] NOT NULL,
	[InputTime]						[datetime] NULL,
	[OutputTime]					[datetime] NULL,
	[InputQuantity]					[decimal](19, 4) NULL,
	[OutputQuantity]				[decimal](19, 4) NULL,
	[WastePercent]					[decimal](19, 16) NOT NULL,
	[Driver]						[nvarchar](255) NULL,
	[DrivingLicenseNumber]			[nvarchar](127) NULL,
	[VehicleType]					[nvarchar](255) NULL,
	[VehicleNumber]					[nvarchar](127) NULL,
	[WayBillNumber]					[nvarchar](127) NULL,		
	[Description]					[nvarchar](4000) NULL,
	[Description_En]				[nvarchar](4000) NULL,
	[State]							[int] NOT NULL,
	[IsManual]						[bit] NOT NULL,
	[FiscalYearRef]					[int]  NOT NULL,
	[UnitRefConf]					[int] NOT NULL,
	[IsPrimaryUnit]					[bit] NOT NULL,
	[TransportPrice]				[decimal](19, 4) NULL,
	[TransportTax]	    			[decimal](19, 4) NULL,
	[TransportDuty] 				[decimal](19, 4) NULL,
	[City]							[nvarchar](250) NULL,
	[Creator]						[int] NOT NULL,
	[CreationDate]					[datetime] NOT NULL,
	[LastModifier]					[int] NOT NULL,
	[LastModificationDate]			[datetime] NOT NULL,
	[Version]						[int] NOT NULL
) ON [PRIMARY]


GO
--<< ADD CLOLUMNS >>--

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryWeighing') AND
				[Name] = 'UnitRefConf')
BEGIN
	ALTER TABLE [INV].[InventoryWeighing] ADD UnitRefConf int NOT NULL
END

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryWeighing') AND
				[Name] = 'IsPrimaryUnit')
BEGIN
	ALTER TABLE [INV].[InventoryWeighing] ADD IsPrimaryUnit int NOT NULL
END

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryWeighing') AND
				[Name] = 'VendorDLRef')
BEGIN
	ALTER TABLE [INV].[InventoryWeighing] ADD VendorDLRef int NULL
END
IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryWeighing') AND
				[Name] = 'TransportPrice')
BEGIN
	ALTER TABLE [INV].[InventoryWeighing] ADD TransportPrice [decimal](19, 4) NULL
END
IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryWeighing') AND
				[Name] = 'TransportTax')
BEGIN
	ALTER TABLE [INV].[InventoryWeighing] ADD TransportTax [decimal](19, 4) NULL
END
IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryWeighing') AND
				[Name] = 'TransportDuty')
BEGIN
	ALTER TABLE [INV].[InventoryWeighing] ADD TransportDuty [decimal](19, 4) NULL
END
IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryWeighing') AND
				[Name] = 'City')
BEGIN
	ALTER TABLE [INV].[InventoryWeighing] ADD City nvarchar(250) NULL
END
--<< ALTER COLUMNS >>--
IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryWeighing') AND
				[Name] = 'WastePercent')
BEGIN
	ALTER TABLE [INV].InventoryWeighing ALTER COLUMN WastePercent [decimal](19, 16) NOT NULL
END
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Inventory_Weighing')
ALTER TABLE [INV].[InventoryWeighing] ADD  CONSTRAINT [PK_Inventory_Weighing] PRIMARY KEY CLUSTERED 
(
	[InventoryWeighingID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--


--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Inventory_Weighbridge_Configuration')
ALTER TABLE [INV].[InventoryWeighing]  ADD  CONSTRAINT [FK_Inventory_Weighbridge_Configuration] FOREIGN KEY([WeighbridgeConfigurationRef])
REFERENCES [INV].[InventoryWeighbridgeConfiguration] ([InventoryWeighbridgeConfigurationID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_Inventory_Weighbridge_Item')
ALTER TABLE [INV].[InventoryWeighing]  ADD  CONSTRAINT [FK_Inventory_Weighbridge_Item] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])

GO

If not Exists (select 1 from sys.objects where name = 'FK_Inventory_Weighbridge_Unit')
ALTER TABLE [INV].[InventoryWeighing]  ADD  CONSTRAINT [FK_Inventory_Weighbridge_Unit] FOREIGN KEY([UnitRefConf])
REFERENCES [INV].[Unit] ([UnitID])

--<< DROP OBJECTS >>--
