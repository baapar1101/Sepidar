--<<FileName:RPA_Reconciliation.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.Reconciliation') Is Null
CREATE TABLE [RPA].[Reconciliation](
	[ReconciliationId] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[BankAccountRef] [int] NOT NULL,
	[BankBillRef] [int] NULL,
	[Date] [datetime] NOT NULL,
	[State] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL,
	[FiscalYearRef] [int] NOT NULL,
	[BankBalance] [decimal](19, 4) NOT NULL,
	[BankBillBalance] [decimal](19, 4) NOT NULL,
	[BankBalanceInBaseCurrency] [decimal](19, 4) NULL,
	[BankBillBalanceInBaseCurrency] [decimal](19, 4) NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.Reconciliation') and
				[name] = 'ColumnName')
begin
    Alter table RPA.Reconciliation Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Reconciliation')
ALTER TABLE [RPA].[Reconciliation] ADD  CONSTRAINT [PK_Reconciliation] PRIMARY KEY CLUSTERED 
(
	[ReconciliationId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Reconciliation_BankAccountRef')
ALTER TABLE [RPA].[Reconciliation]  ADD  CONSTRAINT [FK_Reconciliation_BankAccountRef] FOREIGN KEY([BankAccountRef])
REFERENCES [RPA].[BankAccount] ([BankAccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Reconciliation_BankBillRef')
ALTER TABLE [RPA].[Reconciliation]  ADD  CONSTRAINT [FK_Reconciliation_BankBillRef] FOREIGN KEY([BankBillRef])
REFERENCES [RPA].[BankBill] ([BankBillId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Reconciliation_FiscalYearRef')
ALTER TABLE [RPA].[Reconciliation]  ADD  CONSTRAINT [FK_Reconciliation_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO

--<< DROP OBJECTS >>--
