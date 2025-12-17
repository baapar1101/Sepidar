--<<FileName:GNR_DebitCreditNote.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.DebitCreditNote') Is Null
CREATE TABLE [GNR].[DebitCreditNote](
	[DebitCreditNoteID] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[Rate] [decimal](26, 16) NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[VoucherRef] [int] NULL,
	[FiscalYearRef] [int] NOT NULL,
	[SumAmount] [decimal](19, 4) NOT NULL,
	[SumAmountInBaseCurrency] [decimal](19, 4) NULL,
	[PettyCashBillRef] [int] NULL,
	[Description] [nvarchar](4000) NULL,
	[Description_En] [nvarchar](4000) NULL

) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = object_id('GNR.DebitCreditNote') and
				[name] = 'Description')
BEGIN
    Alter table GNR.DebitCreditNote Add [Description] [nvarchar](4000) NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = object_id('GNR.DebitCreditNote') and
				[name] = 'Description_En')
BEGIN
    Alter table GNR.DebitCreditNote Add [Description_En] [nvarchar](4000) NULL
END
GO
--<<Sample>>--
if not exists (select 1 from sys.columns where object_id=object_id('GNR.DebitCreditNote') and
				[name] = 'SumAmountInBaseCurrency')
begin
    Alter table GNR.DebitCreditNote Add SumAmountInBaseCurrency [decimal](19, 4) NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('GNR.DebitCreditNote') and
				[name] = 'PettyCashBillRef')
begin
    Alter table GNR.DebitCreditNote Add PettyCashBillRef [int] NULL
end
GO

--<< ALTER COLUMNS >>--
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_DebitCreditNote')
ALTER TABLE [GNR].[DebitCreditNote] ADD  CONSTRAINT [PK_DebitCreditNote] PRIMARY KEY CLUSTERED 
(
	[DebitCreditNoteID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_DebitCreditNote_CurrencyRef')
ALTER TABLE [GNR].[DebitCreditNote]  ADD  CONSTRAINT [FK_DebitCreditNote_CurrencyRef] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_DebitCreditNote_FiscalYear')
ALTER TABLE [GNR].[DebitCreditNote]  ADD  CONSTRAINT [FK_DebitCreditNote_FiscalYear] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_GNR_DebitCreditNote_VoucherRef')
ALTER TABLE [GNR].[DebitCreditNote]  ADD  CONSTRAINT [FK_GNR_DebitCreditNote_VoucherRef] FOREIGN KEY([VoucherRef])
REFERENCES [ACC].[Voucher] ([VoucherId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_GNR_DebitCreditNote_PettyCashBillRef')
ALTER TABLE [GNR].[DebitCreditNote]  ADD  CONSTRAINT [FK_GNR_DebitCreditNote_PettyCashBillRef] FOREIGN KEY([PettyCashBillRef])
REFERENCES [RPA].[PettyCashBill] ([PettyCashBillId])

GO

--<< DROP OBJECTS >>--
