--<<FileName:SLS_ReturnedInvoice.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.ReturnedInvoice') Is Null
CREATE TABLE [SLS].[ReturnedInvoice](
	[ReturnedInvoiceId] [int] NOT NULL,
	[QuotationRef] [int] NULL,
	[CustomerPartyRef] [int] NOT NULL,
	[CustomerRealName] NVARCHAR(255) NULL,
	[CustomerRealName_En] NVARCHAR(255) NULL,
	[SaleTypeRef] [int] NOT NULL,
	[PartyAddressRef] [int] NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[SLRef] [int] NOT NULL,
	[Price] [decimal](19, 4) NOT NULL,
	[PriceInBaseCurrency]  [decimal](19, 4) NOT NULL,
	[Discount] [decimal](19, 4) NULL,
	[DiscountInBaseCurrency]  [decimal](19, 4) NULL,
	[Addition] [decimal](19, 4) NULL,
	[AdditionInBaseCurrency]  [decimal](19, 4) NULL,
	[Tax] [decimal](19, 4) NULL,
	[TaxInBaseCurrency]  [decimal](19, 4) NULL,
	[Duty] [decimal](19, 4) NULL,
	[DutyInBaseCurrency] [decimal](19, 4) NULL,
	[AdditionFactor_VatEffective] [decimal](19, 4) NOT NULL,
	[AdditionFactorInBaseCurrency_VatEffective] [decimal](19, 4) NOT NULL,
	[AdditionFactor_VatIneffective] [decimal](19, 4) NOT NULL,
	[AdditionFactorInBaseCurrency_VatIneffective] [decimal](19, 4) NOT NULL,
	[NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective),
	[NetPriceInBaseCurrency] [decimal](19, 4) NOT NULL,
	[Rate] [decimal](26, 16) NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[FiscalYearRef] [int]  NOT NULL,
	[VoucherRef] [int] NULL,
	[PaymentHeaderRef] [int] NULL,
	[Guid] [nvarchar](36) NULL,
	[TaxPayerBillIssueDateTime] [DateTime] NULL,
	[Description] [nvarchar](4000) NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoice') and
				[name] = 'ColumnName')
begin
    Alter table SLS.ReturnedInvoice Add ColumnName DataType Nullable
end
GO*/


IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.ReturnedInvoice') AND
	[name] = 'Description' )
BEGIN
	ALTER TABLE SLS.ReturnedInvoice ADD [Description] [nvarchar](4000) NULL
END
GO


IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.ReturnedInvoice') AND
	[name] = 'SignatureRef' )
BEGIN
	ALTER TABLE SLS.ReturnedInvoice ADD [SignatureRef] [int] NULL
END
GO


IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.ReturnedInvoice') and
	[name]='Guid')
BEGIN
	ALTER TABLE SLS.ReturnedInvoice ADD [Guid] [nvarchar](36) NULL
END
Go

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.ReturnedInvoice') and
	[name]='TaxPayerBillIssueDateTime')
BEGIN
	ALTER TABLE SLS.ReturnedInvoice ADD [TaxPayerBillIssueDateTime] [DateTime] NULL
END
Go

if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoice') and
				[name] = 'FiscalYearRef')
begin
    Alter table SLS.ReturnedInvoice Add FiscalYearRef int NULL
end

if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoice') and
				[name] = 'VoucherRef')
begin
    Alter table SLS.ReturnedInvoice Add VoucherRef int NULL
end
Go

if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoice') and
				[name] = 'CustomerRealName')
begin
    Alter table SLS.ReturnedInvoice Add CustomerRealName NVarChar(255)
end

if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoice') and
				[name] = 'CustomerRealName_En')
begin
    Alter table SLS.ReturnedInvoice Add CustomerRealName_En NVarChar(255)
end

IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.ReturnedInvoice') and
				[name] = 'PaymentHeaderRef')
BEGIN
    ALTER TABLE SLS.ReturnedInvoice ADD PaymentHeaderRef INT NULL
END

if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoice') and
				[name] = 'AdditionFactor_VatEffective')
begin
    Alter table SLS.ReturnedInvoice Add [AdditionFactor_VatEffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.[ReturnedInvoice] SET AdditionFactor_VatEffective=0')
    Alter table SLS.ReturnedInvoice ALTER COLUMN [AdditionFactor_VatEffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoice') and
				[name] = 'AdditionFactorInBaseCurrency_VatEffective')
begin
    Alter table SLS.ReturnedInvoice Add [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.[ReturnedInvoice] SET AdditionFactorInBaseCurrency_VatEffective=0')
    Alter table SLS.ReturnedInvoice ALTER COLUMN [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoice') and
				[name] = 'AdditionFactor_VatIneffective')
begin
    Alter table SLS.ReturnedInvoice Add [AdditionFactor_VatIneffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.[ReturnedInvoice] SET AdditionFactor_VatIneffective=0')
    Alter table SLS.ReturnedInvoice ALTER COLUMN [AdditionFactor_VatIneffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoice') and
				[name] = 'AdditionFactorInBaseCurrency_VatIneffective')
begin
    Alter table SLS.ReturnedInvoice Add [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.[ReturnedInvoice] SET AdditionFactorInBaseCurrency_VatIneffective=0')
    Alter table SLS.ReturnedInvoice ALTER COLUMN [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NOT NULL
end
GO

--<< ALTER COLUMNS >>--
IF EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.ReturnedInvoice') AND
				[name] = 'NetPriceInBaseCurrency' AND is_Computed = 1)
BEGIN
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.ReturnedInvoice') AND
			[name] = 'PriceInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.ReturnedInvoice DROP COLUMN PriceInBaseCurrency
	END

	IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.ReturnedInvoice') AND
			[name] = 'DiscountInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.ReturnedInvoice DROP COLUMN DiscountInBaseCurrency
	END

	IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.ReturnedInvoice') AND
			[name] = 'AdditionInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.ReturnedInvoice DROP COLUMN AdditionInBaseCurrency
	END
	
	IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.ReturnedInvoice') AND
			[name] = 'TaxInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.ReturnedInvoice DROP COLUMN TaxInBaseCurrency
	END


	IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.ReturnedInvoice') AND
			[name] = 'DutyInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.ReturnedInvoice DROP COLUMN DutyInBaseCurrency
	END

	IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.ReturnedInvoice') AND
			[name] = 'NetPriceInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.ReturnedInvoice DROP COLUMN NetPriceInBaseCurrency
	END
	
	

	IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.ReturnedInvoice') AND
			[name] = 'PriceInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.ReturnedInvoice ADD PriceInBaseCurrency DECIMAL(19,4)
	END

	IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.ReturnedInvoice') AND
			[name] = 'DiscountInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.ReturnedInvoice ADD DiscountInBaseCurrency DECIMAL(19,4)
	END
	
	IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.ReturnedInvoice') AND
			[name] = 'AdditionInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.ReturnedInvoice ADD AdditionInBaseCurrency DECIMAL(19,4)
	END
	
	IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.ReturnedInvoice') AND
			[name] = 'TaxInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.ReturnedInvoice ADD TaxInBaseCurrency DECIMAL(19,4)
	END
	
	IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.ReturnedInvoice') AND
			[name] = 'DutyInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.ReturnedInvoice ADD DutyInBaseCurrency DECIMAL(19,4)
	END
	
	IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.ReturnedInvoice') AND
			[name] = 'NetPriceInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.ReturnedInvoice ADD NetPriceInBaseCurrency DECIMAL(19,4)
	END
END

if exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoice') and
				[name] = 'AdditionFactor_VatEffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[ReturnedInvoice] SET [AdditionFactor_VatEffective] = 0 where [AdditionFactor_VatEffective] IS NULL

	begin transaction
	IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
				WHERE OBJECT_ID=OBJECT_ID('SLS.ReturnedInvoice') AND [name] = 'NetPrice')
	BEGIN
		ALTER TABLE SLS.[ReturnedInvoice] DROP COLUMN NetPrice
	END

	Alter table SLS.[ReturnedInvoice] ALTER COLUMN [AdditionFactor_VatEffective] [decimal](19,4) NOT NULL
	ALTER TABLE SLS.[ReturnedInvoice] ADD [NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective)
	commit transaction
end
GO

if exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoice') and
				[name] = 'AdditionFactorInBaseCurrency_VatEffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[ReturnedInvoice] SET [AdditionFactorInBaseCurrency_VatEffective] = 0 where [AdditionFactorInBaseCurrency_VatEffective] IS NULL
    Alter table SLS.[ReturnedInvoice] ALTER COLUMN [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NOT NULL
end
GO

if exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoice') and
				[name] = 'AdditionFactor_VatIneffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[ReturnedInvoice] SET [AdditionFactor_VatIneffective] = 0 where [AdditionFactor_VatIneffective] IS NULL

	begin transaction
	
	IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
				WHERE OBJECT_ID=OBJECT_ID('SLS.ReturnedInvoice') AND [name] = 'NetPrice')
	BEGIN
		ALTER TABLE SLS.[ReturnedInvoice] DROP COLUMN NetPrice
	END

	Alter table SLS.[ReturnedInvoice] ALTER COLUMN [AdditionFactor_VatIneffective] [decimal](19,4) NOT NULL
	ALTER TABLE SLS.[ReturnedInvoice] ADD [NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective)

	commit transaction
end
GO

if exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoice') and
				[name] = 'AdditionFactorInBaseCurrency_VatIneffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[ReturnedInvoice] SET [AdditionFactorInBaseCurrency_VatIneffective] = 0 where [AdditionFactorInBaseCurrency_VatIneffective] IS NULL
    Alter table SLS.[ReturnedInvoice] ALTER COLUMN [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NOT NULL
end
GO

IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
		  WHERE OBJECT_ID=OBJECT_ID('SLS.ReturnedInvoice') AND [name] = 'NetPrice')
BEGIN
	ALTER TABLE SLS.ReturnedInvoice DROP COLUMN NetPrice
	ALTER TABLE SLS.ReturnedInvoice ADD [NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective)
END

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ReturnedInvoice')
ALTER TABLE [SLS].[ReturnedInvoice] ADD  CONSTRAINT [PK_ReturnedInvoice] PRIMARY KEY CLUSTERED 
(
	[ReturnedInvoiceId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_ReturnedInvoice_Guid')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_ReturnedInvoice_Guid] ON [SLS].[ReturnedInvoice]
(
	[Guid] ASC
) WHERE [Guid] IS NOT NULL ON [PRIMARY]
GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ReturnedInvoice_CurrencyRef')
ALTER TABLE [SLS].[ReturnedInvoice]  ADD  CONSTRAINT [FK_ReturnedInvoice_CurrencyRef] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReturnedInvoice_CustomerPartyRef')
ALTER TABLE [SLS].[ReturnedInvoice]  ADD  CONSTRAINT [FK_ReturnedInvoice_CustomerPartyRef] FOREIGN KEY([CustomerPartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReturnedInvoice_SLRef')
ALTER TABLE [SLS].[ReturnedInvoice]  ADD  CONSTRAINT [FK_ReturnedInvoice_SLRef] FOREIGN KEY([SLRef])
REFERENCES [ACC].[Account] ([AccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_SLS_ReturnedInvoice_PartyAddressRef')
ALTER TABLE [SLS].[ReturnedInvoice]  ADD  CONSTRAINT [FK_SLS_ReturnedInvoice_PartyAddressRef] FOREIGN KEY([PartyAddressRef])
REFERENCES [GNR].[PartyAddress] ([PartyAddressId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_SLS_ReturnedInvoice_QuotationRef')
ALTER TABLE [SLS].[ReturnedInvoice]  ADD  CONSTRAINT [FK_SLS_ReturnedInvoice_QuotationRef] FOREIGN KEY([QuotationRef])
REFERENCES [SLS].[Quotation] ([QuotationId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_SLS_ReturnedInvoice_SaleTypeRef')
ALTER TABLE [SLS].[ReturnedInvoice]  ADD  CONSTRAINT [FK_SLS_ReturnedInvoice_SaleTypeRef] FOREIGN KEY([SaleTypeRef])
REFERENCES [SLS].[SaleType] ([SaleTypeId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReturnedInvoice_VoucherRef')
ALTER TABLE [SLS].[ReturnedInvoice]  ADD  CONSTRAINT [FK_ReturnedInvoice_VoucherRef] FOREIGN KEY([VoucherRef])
REFERENCES [ACC].[Voucher] ([VoucherId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReturnedInvoice_FiscalYear')
ALTER TABLE [SLS].[ReturnedInvoice]  ADD  CONSTRAINT [FK_ReturnedInvoice_FiscalYear] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])
GO

IF NOT EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'FK_ReturnedInvoice_PaymentHeaderRef')
BEGIN
	ALTER TABLE [SLS].[ReturnedInvoice]  ADD  CONSTRAINT [FK_ReturnedInvoice_PaymentHeaderRef] FOREIGN KEY([PaymentHeaderRef])
	REFERENCES [RPA].[PaymentHeader] ([PaymentHeaderId])
END

Go
--<< DROP OBJECTS >>--
