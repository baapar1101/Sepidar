--<<FileName:POS_ReturnedInvoiceItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('POS.ReturnedInvoiceItem') Is Null
CREATE TABLE [POS].[ReturnedInvoiceItem](
	[ReturnedInvoiceItemID] [int] NOT NULL,
	[ReturnedInvoiceRef] [int] NOT NULL,
	[RowID] [int] NOT NULL,
	[ItemRef] [int] NOT NULL,
	[TracingRef] [int] NULL,
	[Quantity] [decimal](19, 3) NOT NULL,
	[SecondaryQuantity] [decimal](19, 3) NOT NULL,
	[Fee] [decimal](19, 4) NOT NULL,
	[Price] [decimal](19, 4) NOT NULL,
	[Discount] [decimal](19, 4) NULL,
	[Addition] [decimal](19, 4) NULL,
	[Tax] [decimal](19, 4) NULL,
	[Duty] [decimal](19, 4) NULL,
	[NetPrice] [decimal](19, 3) NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_POS_ReturnedInvoiceItem')
ALTER TABLE [POS].[ReturnedInvoiceItem] ADD  CONSTRAINT [PK_POS_ReturnedInvoiceItem] PRIMARY KEY CLUSTERED 
(
	[ReturnedInvoiceItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
GO
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_POS_ReturnedInvoiceItem_ReturnedInvoiceRef')
ALTER TABLE [POS].[ReturnedInvoiceItem]  ADD  CONSTRAINT [FK_POS_ReturnedInvoiceItem_ReturnedInvoiceRef] FOREIGN KEY([ReturnedInvoiceRef])
REFERENCES [POS].[ReturnedInvoice] ([ReturnedInvoiceId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_POS_ReturnedInvoiceItem_ItemRef')
ALTER TABLE [POS].[ReturnedInvoiceItem]  ADD  CONSTRAINT [FK_POS_ReturnedInvoiceItem_ItemRef] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])
GO
If not Exists (select 1 from sys.objects where name = 'FK_POS_ReturnedInvoiceItem_TracingRef')
ALTER TABLE [POS].[ReturnedInvoiceItem]  ADD  CONSTRAINT [FK_POS_ReturnedInvoiceItem_TracingRef] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])

GO

--<< DROP OBJECTS >>--
