--<<FileName:SLS_Invoice.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.Invoice') Is Null
CREATE TABLE [SLS].[Invoice](
	[InvoiceId] [int] NOT NULL,
	[QuotationRef] [int] NULL,
	[OrderRef] [int] NULL,
	[CustomerPartyRef] [int] NOT NULL,
	[CustomerRealName] NVARCHAR(255) NULL,
	[CustomerRealName_En] NVARCHAR(255) NULL,
	[SaleTypeRef] [int] NOT NULL,
	[PartyAddressRef] [int] NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[SLRef] [int] NOT NULL,
	[DeliveryLocationRef] [int] NOT NULL,
	[State] [int] NOT NULL,
	[Price] [decimal](19, 4) NOT NULL,
	[PriceInBaseCurrency] [decimal](19, 4) NOT NULL,
	[Discount] [decimal](19, 4) NULL,
	[DiscountInBaseCurrency] [decimal](19, 4) NULL,
	[Addition] [decimal](19, 4) NULL,
	[AdditionInBaseCurrency] [decimal](19, 4) NULL,
	[Tax] [decimal](19, 4) NULL,
	[TaxInBaseCurrency] [decimal](19, 4) NULL,
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
	[AgreementRef] [int] NULL,
	[ShouldControlCustomerCredit] [bit] NOT NULL,
	[Guid] [nvarchar](36) NULL,
	[TaxPayerBillIssueDateTime] [DateTime] NULL,
	[SettlementType] [int] NOT NULL,
	[Description] [nvarchar](4000) NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.Invoice') and
				[name] = 'ColumnName')
begin
    Alter table SLS.Invoice Add ColumnName DataType Nullable
end
GO*/

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Invoice') AND
	[name] = 'Description' )
BEGIN
	ALTER TABLE SLS.Invoice ADD [Description] [nvarchar](4000) NULL
END
GO


IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Invoice') AND
	[name] = 'SignatureRef' )
BEGIN
	ALTER TABLE SLS.Invoice ADD [SignatureRef] [int] NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Invoice') and
	[name]='Guid')
BEGIN
	ALTER TABLE SLS.Invoice ADD [Guid] [nvarchar](36) NULL
END
Go

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Invoice') and
	[name]='TaxPayerBillIssueDateTime')
BEGIN
	ALTER TABLE SLS.Invoice ADD [TaxPayerBillIssueDateTime] [DateTime] NULL
END
GO

if not exists (select 1 from sys.columns where object_id=object_id('SLS.Invoice') and
				[name] = 'FiscalYearRef')
begin
    Alter table SLS.Invoice Add FiscalYearRef int NULL
end

if not exists (select 1 from sys.columns where object_id=object_id('SLS.Invoice') and
				[name] = 'VoucherRef')
begin
    Alter table SLS.Invoice Add VoucherRef int NULL
end

if not exists (select 1 from sys.columns where object_id=object_id('SLS.Invoice') and
				[name] = 'BaseOnInventoryDelivery')
begin
    Alter table SLS.Invoice Add BaseOnInventoryDelivery Bit
end

if not exists (select 1 from sys.columns where object_id=object_id('SLS.Invoice') and
				[name] = 'CustomerRealName')
begin
    Alter table SLS.Invoice Add CustomerRealName NVarChar(255)
end

if not exists (select 1 from sys.columns where object_id=object_id('SLS.Invoice') and
				[name] = 'CustomerRealName_En')
begin
    Alter table SLS.Invoice Add CustomerRealName_En NVarChar(255)
end

if not exists (select 1 from sys.columns where object_id=object_id('SLS.Invoice') and
				[name] = 'OrderRef')
begin
    Alter table SLS.Invoice Add OrderRef INT NULL
end

if not exists (select 1 from sys.columns where object_id=object_id('SLS.Invoice') and
				[name] = 'ShouldControlCustomerCredit')
begin
    Alter table SLS.Invoice Add [ShouldControlCustomerCredit] BIT NULL
end

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = object_id('SLS.Invoice') AND
				[name] = 'AgreementRef')
BEGIN
    ALTER TABLE SLS.Invoice ADD [AgreementRef] [int] NULL
END

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Invoice') AND [name]='ShouldControlCustomerCredit' AND is_nullable=1)
BEGIN
	EXEC sp_executesql N'UPDATE SLS.Invoice SET ShouldControlCustomerCredit=1 WHERE ShouldControlCustomerCredit IS NULL'
	ALTER TABLE SLS.Invoice ALTER COLUMN ShouldControlCustomerCredit BIT NOT NULL
END

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Invoice') AND [name]='DeliveryLocationRef')
BEGIN
	ALTER TABLE SLS.Invoice ADD DeliveryLocationRef INT NULL
END

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Invoice') AND [name]='DeliveryLocationRef' AND is_nullable=1)
BEGIN
	EXEC sp_executesql N'UPDATE SLS.Invoice SET DeliveryLocationRef=1 WHERE DeliveryLocationRef IS NULL'
	ALTER TABLE SLS.Invoice ALTER COLUMN DeliveryLocationRef INT NOT NULL
END

if not exists (select 1 from sys.columns where object_id=object_id('SLS.Invoice') and
				[name] = 'AdditionFactor_VatEffective')
begin
    Alter table SLS.Invoice Add [AdditionFactor_VatEffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.[Invoice] SET AdditionFactor_VatEffective=0')
    Alter table SLS.Invoice ALTER COLUMN [AdditionFactor_VatEffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.Invoice') and
				[name] = 'AdditionFactorInBaseCurrency_VatEffective')
begin
    Alter table SLS.Invoice Add [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.[Invoice] SET AdditionFactorInBaseCurrency_VatEffective=0')
    Alter table SLS.Invoice ALTER COLUMN [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.Invoice') and
				[name] = 'AdditionFactor_VatIneffective')
begin
    Alter table SLS.Invoice Add [AdditionFactor_VatIneffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.[Invoice] SET AdditionFactor_VatIneffective=0')
    Alter table SLS.Invoice ALTER COLUMN [AdditionFactor_VatIneffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.Invoice') and
				[name] = 'AdditionFactorInBaseCurrency_VatIneffective')
begin
    Alter table SLS.Invoice Add [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.[Invoice] SET AdditionFactorInBaseCurrency_VatIneffective=0')
    Alter table SLS.Invoice ALTER COLUMN [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NOT NULL
end
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('SLS.Invoice') AND
				[name] = 'SettlementType')
BEGIN
    ALTER TABLE SLS.Invoice ADD [SettlementType] [int] NULL
	EXEC('UPDATE SLS.[Invoice] SET SettlementType = 0')
    ALTER TABLE SLS.Invoice ALTER COLUMN [SettlementType] [int] NOT NULL
END
GO

--<< ALTER COLUMNS >>--
IF EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.Invoice') AND
				[name] = 'NetPriceInBaseCurrency' AND is_Computed = 1)
BEGIN
	IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Invoice') AND
			[name] = 'PriceInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Invoice DROP COLUMN PriceInBaseCurrency
	END

	IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Invoice') AND
			[name] = 'DiscountInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Invoice DROP COLUMN DiscountInBaseCurrency
	END

	IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Invoice') AND
			[name] = 'AdditionInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Invoice DROP COLUMN AdditionInBaseCurrency
	END
	
	IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Invoice') AND
			[name] = 'TaxInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Invoice DROP COLUMN TaxInBaseCurrency
	END


	IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Invoice') AND
			[name] = 'DutyInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Invoice DROP COLUMN DutyInBaseCurrency
	END

	IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Invoice') AND
			[name] = 'NetPriceInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Invoice DROP COLUMN NetPriceInBaseCurrency
	END

	IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Invoice') AND
			[name] = 'PriceInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Invoice ADD PriceInBaseCurrency DECIMAL(19,4)
	END

	IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Invoice') AND
			[name] = 'DiscountInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Invoice ADD DiscountInBaseCurrency DECIMAL(19,4)
	END
	
	IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Invoice') AND
			[name] = 'AdditionInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Invoice ADD AdditionInBaseCurrency DECIMAL(19,4)
	END
	
	IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Invoice') AND
			[name] = 'TaxInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Invoice ADD TaxInBaseCurrency DECIMAL(19,4)
	END
	
	IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Invoice') AND
			[name] = 'DutyInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Invoice ADD DutyInBaseCurrency DECIMAL(19,4)
	END
	
	IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Invoice') AND
			[name] = 'NetPriceInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Invoice ADD NetPriceInBaseCurrency DECIMAL(19,4)
	END
	
END

if exists (select 1 from sys.columns where object_id=object_id('SLS.Invoice') and
				[name] = 'AdditionFactor_VatEffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[Invoice] SET [AdditionFactor_VatEffective] = 0 where [AdditionFactor_VatEffective] IS NULL

	begin transaction
	IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
				WHERE OBJECT_ID=OBJECT_ID('SLS.Invoice') AND [name] = 'NetPrice')
	BEGIN
		IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Invoice_DeliveryLocationRef')
			DROP INDEX SLS.Invoice.IX_Invoice_DeliveryLocationRef
		ALTER TABLE SLS.[Invoice] DROP COLUMN NetPrice
	END

	Alter table SLS.[Invoice] ALTER COLUMN [AdditionFactor_VatEffective] [decimal](19,4) NOT NULL
	ALTER TABLE SLS.[Invoice] ADD [NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective)
	commit transaction
end
GO

if exists (select 1 from sys.columns where object_id=object_id('SLS.Invoice') and
				[name] = 'AdditionFactorInBaseCurrency_VatEffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[Invoice] SET [AdditionFactorInBaseCurrency_VatEffective] = 0 where [AdditionFactorInBaseCurrency_VatEffective] IS NULL
    Alter table SLS.[Invoice] ALTER COLUMN [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NOT NULL
end
GO

if exists (select 1 from sys.columns where object_id=object_id('SLS.Invoice') and
				[name] = 'AdditionFactor_VatIneffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[Invoice] SET [AdditionFactor_VatIneffective] = 0 where [AdditionFactor_VatIneffective] IS NULL

	begin transaction
	
	IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
				WHERE OBJECT_ID=OBJECT_ID('SLS.Invoice') AND [name] = 'NetPrice')
	BEGIN
		IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Invoice_DeliveryLocationRef')
			DROP INDEX SLS.Invoice.IX_Invoice_DeliveryLocationRef
		ALTER TABLE SLS.[Invoice] DROP COLUMN NetPrice
	END

	Alter table SLS.[Invoice] ALTER COLUMN [AdditionFactor_VatIneffective] [decimal](19,4) NOT NULL
	ALTER TABLE SLS.[Invoice] ADD [NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective)

	commit transaction
end
GO

if exists (select 1 from sys.columns where object_id=object_id('SLS.Invoice') and
				[name] = 'AdditionFactorInBaseCurrency_VatIneffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[Invoice] SET [AdditionFactorInBaseCurrency_VatIneffective] = 0 where [AdditionFactorInBaseCurrency_VatIneffective] IS NULL
    Alter table SLS.[Invoice] ALTER COLUMN [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NOT NULL
end
GO

IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
		  WHERE OBJECT_ID=OBJECT_ID('SLS.Invoice') AND [name] = 'NetPrice')
BEGIN
	IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Invoice_DeliveryLocationRef')
		DROP INDEX SLS.Invoice.IX_Invoice_DeliveryLocationRef

	ALTER TABLE SLS.Invoice DROP COLUMN NetPrice
	ALTER TABLE SLS.Invoice ADD [NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective)
END

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Invoice')
ALTER TABLE [SLS].[Invoice] ADD  CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED 
(
	[InvoiceId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_Invoice_Guid')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Invoice_Guid] ON [SLS].[Invoice]
(
	[Guid] ASC
) WHERE [Guid] IS NOT NULL ON [PRIMARY]
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Invoice_AccountingVoucherRef')
	CREATE NONCLUSTERED INDEX IX_Invoice_AccountingVoucherRef
ON [SLS].[Invoice] ([VoucherRef])
go 

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Invoice_DeliveryLocationRef')
	CREATE NONCLUSTERED INDEX [IX_Invoice_DeliveryLocationRef]
		ON [SLS].[Invoice] ([DeliveryLocationRef])
		INCLUDE ([InvoiceId], [CustomerPartyRef], [SaleTypeRef], [PartyAddressRef], [Number], [Date], [SLRef], [NetPrice], [OrderRef])
GO


--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_SLS_Invoice_CurrencyRef')
ALTER TABLE [SLS].[Invoice]  ADD  CONSTRAINT [FK_SLS_Invoice_CurrencyRef] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_SLS_Invoice_CustomerPartyRef')
ALTER TABLE [SLS].[Invoice]  ADD  CONSTRAINT [FK_SLS_Invoice_CustomerPartyRef] FOREIGN KEY([CustomerPartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_SLS_Invoice_PartyAddressRef')
ALTER TABLE [SLS].[Invoice]  ADD  CONSTRAINT [FK_SLS_Invoice_PartyAddressRef] FOREIGN KEY([PartyAddressRef])
REFERENCES [GNR].[PartyAddress] ([PartyAddressId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_SLS_Invoice_QuotationRef')
ALTER TABLE [SLS].[Invoice]  ADD  CONSTRAINT [FK_SLS_Invoice_QuotationRef] FOREIGN KEY([QuotationRef])
REFERENCES [SLS].[Quotation] ([QuotationId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_SLS_Invoice_OrderRef')
ALTER TABLE [SLS].[Invoice]  ADD  CONSTRAINT [FK_SLS_Invoice_OrderRef] FOREIGN KEY([OrderRef])
REFERENCES [DST].[Order] ([OrderId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_SLS_Invoice_SaleTypeRef')
ALTER TABLE [SLS].[Invoice]  ADD  CONSTRAINT [FK_SLS_Invoice_SaleTypeRef] FOREIGN KEY([SaleTypeRef])
REFERENCES [SLS].[SaleType] ([SaleTypeId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_SLS_Invoice_SLRef')
ALTER TABLE [SLS].[Invoice]  ADD  CONSTRAINT [FK_SLS_Invoice_SLRef] FOREIGN KEY([SLRef])
REFERENCES [ACC].[Account] ([AccountId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_Invoice_VoucherRef')
ALTER TABLE [SLS].[Invoice]  ADD  CONSTRAINT [FK_Invoice_VoucherRef] FOREIGN KEY([VoucherRef])
REFERENCES [ACC].[Voucher] ([VoucherId])
Go

If not Exists (select 1 from sys.objects where name = 'FK_Invoice_FiscalYear')
ALTER TABLE [SLS].[Invoice]  ADD  CONSTRAINT [FK_Invoice_FiscalYear] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [NAME] = 'FK_Invoice_DeliveryLocationRef')
	ALTER TABLE [SLS].[Invoice] ADD CONSTRAINT [FK_Invoice_DeliveryLocationRef]
	FOREIGN KEY ([DeliveryLocationRef]) REFERENCES [GNR].[DeliveryLocation] ([DeliveryLocationID])

GO

--<< DROP OBJECTS >>--
