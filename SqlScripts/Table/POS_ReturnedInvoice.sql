--<<FileName:POS_ReturnedInvoice.sql>>--
--<< TABLE DEFINITION >>--
If Object_ID('POS.ReturnedInvoice') Is Null
CREATE TABLE [POS].[ReturnedInvoice](
	[ReturnedInvoiceId] [int] NOT NULL,
	[CustomerRealName] NVARCHAR(255) NULL,
	[CustomerRealName_En] NVARCHAR(255) NULL,
	[Description] NVARCHAR(255) NULL,
	[Description_En] NVARCHAR(255) NULL,
	[SaleTypeRef] [int] NOT NULL,
	[StockRef] [int] NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[State] [int] NOT NULL,
	[Price] [decimal](19, 4) NOT NULL,
	[Discount] [decimal](19, 4) NULL,
	[InvoiceDiscount] [decimal](19, 4) NULL,
	[Addition] [decimal](19, 4) NULL,
	[Tax] [decimal](19, 4) NULL,
	[Duty] [decimal](19, 4) NULL,
	[NetPrice]  [decimal](19, 4) NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[FiscalYearRef] [int]  NOT NULL,
	[CashAmount] [decimal](19, 4) NULL,
	[CardReaderAmount] [decimal](19, 4) NULL,
	[PosRef] int NULL,
	[TransactionNumber] NVARCHAR(255) NULL,
	[ChequeAmount] [decimal](19, 4) NULL,
	[ChequeSecondaryNumber] NVARCHAR(255) NULL,
	[OtherAmount] [decimal](19, 4) NULL,
	[OtherDescription] NVARCHAR(255) NULL,
	[CashPaidAmount]  AS CashAmount + CardReaderAmount + ChequeAmount + OtherAmount - NetPrice  PERSISTED,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

if not exists (select 1 from sys.columns where object_id=object_id('POS.ReturnedInvoice') and
				[name] = 'CashierRef')
begin
    Alter table POS.ReturnedInvoice Add [CashierRef] [int] NULL
end
GO
if exists (select 1 from sys.columns where object_id=object_id('POS.ReturnedInvoice') and
				[name] = 'CashierRef' and is_Nullable = 1)
begin
    Update POS.ReturnedInvoice Set [CashierRef] = IsNull((Select top 1 CashierID From POS.Cashier WHERE Creator = UserRef), (Select Top 1 CashierID From POS.Cashier) )
    Alter table POS.ReturnedInvoice Alter Column [CashierRef] [int] NOT NULL
end
GO

--<< ALTER COLUMNS >>--
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_POS_ReturnedInvoice')
ALTER TABLE [POS].[ReturnedInvoice] ADD  CONSTRAINT [PK_POS_ReturnedInvoice] PRIMARY KEY CLUSTERED 
(
	[ReturnedInvoiceId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_POS_ReturnedInvoice_CurrencyRef')
ALTER TABLE [POS].[ReturnedInvoice]  ADD  CONSTRAINT [FK_POS_ReturnedInvoice_CurrencyRef] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_POS_ReturnedInvoice_SaleTypeRef')
ALTER TABLE [POS].[ReturnedInvoice]  ADD  CONSTRAINT [FK_POS_ReturnedInvoice_SaleTypeRef] FOREIGN KEY([SaleTypeRef])
REFERENCES [SLS].[SaleType] ([SaleTypeId])

Go
If not Exists (select 1 from sys.objects where name = 'FK_POS_ReturnedInvoice_CashierRef')
ALTER TABLE [POS].[ReturnedInvoice]  ADD  CONSTRAINT [FK_POS_ReturnedInvoice_CashierRef] FOREIGN KEY([CashierRef])
REFERENCES [POS].[Cashier] ([CashierId])

Go
If not Exists (select 1 from sys.objects where name = 'FK_POS_ReturnedInvoice_FiscalYear')
ALTER TABLE [POS].[ReturnedInvoice]  ADD  CONSTRAINT [FK_POS_ReturnedInvoice_FiscalYear] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])
GO
If not Exists (select 1 from sys.objects where name = 'FK_POS_ReturnedInvoice_StockRef')
ALTER TABLE [POS].[ReturnedInvoice]  ADD  CONSTRAINT [FK_POS_ReturnedInvoice_StockRef] FOREIGN KEY([StockRef])
REFERENCES [INV].[Stock] ([StockID])
--<< DROP OBJECTS >>--
