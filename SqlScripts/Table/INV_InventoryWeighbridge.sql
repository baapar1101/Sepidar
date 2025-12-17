--<<FileName:InventoryWeighbridge.sql>>--
--drop table INV.InventoryWeighbridge
--<< TABLE DEFINITION >>--


If Object_ID('INV.InventoryWeighbridge') Is Null
CREATE TABLE [INV].[InventoryWeighbridge](
	[InventoryWeighbridgeID]			[int] NOT NULL,
	[Model]								[int] NOT NULL,	
	[BaudRate]							[int] NOT NULL,
	[DataBits]							[int] NOT NULL,
	[StopBits]							[int] NOT NULL,
	[Parity]							[int] NOT NULL,
	[Creator]							[int] NOT NULL,
	[CreationDate]						[datetime] NOT NULL,
	[LastModifier]						[int] NOT NULL,
	[LastModificationDate]				[datetime] NOT NULL,
	[Version]							[int] NOT NULL
) ON [PRIMARY]


GO
--<< ADD CLOLUMNS >>--



--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Inventory_Weighbridge')
ALTER TABLE [INV].[InventoryWeighbridge] ADD  CONSTRAINT [PK_Inventory_Weighbridge] PRIMARY KEY CLUSTERED 
(
	[InventoryWeighbridgeID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--


--<< FOREIGNKEYS DEFINITION >>--

GO

--<< DROP OBJECTS >>--
