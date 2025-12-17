--<<FileName:POM_BillOfLoadingItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('POM.BillOfLoadingItem') Is Null
CREATE TABLE [POM].[BillOfLoadingItem](
	[BillOfLoadingItemID] [int] NOT NULL,
	[BillOfLoadingRef] [int] NOT NULL,
	[RowNumber] [int] NOT NULL,
	[BasePurchaseInvoiceItemRef] [int] NOT NULL,
	[ItemRef] [int] NOT NULL,
	[TracingRef] [int] NULL,
	[Quantity] [decimal](19, 4) NOT NULL,
	[SecondaryQuantity] [decimal](19, 4) NULL,
	[TotalWeight] [decimal](19, 4) NULL,
	[ItemWeight] [DECIMAL](19, 4) NULL,
	[ItemNetPrice] [decimal](19, 4) NOT NULL,
	[ItemNetPriceInBaseCurrency][decimal](19, 4) NULL,
	[Price] [decimal](19, 4) NOT NULL,
	[PriceInBaseCurrency] [decimal](19,4) NULL,
	[Discount] [decimal](19, 4) NULL,
	[DiscountInBaseCurrency] [decimal](19,4) NULL,
	[Addition] [decimal](19, 4) NULL,
	[AdditionInBaseCurrency] [decimal](19,4)NULL,
	[NetPrice]  AS CONVERT([decimal](19,4),(([Price]-isnull([Discount],(0))))+isnull([Addition],0)) PERSISTED,
	[NetPriceInBaseCurrency][decimal](19, 4) NULL,
	[Description] [nvarchar](500) NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

GO

--<< ADD CLOLUMNS >>--

if not exists (select 1 from sys.columns where object_id=object_id('POM.BillOfLoadingItem') and
				[name] = 'TotalWeight')
begin
    Alter table POM.BillOfLoadingItem add TotalWeight [decimal](19, 4) NULL
end

GO

if not exists (select 1 from sys.columns where object_id=object_id('POM.BillOfLoadingItem') and
				[name] = 'ItemWeight')
begin
    Alter table POM.BillOfLoadingItem add ItemWeight [decimal](19, 4) NULL
end


GO

--<<Sample>>--

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_BillOfLoadingItem')
ALTER TABLE [POM].[BillOfLoadingItem] ADD CONSTRAINT [PK_BillOfLoadingItem] PRIMARY KEY CLUSTERED 
(
	[BillOfLoadingItemID] ASC
) ON [PRIMARY]

GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_BillOfLoadingItem_ItemRef')
BEGIN 
	DROP INDEX POM.BillOfLoadingItem.IX_BillOfLoadingItem_ItemRef
END

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_BillOfLoadingItem_BasePurchaseInvoiceItemRef')
CREATE NONCLUSTERED INDEX [IX_BillOfLoadingItem_BasePurchaseInvoiceItemRef]
ON [POM].[BillOfLoadingItem] ([BasePurchaseInvoiceItemRef])

GO


--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_BillOfLoadingItem_BillOfLoading')
ALTER TABLE POM.BillOfLoadingItem  ADD  CONSTRAINT [FK_BillOfLoadingItem_BillOfLoading] FOREIGN KEY([BillOfLoadingRef])
REFERENCES POM.BillOfLoading ([BillOfLoadingID])
ON DELETE CASCADE

GO

If not Exists (select 1 from sys.objects where name = 'FK_BillOfLoadingItem_PurchaseInvoiceItem')
ALTER TABLE POM.BillOfLoadingItem ADD CONSTRAINT FK_BillOfLoadingItem_PurchaseInvoiceItem FOREIGN KEY	( BasePurchaseInvoiceItemRef ) 
REFERENCES POM.PurchaseInvoiceItem ( PurchaseInvoiceItemID )
	 ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION

GO

If not Exists (select 1 from sys.objects where name = 'FK_BillOfLoadingItem_Item')
ALTER TABLE [POM].[BillOfLoadingItem]  WITH CHECK ADD  CONSTRAINT [FK_BillOfLoadingItem_Item] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects where name = 'FK_BillOfLoadingItem_TracingRef')
ALTER TABLE [POM].[BillOfLoadingItem]  ADD  CONSTRAINT [FK_BillOfLoadingItem_TracingRef] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])

GO
