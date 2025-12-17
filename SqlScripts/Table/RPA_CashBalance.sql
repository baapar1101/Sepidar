--<<FileName:RPA_CashBalance.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.CashBalance') Is Null
CREATE TABLE [RPA].[CashBalance](
	[CashBalanceId] [int] NOT NULL,
	[Balance] [decimal](19, 4) NOT NULL,
	[FiscalYearRef] [int] NOT NULL,
	[CashRef] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<< ALTER COLUMNS >>--

GO

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_CashBalance')
ALTER TABLE [RPA].[CashBalance] ADD  CONSTRAINT [PK_CashBalance] PRIMARY KEY CLUSTERED 
(
	[CashBalanceId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_CashBalance_Cash')
ALTER TABLE [RPA].[CashBalance]  ADD  CONSTRAINT [FK_CashBalance_Cash] FOREIGN KEY([CashRef])
REFERENCES [RPA].[Cash] ([CashId])

Go

If not Exists (select 1 from sys.objects where name = 'FK_CashBalance_FiscalYearRef')
ALTER TABLE [RPA].[CashBalance]  ADD  CONSTRAINT [FK_CashBalance_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

Go
--<< DROP OBJECTS >>--
