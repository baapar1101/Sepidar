--<<FileName:RPA_ReceiptChequeBankingItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.ReceiptChequeBankingItem') Is Null
CREATE TABLE [RPA].[ReceiptChequeBankingItem](
	[ReceiptChequeBankingItemId] [int] NOT NULL,
	[ReceiptChequeBankingRef] [int] NOT NULL,
	[ReceiptChequeRef] [int] NOT NULL,
	[ReceiptChequeBankingItemRef] [int] NULL,
	[ForcastDate] [datetime] NULL,
	[State] [int] NOT NULL,
	[HeaderDate] [datetime] NOT NULL,
	[HeaderNumber] [int] NOT NULL,
	[BankAccountRef] [int] NULL,
	[CashRef] [int] NULL,
	[HeaderState] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.ReceiptChequeBankingItem') and
				[name] = 'ColumnName')
begin
    Alter table RPA.ReceiptChequeBankingItem Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Table_1')
ALTER TABLE [RPA].[ReceiptChequeBankingItem] ADD  CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[ReceiptChequeBankingItemId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ReceiptChequeBankingItem_BankAccountRef')
ALTER TABLE [RPA].[ReceiptChequeBankingItem]  ADD  CONSTRAINT [FK_ReceiptChequeBankingItem_BankAccountRef] FOREIGN KEY([BankAccountRef])
REFERENCES [RPA].[BankAccount] ([BankAccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiptChequeBankingItem_CashRef')
ALTER TABLE [RPA].[ReceiptChequeBankingItem]  ADD  CONSTRAINT [FK_ReceiptChequeBankingItem_CashRef] FOREIGN KEY([CashRef])
REFERENCES [RPA].[Cash] ([CashId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiptChequeBankingItem_ReceiptCheque')
ALTER TABLE [RPA].[ReceiptChequeBankingItem]  ADD  CONSTRAINT [FK_ReceiptChequeBankingItem_ReceiptCheque] FOREIGN KEY([ReceiptChequeRef])
REFERENCES [RPA].[ReceiptCheque] ([ReceiptChequeId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiptChequeBankingItem_ReceiptChequeBankingItemRef')
ALTER TABLE [RPA].[ReceiptChequeBankingItem]  ADD  CONSTRAINT [FK_ReceiptChequeBankingItem_ReceiptChequeBankingItemRef] FOREIGN KEY([ReceiptChequeBankingItemRef])
REFERENCES [RPA].[ReceiptChequeBankingItem] ([ReceiptChequeBankingItemId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiptChequeBankingItem_ReceiptChequeBankingRef')
ALTER TABLE [RPA].[ReceiptChequeBankingItem]  ADD  CONSTRAINT [FK_ReceiptChequeBankingItem_ReceiptChequeBankingRef] FOREIGN KEY([ReceiptChequeBankingRef])
REFERENCES [RPA].[ReceiptChequeBanking] ([ReceiptChequeBankingId])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
