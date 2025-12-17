--<<FileName:RPA_PaymentChequeBankingItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.PaymentChequeBankingItem') Is Null
CREATE TABLE [RPA].[PaymentChequeBankingItem](
	[PaymentChequeBankingItemId] [int] NOT NULL,
	[PaymentChequeBankingRef] [int] NOT NULL,
	[PaymentChequeRef] [int] NOT NULL,
	[HeaderDate] [datetime] NOT NULL,
	[HeaderNumber] [int] NOT NULL,
	[BankAccountRef] [int] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.PaymentChequeBankingItem') and
				[name] = 'ColumnName')
begin
    Alter table RPA.PaymentChequeBankingItem Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_PaymentChequeBankingItem')
ALTER TABLE [RPA].[PaymentChequeBankingItem] ADD  CONSTRAINT [PK_PaymentChequeBankingItem] PRIMARY KEY CLUSTERED 
(
	[PaymentChequeBankingItemId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_PaymentChequeBankingItem_BankAccountRef')
ALTER TABLE [RPA].[PaymentChequeBankingItem]  ADD  CONSTRAINT [FK_PaymentChequeBankingItem_BankAccountRef] FOREIGN KEY([BankAccountRef])
REFERENCES [RPA].[BankAccount] ([BankAccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PaymentChequeBankingItem_PaymentCheque')
ALTER TABLE [RPA].[PaymentChequeBankingItem]  ADD  CONSTRAINT [FK_PaymentChequeBankingItem_PaymentCheque] FOREIGN KEY([PaymentChequeRef])
REFERENCES [RPA].[PaymentCheque] ([PaymentChequeId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PaymentChequeBankingItem_PaymentChequeBanking')
ALTER TABLE [RPA].[PaymentChequeBankingItem]  ADD  CONSTRAINT [FK_PaymentChequeBankingItem_PaymentChequeBanking] FOREIGN KEY([PaymentChequeBankingRef])
REFERENCES [RPA].[PaymentChequeBanking] ([PaymentChequeBankingId])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
