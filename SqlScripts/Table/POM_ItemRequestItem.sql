--<<FileName:POM_ItemRequestItem.sql >>--
--<< TABLE DEFINITION >>--
-- drop TABLE [POM].[ItemRequestItem]
If Object_ID('POM.ItemRequestItem') Is Null
CREATE TABLE [POM].[ItemRequestItem](
	[ItemRequestItemID] [int] NOT NULL,
	[ItemRequestRef] [int] NOT NULL,
	[ProductOrderItemRef] [int] NULL,

	[RowNumber] [int] NOT NULL,
	[ItemRef] [int] NULL,
	[ItemDescription] [nvarchar](500) NULL,
	[TracingRef] [int] NULL,

	[Quantity] [decimal](19, 4) NOT NULL,
	[SecondaryQuantity] [decimal](19, 4) NULL,
	[ApprovedQuantity] [decimal](19, 4) NULL,
	[ApprovedSecondaryQuantity] [decimal](19, 4) NULL,

	[DeliveryDate] [datetime] NULL,
	[Description] [nvarchar](500) NULL	
) ON [PRIMARY]

GO
--<< ADD CLOLUMNS >>--


--<<Sample >>--
/*if not exists (select 1 from sys.columns where object_id=object_id('POM.ItemRequestItem') and
				[name] = 'ColumnName')
begin
    Alter table POM.ItemRequestItem Add ColumnName DataType Nullable
end
GO*/
if not exists (select 1 from sys.columns where object_id=object_id('POM.ItemRequestItem') and
				[name] = 'ProductOrderBOMItemRef')
begin
    Alter table POM.ItemRequestItem Add ProductOrderBOMItemRef INT NULL
end
GO


--<< ALTER COLUMNS >>--


--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_ItemRequestItem')
ALTER TABLE [POM].[ItemRequestItem] ADD CONSTRAINT [PK_ItemRequestItem] PRIMARY KEY CLUSTERED 
(
	[ItemRequestItemID] ASC
) ON [PRIMARY]

GO

--<< DEFAULTS CHECKS DEFINITION >>--
--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
--IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_ItemRequestItem_ItemRef')
--CREATE NONCLUSTERED INDEX [IX_ItemRequestItem_ItemRef]
--ON [POM].[ItemRequestItem] ([ItemRef])
--GO
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ItemRequestItem_ItemRequestRef')
ALTER TABLE POM.ItemRequestItem ADD CONSTRAINT FK_ItemRequestItem_ItemRequestRef FOREIGN KEY
	( ItemRequestRef ) REFERENCES POM.ItemRequest ( ItemRequestID )
	 ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
GO

If not Exists (select 1 from sys.objects where name = 'FK_ItemRequestItem_ItemRef')
ALTER TABLE [POM].[ItemRequestItem]  WITH CHECK ADD  CONSTRAINT [FK_ItemRequestItem_ItemRef] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects where name = 'FK_ItemRequestItem_TracingRef')
ALTER TABLE [POM].[ItemRequestItem]  ADD  CONSTRAINT [FK_ItemRequestItem_TracingRef] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects where name = 'FK_ItemRequestItem_ProductOrderBOMItemRef')
ALTER TABLE [POM].[ItemRequestItem]  ADD  CONSTRAINT [FK_ItemRequestItem_ProductOrderBOMItemRef] FOREIGN KEY([ProductOrderBOMItemRef])
REFERENCES [WKO].[ProductOrderBOMItem] ([ProductOrderBOMItemID])
GO