--<<FileName:RPA_ReconciliationItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.ReconciliationItem') Is Null
CREATE TABLE [RPA].[ReconciliationItem](
	[ReconciliationItemId] [int] NOT NULL,
	[ReceiptDraftRef] [int] NULL,
	[PaymentDraftRef] [int] NULL,
	[ReceiptChequeBankingItemRef] [int] NULL,
	[PaymentChequeBankingItemRef] [int] NULL,
	[PaymentChequeRef] [int] NULL,
	[RefundChequeItemRef] [int] NULL,
	[RelationNo] [int] NULL,
	[Type] [int] NOT NULL,
	[Number] [nvarchar](255) NOT NULL,
	[Date] [datetime] NOT NULL,
	[Debit] [decimal](19, 4) NOT NULL,
	[Credit] [decimal](19, 4) NOT NULL,
	[ReconciliationRef] [int] NOT NULL,
	[ReconciliationItemRef] [int] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.ReconciliationItem') and
				[name] = 'ColumnName')
begin
    Alter table RPA.ReconciliationItem Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ReconciliationItem')
ALTER TABLE [RPA].[ReconciliationItem] ADD  CONSTRAINT [PK_ReconciliationItem] PRIMARY KEY CLUSTERED 
(
	[ReconciliationItemId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ReconciliationItem_PaymentChequeBankingItemRef')
ALTER TABLE [RPA].[ReconciliationItem]  ADD  CONSTRAINT [FK_ReconciliationItem_PaymentChequeBankingItemRef] FOREIGN KEY([PaymentChequeBankingItemRef])
REFERENCES [RPA].[PaymentChequeBankingItem] ([PaymentChequeBankingItemId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReconciliationItem_PaymentChequeRef')
ALTER TABLE [RPA].[ReconciliationItem]  ADD  CONSTRAINT [FK_ReconciliationItem_PaymentChequeRef] FOREIGN KEY([PaymentChequeRef])
REFERENCES [RPA].[PaymentCheque] ([PaymentChequeId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReconciliationItem_PaymentDraftRef')
ALTER TABLE [RPA].[ReconciliationItem]  ADD  CONSTRAINT [FK_ReconciliationItem_PaymentDraftRef] FOREIGN KEY([PaymentDraftRef])
REFERENCES [RPA].[PaymentDraft] ([PaymentDraftId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReconciliationItem_ReceiptChequeBankingItemRef')
ALTER TABLE [RPA].[ReconciliationItem]  ADD  CONSTRAINT [FK_ReconciliationItem_ReceiptChequeBankingItemRef] FOREIGN KEY([ReceiptChequeBankingItemRef])
REFERENCES [RPA].[ReceiptChequeBankingItem] ([ReceiptChequeBankingItemId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReconciliationItem_ReceiptDraftRef')
ALTER TABLE [RPA].[ReconciliationItem]  ADD  CONSTRAINT [FK_ReconciliationItem_ReceiptDraftRef] FOREIGN KEY([ReceiptDraftRef])
REFERENCES [RPA].[ReceiptDraft] ([ReceiptDraftId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReconciliationItem_ReconciliationItemRef')
ALTER TABLE [RPA].[ReconciliationItem]  ADD  CONSTRAINT [FK_ReconciliationItem_ReconciliationItemRef] FOREIGN KEY([ReconciliationItemRef])
REFERENCES [RPA].[ReconciliationItem] ([ReconciliationItemId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReconciliationItem_ReconciliationRef')
ALTER TABLE [RPA].[ReconciliationItem]  ADD  CONSTRAINT [FK_ReconciliationItem_ReconciliationRef] FOREIGN KEY([ReconciliationRef])
REFERENCES [RPA].[Reconciliation] ([ReconciliationId])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReconciliationItem_RefundChequeItemRef')
ALTER TABLE [RPA].[ReconciliationItem]  ADD  CONSTRAINT [FK_ReconciliationItem_RefundChequeItemRef] FOREIGN KEY([RefundChequeItemRef])
REFERENCES [RPA].[RefundChequeItem] ([RefundChequeItemID])

GO

--<< DROP OBJECTS >>--
