--<<FileName:RPA_RefundCheque.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('RPA.RefundCheque') Is Null
CREATE TABLE [RPA].[RefundCheque](
	[RefundChequeId] [int] NOT NULL,
	[DlRef] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Type] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[ReceiptHeaderRef] [int] NULL,
	[PaymentHeaderRef] [int] NULL,
	[CurrencyRef] [int] NOT NULL,
	[Creator] [int] NULL,
	[CreationDate] [datetime] NULL,
	[LastModifier] [int] NULL,
	[LastModificationDate] [datetime] NULL,
	[Version] [int] NOT NULL,
	[State] [int] NOT NULL,
	[FiscalYearRef] [int] NOT NULL,
	[VoucherRef] [int] NULL,
	[Description] [nvarchar](4000) NULL,
	[Description_En] [nvarchar](4000) NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('RPA.RefundCheque') and
				[name] = 'ColumnName')
begin
    Alter table RPA.RefundCheque Add ColumnName DataType Nullable
end
GO*/

if not exists (select 1 from sys.columns where object_id=object_id('RPA.RefundCheque') and
				[name] = 'Description')
begin
    Alter table [RPA].[RefundCheque] Add [Description] [nvarchar](4000) NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('RPA.RefundCheque') and
				[name] = 'Description_En')
begin
    Alter table [RPA].[RefundCheque] Add [Description_En] [nvarchar](4000) NULL
end
GO

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_RefundCheque')
ALTER TABLE [RPA].[RefundCheque] ADD  CONSTRAINT [PK_RefundCheque] PRIMARY KEY CLUSTERED 
(
	[RefundChequeId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_RefundCheque_CurrencyRef')
ALTER TABLE [RPA].[RefundCheque]  ADD  CONSTRAINT [FK_RefundCheque_CurrencyRef] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_RefundCheque_DLRef')
ALTER TABLE [RPA].[RefundCheque]  ADD  CONSTRAINT [FK_RefundCheque_DLRef] FOREIGN KEY([DlRef])
REFERENCES [ACC].[DL] ([DLId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_RefundCheque_FiscalYearRef')
ALTER TABLE [RPA].[RefundCheque]  ADD  CONSTRAINT [FK_RefundCheque_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_RefundCheque_PaymentHeaderRef')
ALTER TABLE [RPA].[RefundCheque]  ADD  CONSTRAINT [FK_RefundCheque_PaymentHeaderRef] FOREIGN KEY([PaymentHeaderRef])
REFERENCES [RPA].[PaymentHeader] ([PaymentHeaderId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_RefundCheque_ReceiptHeaderRef')
ALTER TABLE [RPA].[RefundCheque]  ADD  CONSTRAINT [FK_RefundCheque_ReceiptHeaderRef] FOREIGN KEY([ReceiptHeaderRef])
REFERENCES [RPA].[ReceiptHeader] ([ReceiptHeaderId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_RefundCheque_VoucherRef')
ALTER TABLE [RPA].[RefundCheque]  ADD  CONSTRAINT [FK_RefundCheque_VoucherRef] FOREIGN KEY([VoucherRef])
REFERENCES [ACC].[Voucher] ([VoucherId])

GO

--<< DROP OBJECTS >>--
