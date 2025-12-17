--<<FileName:RPA_ReceiptChequeBanking.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.ReceiptChequeBanking') Is Null
CREATE TABLE [RPA].[ReceiptChequeBanking](
	[ReceiptChequeBankingId] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Type] [int] NOT NULL,
	[RelationNo] [int] NULL,
	[BankAccountRef] [int] NULL,
	[Number] [int] NOT NULL,
	[Creator] [int] NULL,
	[Version] [int] NOT NULL,
	[ReceiptChequeBankingRef] [int] NULL,
	[CashRef] [int] NULL,
	[State] [int] NOT NULL,
	[CreationDate] [datetime] NULL,
	[LastModifier] [int] NULL,
	[LastModificationDate] [datetime] NULL,
	[FiscalYearRef] [int] NOT NULL,
	[VoucherRef] [int] NULL,
	[SubmitNumber] [nvarchar](20) NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.ReceiptChequeBanking') and
				[name] = 'ColumnName')
begin
    Alter table RPA.ReceiptChequeBanking Add ColumnName DataType Nullable
end
GO*/
if not exists (select 1 from sys.columns where object_id=object_id('RPA.ReceiptChequeBanking') and
				[name] = 'SubmitNumber')
begin
    Alter table RPA.ReceiptChequeBanking Add SubmitNumber   [nvarchar](20)  NULL
end
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ReceiptChequeBanking')
ALTER TABLE [RPA].[ReceiptChequeBanking] ADD  CONSTRAINT [PK_ReceiptChequeBanking] PRIMARY KEY CLUSTERED 
(
	[ReceiptChequeBankingId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ReceiptChequeBanking_BankAccountRef')
ALTER TABLE [RPA].[ReceiptChequeBanking]  ADD  CONSTRAINT [FK_ReceiptChequeBanking_BankAccountRef] FOREIGN KEY([BankAccountRef])
REFERENCES [RPA].[BankAccount] ([BankAccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiptChequeBanking_CashRef')
ALTER TABLE [RPA].[ReceiptChequeBanking]  ADD  CONSTRAINT [FK_ReceiptChequeBanking_CashRef] FOREIGN KEY([CashRef])
REFERENCES [RPA].[Cash] ([CashId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiptChequeBanking_FiscalYearRef')
ALTER TABLE [RPA].[ReceiptChequeBanking]  ADD  CONSTRAINT [FK_ReceiptChequeBanking_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiptChequeBanking_ReceiptChequeBankingRef')
ALTER TABLE [RPA].[ReceiptChequeBanking]  ADD  CONSTRAINT [FK_ReceiptChequeBanking_ReceiptChequeBankingRef] FOREIGN KEY([ReceiptChequeBankingRef])
REFERENCES [RPA].[ReceiptChequeBanking] ([ReceiptChequeBankingId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiptChequeBanking_Voucher')
ALTER TABLE [RPA].[ReceiptChequeBanking]  ADD  CONSTRAINT [FK_ReceiptChequeBanking_Voucher] FOREIGN KEY([VoucherRef])
REFERENCES [ACC].[Voucher] ([VoucherId])

GO

--<< DROP OBJECTS >>--
