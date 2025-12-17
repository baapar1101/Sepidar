--<<FileName:RPA_BankBillItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.BankBillItem') Is Null
CREATE TABLE [RPA].[BankBillItem](
	[BankBillItemId] [int] NOT NULL,
	[BankBillRef] [int] NOT NULL,
	[VoucherNumber] [nvarchar](20) NOT NULL,
	[VoucherDate] [datetime] NOT NULL,
	[Debit] [decimal](19, 4) NOT NULL,
	[Credit] [decimal](19, 4) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[Description_En] [nvarchar](250) NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.BankBillItem') and
				[name] = 'ColumnName')
begin
    Alter table RPA.BankBillItem Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_BankBillItem')
ALTER TABLE [RPA].[BankBillItem] ADD  CONSTRAINT [PK_BankBillItem] PRIMARY KEY CLUSTERED 
(
	[BankBillItemId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_BankBillItem_BankBillRef')
ALTER TABLE [RPA].[BankBillItem]  ADD  CONSTRAINT [FK_BankBillItem_BankBillRef] FOREIGN KEY([BankBillRef])
REFERENCES [RPA].[BankBill] ([BankBillId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

--<< DROP OBJECTS >>--
