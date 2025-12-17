--<<FileName:POM_PurchaseInvoiceItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('POM.PurchaseInvoiceItem') Is Null
CREATE TABLE [POM].[PurchaseInvoiceItem](
	[PurchaseInvoiceItemID] [int] NOT NULL,
	[PurchaseInvoiceRef] [int] NOT NULL,
	[RowNumber] [int] NOT NULL,
	[ItemRef] [int] NOT NULL,
	[TracingRef] [int] NULL,
    [PurchaseOrderItemRef] INT NOT NULL,
	[Quantity] [decimal](19, 4) NOT NULL,
	[SecondaryQuantity] [decimal](19, 4) NULL,
	[Fee] [decimal](19,4) NOT NULL,
	[FeeInBaseCurrency] [decimal](19, 4) NULL,
	[Price] [decimal](19, 4) NOT NULL,
	[PriceInBaseCurrency] [decimal](19,4) NULL,
	[Discount] [decimal](19, 4) NULL,
	[DiscountInBaseCurrency] [decimal](19,4) NULL,
	[Addition] [decimal](19, 4) NULL,
	[AdditionInBaseCurrency] [decimal](19,4)NULL,
	[NetPrice]  AS CONVERT([decimal](19,4), ([Price]-isnull([Discount],(0)))+isnull([Addition],0)) PERSISTED,
	[NetPriceInBaseCurrency][decimal](19, 4) NULL,
	[BaseInvoiceCalculatedPriceNoteInBaseCurrency][decimal](19, 4) NULL,
	[Description] [nvarchar](500) NULL,
	[Description_En] [nvarchar](500) NULL,
	[Version] [int] NOT NULL	
) ON [PRIMARY]

GO

--<< ADD CLOLUMNS >>--

--<<Sample>>--

--<< ALTER COLUMNS >>--

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('POM.PurchaseInvoiceItem') AND
			[name] = 'CurrencyRate')
	BEGIN
		ALTER TABLE POM.PurchaseInvoiceItem DROP COLUMN CurrencyRate
	END

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('POM.PurchaseInvoiceItem') AND
			[name] = 'RemainingSecondaryQuantity')
	BEGIN
		ALTER TABLE POM.PurchaseInvoiceItem DROP COLUMN RemainingSecondaryQuantity
	END

IF NOT EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('POM.PurchaseInvoiceItem') AND
			[name] = 'PurchaseOrderItemRef' )	
ALTER TABLE POM.PurchaseInvoiceItem ADD PurchaseOrderItemRef int NULL

Go

IF NOT EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('POM.PurchaseInvoiceItem') AND
			[name] = 'BaseInvoiceCalculatedPriceNoteInBaseCurrency' )	
ALTER TABLE POM.PurchaseInvoiceItem ADD BaseInvoiceCalculatedPriceNoteInBaseCurrency [decimal](19, 4) NULL
--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_PurchaseInvoiceItem')
ALTER TABLE [POM].[PurchaseInvoiceItem] ADD CONSTRAINT [PK_PurchaseInvoiceItem] PRIMARY KEY CLUSTERED 
(
	[PurchaseInvoiceItemID] ASC
) ON [PRIMARY]

GO

--<< DEFAULTS CHECKS DEFINITION >>--


IF  EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'DF_PurchaseInvoiceItem_RemainingQuantity')
ALTER TABLE [POM].[PurchaseInvoiceItem]
	drop CONSTRAINT DF_PurchaseInvoiceItem_RemainingQuantity
GO



IF  EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('POM.PurchaseInvoiceItem') AND
			[name] =  'RemainingQuantity')
ALTER TABLE [POM].[PurchaseInvoiceItem]
	drop Column RemainingQuantity
GO

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_PurchaseInvoiceItem_ItemRef')
CREATE NONCLUSTERED INDEX [IX_PurchaseInvoiceItem_ItemRef]
ON [POM].[PurchaseInvoiceItem] ([ItemRef])

GO

IF NOT EXISTS (select 1 from sys.indexes where name = 'IX_PurchaseInvoiceItem_PurchaseOrderItemRef')
CREATE NONCLUSTERED INDEX [IX_PurchaseInvoiceItem_PurchaseOrderItemRef] ON [POM].[PurchaseInvoiceItem] 
(
	[PurchaseOrderItemRef] ASC
) ON [PRIMARY]

GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_PurchaseInvoiceItem_PurchaseOrder')
ALTER TABLE POM.PurchaseInvoiceItem ADD CONSTRAINT FK_PurchaseInvoiceItem_PurchaseOrder FOREIGN KEY	( PurchaseInvoiceRef ) 
REFERENCES POM.PurchaseInvoice ( PurchaseInvoiceID )
	 ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
GO

If not Exists (select 1 from sys.objects where name = 'FK_PurchaseInvoiceItem_Item')
ALTER TABLE [POM].[PurchaseInvoiceItem]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseInvoiceItem_Item] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects where name = 'FK_PurchaseInvoiceItem_TracingRef')
ALTER TABLE [POM].[PurchaseInvoiceItem]  ADD  CONSTRAINT [FK_PurchaseInvoiceItem_TracingRef] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])

GO


IF NOT Exists (select 1 from sys.objects where name = 'FK_PurchaseInvoiceItem_PurchaseOrderItemRef')
ALTER TABLE [POM].[PurchaseInvoiceItem]  ADD  CONSTRAINT [FK_PurchaseInvoiceItem_PurchaseOrderItemRef] FOREIGN KEY([PurchaseOrderItemRef])
REFERENCES [POM].[PurchaseOrderItem] ([PurchaseOrderItemID])
GO


IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_PurchaseInvoiceItem_PurchaseOrderItemRef')
	CREATE NONCLUSTERED INDEX [IX_PurchaseInvoiceItem_PurchaseOrderItemRef]
		ON [POM].[PurchaseInvoiceItem] ([PurchaseOrderItemRef])
		
GO
