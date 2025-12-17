--<<FileName:RPA_PaymentChequeBanking.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.PaymentChequeBanking') Is Null
CREATE TABLE [RPA].[PaymentChequeBanking](
	[PaymentChequeBankingId] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[BankAccountRef] [int] NULL,
	[Number] [int] NOT NULL,
	[Creator] [int] NULL,
	[CreationDate] [datetime] NULL,
	[LastModifier] [int] NULL,
	[LastModificationDate] [datetime] NULL,
	[Version] [int] NOT NULL,
	[State] [int] NOT NULL,
	[FiscalYearRef] [int] NOT NULL,
	[VoucherRef] [int] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.PaymentChequeBanking') and
				[name] = 'ColumnName')
begin
    Alter table RPA.PaymentChequeBanking Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_PaymentChequeBanking')
ALTER TABLE [RPA].[PaymentChequeBanking] ADD  CONSTRAINT [PK_PaymentChequeBanking] PRIMARY KEY CLUSTERED 
(
	[PaymentChequeBankingId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_PaymentChequeBanking_BankAccount')
ALTER TABLE [RPA].[PaymentChequeBanking]  ADD  CONSTRAINT [FK_PaymentChequeBanking_BankAccount] FOREIGN KEY([BankAccountRef])
REFERENCES [RPA].[BankAccount] ([BankAccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PaymentChequeBanking_FiscalYearRef')
ALTER TABLE [RPA].[PaymentChequeBanking]  ADD  CONSTRAINT [FK_PaymentChequeBanking_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PaymentChequeBanking_Voucher')
ALTER TABLE [RPA].[PaymentChequeBanking]  ADD  CONSTRAINT [FK_PaymentChequeBanking_Voucher] FOREIGN KEY([VoucherRef])
REFERENCES [ACC].[Voucher] ([VoucherId])

GO

--<< DROP OBJECTS >>--
