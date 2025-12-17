--<<FileName:SLS_DiscountItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.DiscountItem') Is Null
CREATE TABLE [SLS].[DiscountItem](
	[DiscountItemID] [int] NOT NULL,
	[DiscountRef] [int] NOT NULL,
	[FromValue] [DECIMAL](19,4) NOT NULL,
	[ToValue] [DECIMAL](19,4) NOT NULL,
	[DiscountType] [int]  NULL,
	[Amount] [decimal](19,4) NOT NULL,
	[ItemRef] [INT]  NULL,
	[TracingRef] [INT] NULL,
	[DiscountItemGroupRef] [INT] NULL,
	[ProductPackRef] [INT] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.DiscountItem') and
				[name] = 'ColumnName')
begin
    Alter table SLS.DiscountItem Add ColumnName DataType Nullable
end
GO*/

if not exists (select 1 from sys.columns where object_id=object_id('SLS.DiscountItem') and
				[name] = 'DiscountItemGroupRef')
begin
    Alter table SLS.DiscountItem Add DiscountItemGroupRef INT Null
end
GO

--<< ALTER COLUMNS >>--
    
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_DiscountItem')
ALTER TABLE [SLS].[DiscountItem] ADD  CONSTRAINT [PK_DiscountItem] PRIMARY KEY CLUSTERED 
(
	[DiscountItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_DiscountItem_Discount')
ALTER TABLE [SLS].[DiscountItem]  ADD  CONSTRAINT [FK_DiscountItem_Discount] FOREIGN KEY([DiscountRef])
REFERENCES [SLS].[Discount] ([DiscountId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

If not Exists (select 1 from sys.objects where name = 'FK_DiscountItem_Item')
ALTER TABLE [SLS].[DiscountItem]  ADD  CONSTRAINT [FK_DiscountItem_Item] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])

GO

If not Exists (select 1 from sys.objects where name = 'FK_DiscountItem_Tracing')
ALTER TABLE [SLS].[DiscountItem]  ADD  CONSTRAINT [FK_DiscountItem_Tracing] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])

GO

If not Exists (select 1 from sys.objects where name = 'FK_DiscountItem_DiscountItemGroup')
ALTER TABLE [SLS].[DiscountItem]  ADD  CONSTRAINT [FK_DiscountItem_DiscountItemGroup] FOREIGN KEY([DiscountItemGroupRef])
REFERENCES [SLS].[DiscountItemGroup] ([DiscountItemGroupID])

GO

If not Exists (select 1 from sys.objects where name = 'FK_DiscountItem_ProductPack')
ALTER TABLE [SLS].[DiscountItem]  ADD  CONSTRAINT [FK_DiscountItem_ProductPack] FOREIGN KEY([ProductPackRef])
REFERENCES [SLS].[ProductPack] ([ProductPackId])

GO
--<< DROP OBJECTS >>--
