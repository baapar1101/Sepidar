--<<FileName:RPA_ReceiptChequeHistory.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.ReceiptChequeHistory') Is Null
CREATE TABLE [RPA].[ReceiptChequeHistory](
	[ReceiptChequeHistoryId] [int] NOT NULL,
	[State] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[ReceiptChequeHistoryRef] [int] NULL,
	[ReceiptChequeRef] [int] NOT NULL,
	[ReceiptChequeBankingItemRef] [int] NULL,
	[PaymentChequeOtherRef] [int] NULL,
	[RefundChequeItemRef] [int] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.ReceiptChequeHistory') and
				[name] = 'ColumnName')
begin
    Alter table RPA.ReceiptChequeHistory Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ReceiptChequeHistory')
ALTER TABLE [RPA].[ReceiptChequeHistory] ADD  CONSTRAINT [PK_ReceiptChequeHistory] PRIMARY KEY CLUSTERED 
(
	[ReceiptChequeHistoryId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ReceiptChequeHistory_PaymentChequeOther')
ALTER TABLE [RPA].[ReceiptChequeHistory]  ADD  CONSTRAINT [FK_ReceiptChequeHistory_PaymentChequeOther] FOREIGN KEY([PaymentChequeOtherRef])
REFERENCES [RPA].[PaymentChequeOther] ([PaymentChequeOtherId])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiptChequeHistory_ReceiptCheque')
ALTER TABLE [RPA].[ReceiptChequeHistory]  ADD  CONSTRAINT [FK_ReceiptChequeHistory_ReceiptCheque] FOREIGN KEY([ReceiptChequeRef])
REFERENCES [RPA].[ReceiptCheque] ([ReceiptChequeId])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiptChequeHistory_ReceiptChequeBankingItem')
ALTER TABLE [RPA].[ReceiptChequeHistory]  ADD  CONSTRAINT [FK_ReceiptChequeHistory_ReceiptChequeBankingItem] FOREIGN KEY([ReceiptChequeBankingItemRef])
REFERENCES [RPA].[ReceiptChequeBankingItem] ([ReceiptChequeBankingItemId])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiptChequeHistory_ReceiptChequeHistory')
ALTER TABLE [RPA].[ReceiptChequeHistory]  ADD  CONSTRAINT [FK_ReceiptChequeHistory_ReceiptChequeHistory] FOREIGN KEY([ReceiptChequeHistoryRef])
REFERENCES [RPA].[ReceiptChequeHistory] ([ReceiptChequeHistoryId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiptChequeHistory_RefundChequeItem')
ALTER TABLE [RPA].[ReceiptChequeHistory]  ADD  CONSTRAINT [FK_ReceiptChequeHistory_RefundChequeItem] FOREIGN KEY([RefundChequeItemRef])
REFERENCES [RPA].[RefundChequeItem] ([RefundChequeItemID])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
