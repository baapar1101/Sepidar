--<<FileName:SLS_DiscountQuantityItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.DiscountQuantityItem') Is Null
CREATE TABLE [SLS].[DiscountQuantityItem](
	[DiscountQuantityItemID] [int] NOT NULL,
	[DiscountRef] [int] NOT NULL,
	[ItemRef] [INT]  NULL,
	[TracingRef] [INT] NULL,
	[SalesGroupRef] [INT] NULL,
	[PurchaseGroupRef] [INT] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.DiscountQuantityItem') and
				[name] = 'ColumnName')
begin
    Alter table SLS.DiscountQuantityItem Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--
    
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_DiscountQuantityItem')
ALTER TABLE [SLS].[DiscountQuantityItem] ADD  CONSTRAINT [PK_DiscountQuantityItem] PRIMARY KEY CLUSTERED 
(
	[DiscountQuantityItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_DiscountQuantityItem_Discount')
ALTER TABLE [SLS].[DiscountQuantityItem]  ADD  CONSTRAINT [FK_DiscountQuantityItem_Discount] FOREIGN KEY([DiscountRef])
REFERENCES [SLS].[Discount] ([DiscountId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

If not Exists (select 1 from sys.objects where name = 'FK_DiscountQuantityItem_Item')
ALTER TABLE [SLS].[DiscountQuantityItem]  ADD  CONSTRAINT [FK_DiscountQuantityItem_Item] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])

GO

If not Exists (select 1 from sys.objects where name = 'FK_DiscountQuantityItem_Tracing')
ALTER TABLE [SLS].[DiscountQuantityItem]  ADD  CONSTRAINT [FK_DiscountQuantityItem_Tracing] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE Name = 'FK_DiscountQuantityItem_PurchaseGroup')
ALTER TABLE [SLS].[DiscountQuantityItem] ADD CONSTRAINT FK_DiscountQuantityItem_PurchaseGroup FOREIGN KEY (PurchaseGroupRef)
REFERENCES [GNR].[Grouping] ([GroupingID])

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE Name = 'FK_DiscountQuantityItem_SalesGroup')
ALTER TABLE [SLS].[DiscountQuantityItem] ADD CONSTRAINT FK_DiscountQuantityItem_SalesGroup FOREIGN KEY (SalesGroupRef)
REFERENCES [GNR].[Grouping] ([GroupingID])

GO
--<< DROP OBJECTS >>--
