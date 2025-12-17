--<<FileName:RPA_PaymentHeader.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.PaymentHeader') Is Null
CREATE TABLE [RPA].[PaymentHeader](
	[PaymentHeaderId] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[AccountSlRef] [int] NULL,
	[DlRef] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[Description] [nvarchar](4000) NOT NULL,
	[Description_En] [nvarchar](4000) NULL,
	[Discount] [decimal](19, 4) NULL,
	[TotalAmount] [decimal](19, 4) NULL,
	[PaymentAmount]  AS ([TotalAmount]+[Discount]),
	[ItemType] [int] NOT NULL,
	[State] [int] NOT NULL,
	[CreatorForm] [nvarchar](50) NOT NULL,
	[Creator] [int] NULL,
	[CreationDate] [datetime] NULL,
	[LastModifier] [int] NULL,
	[LastModificationDate] [datetime] NULL,
	[Version] [int] NOT NULL,
	[Rate] [decimal](26, 16) NOT NULL,
	[CashRef] [int] NULL,
	[Amount] [decimal](19, 4) NULL,
	[AmountInBaseCurrency] [decimal](19, 4) NOT NULL,
	[ReceiptHeaderRef] [int] NULL,
	[FiscalYearRef] [int] NOT NULL,
	[VoucherRef] [int] NULL, 
	[DiscountRate] [decimal](26, 16) NULL,
	[DiscountInBaseCurrency] [decimal](19, 4) NULL,	
	[BankFeeSlRef] [int] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.PaymentHeader') and
				[name] = 'ColumnName')
begin
    Alter table RPA.PaymentHeader Add ColumnName DataType Nullable
end
GO*/

if not exists (select 1 from sys.columns where object_id=object_id('RPA.PaymentHeader') and
				[name] = 'DiscountRate')
begin
    Alter table RPA.PaymentHeader Add [DiscountRate] [decimal](26, 16)  NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('RPA.PaymentHeader') and
				[name] = 'DiscountInBaseCurrency')
begin
    Alter table RPA.PaymentHeader Add [DiscountInBaseCurrency] [decimal](19, 4) NULL
end
GO


if not exists (select 1 from sys.columns where object_id=object_id('RPA.PaymentHeader') and
				[name] = 'TotalAmountInBaseCurrency')
begin
    Alter table RPA.PaymentHeader Add TotalAmountInBaseCurrency [decimal](19, 4) Null
end


--<< ALTER COLUMNS >>--

if exists (select 1 from sys.columns where object_id=object_id('RPA.PaymentHeader') and
				[name] = 'PaymentAmount')
begin
    Alter table RPA.PaymentHeader Drop column [PaymentAmount]  
	Alter table RPA.PaymentHeader Add  [PaymentAmount]  AS ([TotalAmount]+[Discount])
end
GO


Alter table RPA.PaymentHeader Alter column [Rate] [decimal](26, 16) NOT NULL 


Go

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('RPA.PaymentHeader') AND
				[name] = 'BankFeeSlRef')
BEGIN
    ALTER TABLE RPA.PaymentHeader ADD [BankFeeSlRef] [int]  NULL
END
GO

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_PaymentHeader')
ALTER TABLE [RPA].[PaymentHeader] ADD  CONSTRAINT [PK_PaymentHeader] PRIMARY KEY CLUSTERED 
(
	[PaymentHeaderId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_PaymentHeader_VoucherRef')
CREATE NONCLUSTERED INDEX [IX_PaymentHeader_VoucherRef]
ON [RPA].[PaymentHeader] ([VoucherRef])

GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_PaymentHeader_FiscalYearRef')
CREATE NONCLUSTERED INDEX [IX_PaymentHeader_FiscalYearRef]
ON [RPA].[PaymentHeader] ([FiscalYearRef])
include ([Type],[DlRef],[State])

Go
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_PaymentHeader_AccountSlRef')
ALTER TABLE [RPA].[PaymentHeader]  ADD  CONSTRAINT [FK_PaymentHeader_AccountSlRef] FOREIGN KEY([AccountSlRef])
REFERENCES [ACC].[Account] ([AccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PaymentHeader_CashRef')
ALTER TABLE [RPA].[PaymentHeader]  ADD  CONSTRAINT [FK_PaymentHeader_CashRef] FOREIGN KEY([CashRef])
REFERENCES [RPA].[Cash] ([CashId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PaymentHeader_Currency')
ALTER TABLE [RPA].[PaymentHeader]  ADD  CONSTRAINT [FK_PaymentHeader_Currency] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PaymentHeader_DL')
ALTER TABLE [RPA].[PaymentHeader]  ADD  CONSTRAINT [FK_PaymentHeader_DL] FOREIGN KEY([DlRef])
REFERENCES [ACC].[DL] ([DLId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PaymentHeader_FiscalYear')
ALTER TABLE [RPA].[PaymentHeader]  ADD  CONSTRAINT [FK_PaymentHeader_FiscalYear] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PaymentHeader_ReceiptHeaderRef')
ALTER TABLE [RPA].[PaymentHeader]  ADD  CONSTRAINT [FK_PaymentHeader_ReceiptHeaderRef] FOREIGN KEY([ReceiptHeaderRef])
REFERENCES [RPA].[ReceiptHeader] ([ReceiptHeaderId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_PaymentHeader_VoucherRef')
ALTER TABLE [RPA].[PaymentHeader]  ADD  CONSTRAINT [FK_PaymentHeader_VoucherRef] FOREIGN KEY([VoucherRef])
REFERENCES [ACC].[Voucher] ([VoucherId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_PaymentHeader_BankFeeSlRef')
ALTER TABLE [RPA].[PaymentHeader]  ADD  CONSTRAINT [FK_PaymentHeader_BankFeeSlRef] FOREIGN KEY([BankFeeSlRef])
REFERENCES [ACC].[Account] ([AccountId])

GO

--<< DROP OBJECTS >>--
