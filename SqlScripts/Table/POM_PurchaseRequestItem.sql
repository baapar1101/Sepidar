--<<FileName:POM_PurchaseRequestItem.sql >>--
--<< TABLE DEFINITION >>--
-- drop TABLE [POM].[PurchaseRequestItem]
If Object_ID('POM.PurchaseRequestItem') Is Null
CREATE TABLE [POM].[PurchaseRequestItem](
	[PurchaseRequestItemID] [int] NOT NULL,
	[PurchaseRequestRef] [int] NOT NULL,
	[RowNumber] [int] NOT NULL,
	[ItemRef] [int] NULL,
	[TracingRef] [int] NULL,
	[ItemDescription] [nvarchar](500) NULL,
	[Quantity] [decimal](19, 4) NOT NULL,
	[SecondaryQuantity] [decimal](19, 4) NULL,
	[ApprovedQuantity] [decimal](19, 4) NULL,
	[ApprovedSecondaryQuantity] [decimal](19, 4) NULL,
	[Priority] [int] NOT NULL,
	[DeliveryDate] [datetime] NULL,
	[Description] [nvarchar](500) NULL	,
	[ItemRequestItemRef] [int] null
) ON [PRIMARY]

GO
--<< ADD CLOLUMNS >>--


--<<Sample >>--
/*if not exists (select 1 from sys.columns where object_id=object_id('POM.PurchaseRequestItem') and
				[name] = 'ColumnName')
begin
    Alter table POM.PurchaseRequestItem Add ColumnName DataType Nullable
end
GO*/


--<< ALTER COLUMNS >>--


--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_PurchaseRequestItem')
ALTER TABLE [POM].[PurchaseRequestItem] ADD CONSTRAINT [PK_PurchaseRequestItem] PRIMARY KEY CLUSTERED 
(
	[PurchaseRequestItemID] ASC
) ON [PRIMARY]

GO

--<< DEFAULTS CHECKS DEFINITION >>--
--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_PurchaseRequestItem_ItemRequestItemRef')
	CREATE UNIQUE INDEX IX_PurchaseRequestItem_ItemRequestItemRef
		ON [POM].[PurchaseRequestItem] ([ItemRequestItemRef])  WHERE [ItemRequestItemRef] IS NOT NULL
GO
--IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_PurchaseRequestItem_ItemRef')
--CREATE NONCLUSTERED INDEX [IX_PurchaseRequestItem_ItemRef]
--ON [POM].[PurchaseRequestItem] ([ItemRef])
--GO
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_PurchaseRequestItem_PurchaseRequestRef')
ALTER TABLE POM.PurchaseRequestItem ADD CONSTRAINT FK_PurchaseRequestItem_PurchaseRequestRef FOREIGN KEY
	( PurchaseRequestRef ) REFERENCES POM.PurchaseRequest ( PurchaseRequestID )
	 ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
GO

If not Exists (select 1 from sys.objects where name = 'FK_PurchaseRequestItem_ItemRef')
ALTER TABLE [POM].[PurchaseRequestItem]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseRequestItem_ItemRef] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects where name = 'FK_PurchaseRequestItem_TracingRef')
ALTER TABLE [POM].[PurchaseRequestItem]  ADD  CONSTRAINT [FK_PurchaseRequestItem_TracingRef] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])

IF NOT EXISTS (SELECT 1 FROM sys.objects where name = 'FK_PurchaseRequestItem_ItemRequestItemRef')
ALTER TABLE [POM].[PurchaseRequestItem]  ADD  CONSTRAINT [FK_PurchaseRequestItem_ItemRequestItemRef] FOREIGN KEY([ItemRequestItemRef])
REFERENCES [POM].[ItemRequestItem] ([ItemRequestItemID])