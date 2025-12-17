--<<FileName:POS_InvoiceItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('POS.InvoiceItem') Is Null
CREATE TABLE [POS].[InvoiceItem](
	[InvoiceItemID] [int] NOT NULL,
	[InvoiceRef] [int] NOT NULL,
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

If not Exists (select 1 from sys.objects where name = 'PK_POS_InvoiceItem')
ALTER TABLE [POS].[InvoiceItem] ADD  CONSTRAINT [PK_POS_InvoiceItem] PRIMARY KEY CLUSTERED 
(
	[InvoiceItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
GO
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_POS_InvoiceItem_InvoiceRef')
ALTER TABLE [POS].[InvoiceItem]  ADD  CONSTRAINT [FK_POS_InvoiceItem_InvoiceRef] FOREIGN KEY([InvoiceRef])
REFERENCES [POS].[Invoice] ([InvoiceId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_POS_InvoiceItem_ItemRef')
ALTER TABLE [POS].[InvoiceItem]  ADD  CONSTRAINT [FK_POS_InvoiceItem_ItemRef] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])
GO
If not Exists (select 1 from sys.objects where name = 'FK_POS_InvoiceItem_TracingRef')
ALTER TABLE [POS].[InvoiceItem]  ADD  CONSTRAINT [FK_POS_InvoiceItem_TracingRef] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])

GO

--<< DROP OBJECTS >>--
