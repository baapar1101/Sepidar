--<<FileName:SLS_ProductPackItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.ProductPackItem') Is Null
CREATE TABLE [SLS].[ProductPackItem](
	[ProductPackItemID] [int] NOT NULL,
	[ProductPackRef] [int] NOT NULL,
	[ItemRef] [int] NOT NULL,
	[TracingRef] [int]  NULL,
	[Quantity] [decimal](19,4) NOT NULL,
	[SecondaryQuantity] [decimal](19,4)  NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.ProductPackItem') and
				[name] = 'ColumnName')
begin
    Alter table SLS.ProductPackItem Add ColumnName DataType Nullable
end
GO*/
--<< ALTER COLUMNS >>--
    
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ProductPackItem')
ALTER TABLE [SLS].[ProductPackItem] ADD  CONSTRAINT [PK_ProductPackItem] PRIMARY KEY CLUSTERED 
(
	[ProductPackItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ProductPackItem_ProductPack')
ALTER TABLE [SLS].[ProductPackItem]  ADD  CONSTRAINT [FK_ProductPackItem_ProductPack] FOREIGN KEY([ProductPackRef])
REFERENCES [SLS].[ProductPack] ([ProductPackID])
ON UPDATE CASCADE
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_ProductPackItem_Item')
ALTER TABLE [SLS].[ProductPackItem]  ADD  CONSTRAINT [FK_ProductPackItem_Item] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ProductPackItem_TracingRef')
ALTER TABLE [SLS].[ProductPackItem]  ADD  CONSTRAINT [FK_ProductPackItem_TracingRef] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])

GO
--<< DROP OBJECTS >>--
