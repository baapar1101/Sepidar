--<<FileName:INV_InventoryBalancingItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('INV.InventoryBalancingItem') Is Null
CREATE TABLE [INV].[InventoryBalancingItem](
	[InventoryBalancingItemId] [int] NOT NULL,
	[InventoryBalancingRef] [int] NOT NULL,	
	[ItemRef] [int] NOT NULL,
	[TracingRef] [int] NULL, 
	[TagNumber] [int] NULL,
	[Quantity] [decimal] (19, 4) NULL,
) ON [PRIMARY]

GO




--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
--<< ADD CLOLUMNS >>--


IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('INV.InventoryBalancingItem') AND
				[name] = 'SecondaryQuantity')
begin
    ALTER TABLE INV.InventoryBalancingItem ADD SecondaryQuantity decimal(19, 4) NULL
end
GO

--<< ALTER COLUMNS >>--


--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_InventoryBalancingItem')
ALTER TABLE [INV].[InventoryBalancingItem] ADD  CONSTRAINT [PK_InventoryBalancingItem] PRIMARY KEY CLUSTERED 
(
	[InventoryBalancingItemId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--
	
If not Exists (select 1 from sys.objects where name = 'FK_InventoryBalancingItem_InventoryBalancing')
ALTER TABLE [INV].[InventoryBalancingItem]  ADD  CONSTRAINT [FK_InventoryBalancingItem_InventoryBalancing] FOREIGN KEY([InventoryBalancingRef])
REFERENCES [INV].[InventoryBalancing] ([InventoryBalancingId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_InventoryBalancingItem_Item')
ALTER TABLE [INV].[InventoryBalancingItem]  ADD  CONSTRAINT [FK_InventoryBalancingItem_Item] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_InventoryBalancingItem_Tracing')
ALTER TABLE [INV].[InventoryBalancingItem]  ADD  CONSTRAINT [FK_InventoryBalancingItem_Tracing] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])

GO

--<< DROP OBJECTS >>--