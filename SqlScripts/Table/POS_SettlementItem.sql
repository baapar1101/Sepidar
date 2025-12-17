--<<FileName:POS_SettlementItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('POS.SettlementItem') Is Null
CREATE TABLE [POS].[SettlementItem](
	[SettlementItemID] [int] NOT NULL,
	[SettlementRef] [int] NOT NULL,
	[RowID] [int] NOT NULL,
	[InvoiceRef] [int] NULL,
	[ReturnedInvoiceRef] [int] NULL,
	[SalesInvoiceRef] [int] NULL,
	[SalesReturnedInvoiceRef] [int] NULL,
	EntityFullName varchar(500)
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

GO
	 

--<< ALTER COLUMNS >>--
GO	

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_POS_SettlementItem')
ALTER TABLE [POS].[SettlementItem] ADD  CONSTRAINT [PK_POS_SettlementItem] PRIMARY KEY CLUSTERED 
(
	[SettlementItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_POS_SettlementItem_SettlementRef')
ALTER TABLE [POS].[SettlementItem]  ADD  CONSTRAINT [FK_POS_SettlementItem_SettlementRef] FOREIGN KEY([SettlementRef])
REFERENCES [POS].[Settlement] ([SettlementID])
ON DELETE CASCADE


GO
If not Exists (select 1 from sys.objects where name = 'FK_POS_SettlementItem_InvoiceRef')
ALTER TABLE [POS].[SettlementItem]  ADD  CONSTRAINT [FK_POS_SettlementItem_InvoiceRef] FOREIGN KEY([InvoiceRef])
REFERENCES [POS].[Invoice] ([InvoiceId])
GO
If not Exists (select 1 from sys.objects where name = 'FK_POS_SettlementItem_ReturnedInvoiceRef')
ALTER TABLE [POS].[SettlementItem]  ADD  CONSTRAINT [FK_POS_SettlementItem_ReturnedInvoiceRef] FOREIGN KEY([ReturnedInvoiceRef])
REFERENCES [POS].[ReturnedInvoice] ([ReturnedInvoiceId])
GO
If not Exists (select 1 from sys.objects where name = 'FK_SLS_SettlementItem_InvoiceRef')
ALTER TABLE [POS].[SettlementItem]  ADD  CONSTRAINT [FK_SLS_SettlementItem_InvoiceRef] FOREIGN KEY([SalesInvoiceRef])
REFERENCES [SLS].[Invoice] ([InvoiceId])
GO
If not Exists (select 1 from sys.objects where name = 'FK_SLS_SettlementItem_ReturnedInvoiceRef')
ALTER TABLE [POS].[SettlementItem]  ADD  CONSTRAINT [FK_SLS_SettlementItem_ReturnedInvoiceRef] FOREIGN KEY([SalesReturnedInvoiceRef])
REFERENCES [SLS].[ReturnedInvoice] ([ReturnedInvoiceId])
GO

--<< DROP OBJECTS >>--
