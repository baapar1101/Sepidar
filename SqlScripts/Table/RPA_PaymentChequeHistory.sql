--<<FileName:RPA_PaymentChequeHistory.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.PaymentChequeHistory') Is Null
CREATE TABLE [RPA].[PaymentChequeHistory](
	[PaymentChequeHistoryId] [int] NOT NULL,
	[State] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[DurationType] [int] NULL,
	[PaymentChequeHistoryRef] [int] NULL,
	[PaymentChequeRef] [int] NOT NULL,
	[PaymentChequeBankingItemRef] [int] NULL,
	[RefundChequeItemRef] [int] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.PaymentChequeHistory') and
				[name] = 'ColumnName')
begin
    Alter table RPA.PaymentChequeHistory Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_PaymentChequeHistory')
ALTER TABLE [RPA].[PaymentChequeHistory] ADD  CONSTRAINT [PK_PaymentChequeHistory] PRIMARY KEY CLUSTERED 
(
	[PaymentChequeHistoryId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_PaymentChequeHistory_PaymentChequeBankingItem')
ALTER TABLE [RPA].[PaymentChequeHistory]  ADD  CONSTRAINT [FK_PaymentChequeHistory_PaymentChequeBankingItem] FOREIGN KEY([PaymentChequeBankingItemRef])
REFERENCES [RPA].[PaymentChequeBankingItem] ([PaymentChequeBankingItemId])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_PaymentChequeHistory_PaymentChequeHistory')
ALTER TABLE [RPA].[PaymentChequeHistory]  ADD  CONSTRAINT [FK_PaymentChequeHistory_PaymentChequeHistory] FOREIGN KEY([PaymentChequeHistoryRef])
REFERENCES [RPA].[PaymentChequeHistory] ([PaymentChequeHistoryId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PaymentChequeHistory_PaymentChequeRef')
ALTER TABLE [RPA].[PaymentChequeHistory]  ADD  CONSTRAINT [FK_PaymentChequeHistory_PaymentChequeRef] FOREIGN KEY([PaymentChequeRef])
REFERENCES [RPA].[PaymentCheque] ([PaymentChequeId])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_PaymentChequeHistory_RefundChequeItem')
ALTER TABLE [RPA].[PaymentChequeHistory]  ADD  CONSTRAINT [FK_PaymentChequeHistory_RefundChequeItem] FOREIGN KEY([RefundChequeItemRef])
REFERENCES [RPA].[RefundChequeItem] ([RefundChequeItemID])
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
