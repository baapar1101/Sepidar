--<<FileName:RPA_BankBill.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.BankBill') Is Null
CREATE TABLE [RPA].[BankBill](
	[BankBillId] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[FiscalYearRef] [int] NOT NULL,
	[BankAccountRef] [int] NOT NULL,
	[Description] [nvarchar](250) NULL,
	[Description_En] [nvarchar](250) NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.BankBill') and
				[name] = 'ColumnName')
begin
    Alter table RPA.BankBill Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_BankBill')
ALTER TABLE [RPA].[BankBill] ADD  CONSTRAINT [PK_BankBill] PRIMARY KEY CLUSTERED 
(
	[BankBillId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_BankBill_BankAccountRef')
ALTER TABLE [RPA].[BankBill]  ADD  CONSTRAINT [FK_BankBill_BankAccountRef] FOREIGN KEY([BankAccountRef])
REFERENCES [RPA].[BankAccount] ([BankAccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_RPA_BankBill_FiscalYearRef')
ALTER TABLE [RPA].[BankBill]  ADD  CONSTRAINT [FK_RPA_BankBill_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO

--<< DROP OBJECTS >>--
