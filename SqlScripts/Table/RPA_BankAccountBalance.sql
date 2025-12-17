--<<FileName:RPA_BankAccountBalance.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.BankAccountBalance') Is Null
CREATE TABLE [RPA].[BankAccountBalance](
	[BankAccountBalanceId] [int] NOT NULL,
	[Balance] [decimal](19, 4) NOT NULL,
	[FiscalYearRef] [int] NOT NULL,
	[BankAccountRef] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--

GO

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_BankAccountBalance')
ALTER TABLE [RPA].[BankAccountBalance] ADD  CONSTRAINT [PK_BankAccountBalance] PRIMARY KEY CLUSTERED 
(
	[BankAccountBalanceId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_BankAccountBalance_BankAccount')
ALTER TABLE [RPA].[BankAccountBalance]  ADD  CONSTRAINT [FK_BankAccountBalance_BankAccount] FOREIGN KEY([BankAccountRef])
REFERENCES [RPA].[BankAccount] ([BankAccountId])

Go

If not Exists (select 1 from sys.objects where name = 'FK_BankAccountBalance_FiscalYearRef')
ALTER TABLE [RPA].[BankAccountBalance]  ADD  CONSTRAINT [FK_BankAccountBalance_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

Go
--<< DROP OBJECTS >>--
