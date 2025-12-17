--<<FileName:WeighbridgeConfiguration.sql>>--
--drop table INV.InventoryWeighbridgeConfiguration
--<< TABLE DEFINITION >>--

If Object_ID('INV.InventoryWeighbridgeConfiguration') Is Null
CREATE TABLE [INV].[InventoryWeighbridgeConfiguration](
	[InventoryWeighbridgeConfigurationID]	[int] NOT NULL,
	[InventoryWeighbridgeRef]			[int] NOT NULL,	
	[Model]								[int] NOT NULL,	
	[Port]								[int] NOT NULL,
	[UnitRef]							[int] NOT NULL,
	[BaudRate]							[int] NOT NULL,
	[DataBits]							[int] NOT NULL,
	[StopBits]							[int] NOT NULL,
	[Parity]							[int] NOT NULL,
	[AutoClose]							[int] NOT NULL,
	[StabilityCheckTime]				[int] NOT NULL,
	[UseIncompleteWeighingInVoucher]     [bit] NOT NULL DEFAULT 0,
	[Creator]							[int] NOT NULL,
	[CreationDate]						[datetime] NOT NULL,
	[LastModifier]						[int] NOT NULL,
	[LastModificationDate]				[datetime] NOT NULL,
	[Version]							[int] NOT NULL
) ON [PRIMARY]
GO



--<< ADD CLOLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryWeighbridgeConfiguration') AND
				[Name] = 'UseIncompleteWeighingInVoucher')
BEGIN
	ALTER TABLE [INV].[InventoryWeighbridgeConfiguration] ADD UseIncompleteWeighingInVoucher [bit] NOT NULL DEFAULT 0
END


--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Inventory_Weighbridge_Configuration')
ALTER TABLE [INV].[InventoryWeighbridgeConfiguration] ADD  CONSTRAINT [PK_Inventory_Weighbridge_Configuration] PRIMARY KEY CLUSTERED 
(
	[InventoryWeighbridgeConfigurationID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--


--<< FOREIGNKEYS DEFINITION >>--
If not Exists (select 1 from sys.objects where name = 'FK_Inventory_Weighbridge_Configuration_Unit')
ALTER TABLE [INV].[InventoryWeighbridgeConfiguration]  ADD  CONSTRAINT [FK_Inventory_Weighbridge_Configuration_Unit] FOREIGN KEY([UnitRef])
REFERENCES [INV].[Unit] ([UnitID])