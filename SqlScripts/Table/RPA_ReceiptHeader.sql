--<<FileName:RPA_ReceiptHeader.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.ReceiptHeader') Is Null
CREATE TABLE [RPA].[ReceiptHeader](
	[ReceiptHeaderId] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[AccountSlRef] [int] NULL,
	[DlRef] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[Description] [nvarchar](4000) NOT NULL,
	[Description_En] [nvarchar](4000) NULL,
	[Discount] [decimal](19, 4) NOT NULL,
	[TotalAmount] [decimal](19, 4) NOT NULL,
	[ReceiptAmount]  AS ([TotalAmount]-[Discount]),
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
	[FiscalYearRef] [int] NOT NULL,
	[VoucherRef] [int] NULL,
	[DiscountRate] [decimal](26, 16) NULL,
	[DiscountInBaseCurrency] [decimal](19, 4) NULL,
	[Guid] [nvarchar](36) NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.ReceiptHeader') and
				[name] = 'ColumnName')
begin
    Alter table RPA.ReceiptHeader Add ColumnName DataType Nullable
end
GO*/
if not exists (select 1 from sys.columns where object_id=object_id('RPA.ReceiptHeader') and
				[name] = 'DiscountRate')
begin
    Alter table RPA.ReceiptHeader Add [DiscountRate] [decimal](26, 16) NULL
end
Go

if not exists (select 1 from sys.columns where object_id=object_id('RPA.ReceiptHeader') and
				[name] = 'DiscountInBaseCurrency')
begin
    Alter table RPA.ReceiptHeader Add [DiscountInBaseCurrency] [decimal](19, 4) NULL
end
Go

if not exists (select 1 from sys.columns where object_id=object_id('RPA.ReceiptHeader') and
				[name] = 'TotalAmountInBaseCurrency')
begin
    Alter table RPA.ReceiptHeader Add TotalAmountInBaseCurrency [decimal](19, 4) Null
end
Go

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('RPA.ReceiptHeader') and
	[name]='Guid')
BEGIN
	ALTER TABLE RPA.ReceiptHeader ADD [Guid] [nvarchar](36) NULL
END
Go

--<< ALTER COLUMNS >>--
if exists (select 1 from sys.columns where object_id=object_id('RPA.ReceiptHeader') and
				[name] = 'ReceiptAmount')
begin
    Alter table RPA.ReceiptHeader Drop column [ReceiptAmount]  
	Alter table RPA.ReceiptHeader Add  [ReceiptAmount]  AS ([TotalAmount]+[Discount])
end
GO

Alter table RPA.ReceiptHeader Alter Column [Rate] [decimal](26, 16) NOT NULL
Go
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ReceiveHeader')
ALTER TABLE [RPA].[ReceiptHeader] ADD  CONSTRAINT [PK_ReceiveHeader] PRIMARY KEY CLUSTERED 
(
	[ReceiptHeaderId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_ReceiptHeader_VoucherRef')
CREATE NONCLUSTERED INDEX [IX_ReceiptHeader_VoucherRef]
ON [RPA].[ReceiptHeader] ([VoucherRef])

GO
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ReceiptHeader_AccountSlRef')
ALTER TABLE [RPA].[ReceiptHeader]  ADD  CONSTRAINT [FK_ReceiptHeader_AccountSlRef] FOREIGN KEY([AccountSlRef])
REFERENCES [ACC].[Account] ([AccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiptHeader_CashRef')
ALTER TABLE [RPA].[ReceiptHeader]  ADD  CONSTRAINT [FK_ReceiptHeader_CashRef] FOREIGN KEY([CashRef])
REFERENCES [RPA].[Cash] ([CashId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiptHeader_DlRef')
ALTER TABLE [RPA].[ReceiptHeader]  ADD  CONSTRAINT [FK_ReceiptHeader_DlRef] FOREIGN KEY([DlRef])
REFERENCES [ACC].[DL] ([DLId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiptHeader_FiscalYearRef')
ALTER TABLE [RPA].[ReceiptHeader]  ADD  CONSTRAINT [FK_ReceiptHeader_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiptHeader_VoucherRef')
ALTER TABLE [RPA].[ReceiptHeader]  ADD  CONSTRAINT [FK_ReceiptHeader_VoucherRef] FOREIGN KEY([VoucherRef])
REFERENCES [ACC].[Voucher] ([VoucherId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReceiveHeader_CurrencyRef')
ALTER TABLE [RPA].[ReceiptHeader]  ADD  CONSTRAINT [FK_ReceiveHeader_CurrencyRef] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO

--<< DROP OBJECTS >>--
