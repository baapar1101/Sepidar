--<<FileName:SLS.DiscountItemGroupItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.DiscountItemGroupItem') Is Null
CREATE TABLE [SLS].[DiscountItemGroupItem](
	[DiscountItemGroupItemID] [int] NOT NULL,
	[DiscountItemGroupRef] [int] NOT NULL,
	[ItemRef] [int] NOT NULL,
	[TracingRef] [int]  NULL,
	[IsDefaultItem] [bit] not null DEFAULT 0
) ON [PRIMARY]

GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--
    
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_DiscountItemGroupItem')
ALTER TABLE [SLS].[DiscountItemGroupItem] ADD  CONSTRAINT [PK_DiscountItemGroupItem] PRIMARY KEY CLUSTERED 
(
	[DiscountItemGroupItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_DiscountItemGroupItem_DiscountItemGroup')
ALTER TABLE [SLS].[DiscountItemGroupItem]  ADD  CONSTRAINT [FK_DiscountItemGroupItem_DiscountItemGroup] FOREIGN KEY([DiscountItemGroupRef])
REFERENCES [SLS].[DiscountItemGroup] ([DiscountItemGroupID])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

If not Exists (select 1 from sys.objects where name = 'FK_DiscountItemGroupItem_Item')
ALTER TABLE [SLS].[DiscountItemGroupItem]  ADD  CONSTRAINT [FK_DiscountItemGroupItem_Item] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])

GO

If not Exists (select 1 from sys.objects where name = 'FK_DiscountItemGroupItem_TracingRef')
ALTER TABLE [SLS].[DiscountItemGroupItem]  ADD  CONSTRAINT [FK_DiscountItemGroupItem_TracingRef] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])

GO

If not Exists (select 1 from sys.indexes where name = 'UIX_SLS_DiscountItemGroupItem_DiscountItemGroupRef_ItemRef_TracingRef')
CREATE UNIQUE INDEX [UIX_SLS_DiscountItemGroupItem_DiscountItemGroupRef_ItemRef_TracingRef] ON [SLS].[DiscountItemGroupItem]
(
	[DiscountItemGroupRef],[ItemRef],[TracingRef]
) ON [PRIMARY]


--<< DROP OBJECTS >>--
