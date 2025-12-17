--<<FileName:SLS_Quotation.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.Quotation') Is Null
CREATE TABLE [SLS].[Quotation](
	[QuotationId] [int] NOT NULL,
	[CustomerPartyRef] [int] NOT NULL,
	[CustomerRealName] NVARCHAR(255) NULL,
	[CustomerRealName_En] NVARCHAR(255) NULL,
	[SaleTypeRef] [int] NOT NULL,
	[PartyAddressRef] [int] NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[DeliveryLocationRef] [int] NOT NULL,
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
	[NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective) PERSISTED,
	[NetPriceInBaseCurrency] [decimal](19, 4) NOT NULL,
	[Rate] [decimal](26, 16) NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Closed] [bit] NOT NULL,
	[FiscalYearRef] [int]  NOT NULL,
	[ReceiptRef] [int] NULL,
	[PaymentRef] [int] NULL,
	[Guid] [nvarchar](36) NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.Quotation') and
				[name] = 'ColumnName')
begin
    Alter table SLS.Quotation Add ColumnName DataType Nullable
end
GO*/
if not exists (select 1 from sys.columns where object_id=object_id('SLS.Quotation') and
				[name] = 'CustomerRealName')
begin
    Alter table SLS.Quotation Add CustomerRealName NVARCHAR(255) NULL
end
go
if not exists (select 1 from sys.columns where object_id=object_id('SLS.Quotation') and
				[name] = 'CustomerRealName_En')
begin
    Alter table SLS.Quotation Add CustomerRealName_En NVARCHAR(255) NULL
end
go
if not exists (select 1 from sys.columns where object_id=object_id('SLS.Quotation') and
				[name] = 'ReceiptRef')
begin
    Alter table SLS.Quotation Add ReceiptRef int NULL
end
	
	
if not exists (select 1 from sys.columns where object_id=object_id('SLS.Quotation') and
				[name] = 'PaymentRef')
begin
    Alter table SLS.Quotation Add PaymentRef int NULL
end

if not exists (select 1 from sys.columns where object_id=object_id('SLS.Quotation') and
				[name] = 'FiscalYearRef')
begin
    Alter table SLS.Quotation Add FiscalYearRef int NULL
end

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Quotation') AND [name]='DeliveryLocationRef')
BEGIN
	ALTER TABLE SLS.Quotation ADD DeliveryLocationRef INT NULL
END

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Quotation') AND [name]='DeliveryLocationRef' AND is_nullable=1)
BEGIN
	EXEC sp_executesql N'UPDATE SLS.Quotation SET DeliveryLocationRef=1 WHERE DeliveryLocationRef IS NULL'
	ALTER TABLE SLS.Quotation ALTER COLUMN DeliveryLocationRef INT NOT NULL
END

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Quotation') and
	[name]='Guid')
BEGIN
	ALTER TABLE SLS.Quotation ADD [Guid] [nvarchar](36) NULL
END
Go

if not exists (select 1 from sys.columns where object_id=object_id('SLS.Quotation') and
				[name] = 'AdditionFactor_VatEffective')
begin
    Alter table SLS.Quotation Add [AdditionFactor_VatEffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.Quotation SET AdditionFactor_VatEffective=0')
    Alter table SLS.Quotation ALTER COLUMN [AdditionFactor_VatEffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.Quotation') and
				[name] = 'AdditionFactorInBaseCurrency_VatEffective')
begin
    Alter table SLS.Quotation Add [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.Quotation SET AdditionFactorInBaseCurrency_VatEffective=0')
    Alter table SLS.Quotation ALTER COLUMN [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.Quotation') and
				[name] = 'AdditionFactor_VatIneffective')
begin
    Alter table SLS.Quotation Add [AdditionFactor_VatIneffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.Quotation SET AdditionFactor_VatIneffective=0')
    Alter table SLS.Quotation ALTER COLUMN [AdditionFactor_VatIneffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.Quotation') and
				[name] = 'AdditionFactorInBaseCurrency_VatIneffective')
begin
    Alter table SLS.Quotation Add [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.Quotation SET AdditionFactorInBaseCurrency_VatIneffective=0')
    Alter table SLS.Quotation ALTER COLUMN [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NOT NULL
end
GO

--<< ALTER COLUMNS >>--

IF EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.Quotation') AND
				[name] = 'NetPriceInBaseCurrency' AND is_Computed = 1)
BEGIN
	IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Quotation') AND
			[name] = 'PriceInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Quotation DROP COLUMN PriceInBaseCurrency
	END

	IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Quotation') AND
			[name] = 'DiscountInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Quotation DROP COLUMN DiscountInBaseCurrency
	END

	IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Quotation') AND
			[name] = 'AdditionInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Quotation DROP COLUMN AdditionInBaseCurrency
	END
	
	IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Quotation') AND
			[name] = 'TaxInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Quotation DROP COLUMN TaxInBaseCurrency
	END


	IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Quotation') AND
			[name] = 'DutyInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Quotation DROP COLUMN DutyInBaseCurrency
	END

	IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Quotation') AND
			[name] = 'NetPriceInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Quotation DROP COLUMN NetPriceInBaseCurrency
	END
	
	

	IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Quotation') AND
			[name] = 'PriceInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Quotation ADD PriceInBaseCurrency DECIMAL(19,4)
	END

	IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Quotation') AND
			[name] = 'DiscountInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Quotation ADD DiscountInBaseCurrency DECIMAL(19,4)
	END
	
	IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Quotation') AND
			[name] = 'AdditionInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Quotation ADD AdditionInBaseCurrency DECIMAL(19,4)
	END
	
	IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Quotation') AND
			[name] = 'TaxInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Quotation ADD TaxInBaseCurrency DECIMAL(19,4)
	END
	
	IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Quotation') AND
			[name] = 'DutyInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Quotation ADD DutyInBaseCurrency DECIMAL(19,4)
	END
	
	IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.Quotation') AND
			[name] = 'NetPriceInBaseCurrency')
	BEGIN
		ALTER TABLE SLS.Quotation ADD NetPriceInBaseCurrency DECIMAL(19,4)
	END
END

if exists (select 1 from sys.columns where object_id=object_id('SLS.Quotation') and
				[name] = 'AdditionFactor_VatEffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[Quotation] SET [AdditionFactor_VatEffective] = 0 where [AdditionFactor_VatEffective] IS NULL

	begin transaction
	IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
				WHERE OBJECT_ID=OBJECT_ID('SLS.Quotation') AND [name] = 'NetPrice')
	BEGIN
		ALTER TABLE SLS.[Quotation] DROP COLUMN NetPrice
	END

	Alter table SLS.[Quotation] ALTER COLUMN [AdditionFactor_VatEffective] [decimal](19,4) NOT NULL
	ALTER TABLE SLS.[Quotation] ADD [NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective)
	commit transaction
end
GO

if exists (select 1 from sys.columns where object_id=object_id('SLS.Quotation') and
				[name] = 'AdditionFactorInBaseCurrency_VatEffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[Quotation] SET [AdditionFactorInBaseCurrency_VatEffective] = 0 where [AdditionFactorInBaseCurrency_VatEffective] IS NULL
    Alter table SLS.[Quotation] ALTER COLUMN [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NOT NULL
end
GO

if exists (select 1 from sys.columns where object_id=object_id('SLS.Quotation') and
				[name] = 'AdditionFactor_VatIneffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[Quotation] SET [AdditionFactor_VatIneffective] = 0 where [AdditionFactor_VatIneffective] IS NULL

	begin transaction
	
	IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
				WHERE OBJECT_ID=OBJECT_ID('SLS.Quotation') AND [name] = 'NetPrice')
	BEGIN
		ALTER TABLE SLS.[Quotation] DROP COLUMN NetPrice
	END

	Alter table SLS.[Quotation] ALTER COLUMN [AdditionFactor_VatIneffective] [decimal](19,4) NOT NULL
	ALTER TABLE SLS.[Quotation] ADD [NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective)

	commit transaction
end
GO

if exists (select 1 from sys.columns where object_id=object_id('SLS.Quotation') and
				[name] = 'AdditionFactorInBaseCurrency_VatIneffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[Quotation] SET [AdditionFactorInBaseCurrency_VatIneffective] = 0 where [AdditionFactorInBaseCurrency_VatIneffective] IS NULL
    Alter table SLS.[Quotation] ALTER COLUMN [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NOT NULL
end
GO

IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
		  WHERE OBJECT_ID=OBJECT_ID('SLS.Quotation') AND [name] = 'NetPrice')
BEGIN
	ALTER TABLE SLS.Quotation DROP COLUMN NetPrice
	ALTER TABLE SLS.Quotation ADD [NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective) PERSISTED
END

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Quotation')
ALTER TABLE [SLS].[Quotation] ADD  CONSTRAINT [PK_Quotation] PRIMARY KEY CLUSTERED 
(
	[QuotationId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_Quotation_ReceiptRef')
ALTER TABLE [SLS].[Quotation]  ADD  CONSTRAINT [FK_Quotation_ReceiptRef] FOREIGN KEY([ReceiptRef])
REFERENCES [RPA].[ReceiptHeader] ([ReceiptHeaderId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_Quotation_PaymentRef')
ALTER TABLE [SLS].[Quotation]  ADD  CONSTRAINT [FK_Quotation_PaymentRef] FOREIGN KEY([PaymentRef])
REFERENCES [RPA].[PaymentHeader] ([PaymentHeaderID])

GO

If not Exists (select 1 from sys.objects where name = 'FK_Quotation_CurrencyRef')
ALTER TABLE [SLS].[Quotation]  ADD  CONSTRAINT [FK_Quotation_CurrencyRef] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Quotation_CustomerPartyRef')
ALTER TABLE [SLS].[Quotation]  ADD  CONSTRAINT [FK_Quotation_CustomerPartyRef] FOREIGN KEY([CustomerPartyRef])
REFERENCES [GNR].[Party] ([PartyId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Quotation_PartyAddressRef')
ALTER TABLE [SLS].[Quotation]  ADD  CONSTRAINT [FK_Quotation_PartyAddressRef] FOREIGN KEY([PartyAddressRef])
REFERENCES [GNR].[PartyAddress] ([PartyAddressId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_Quotation_SaleTypeRef')
ALTER TABLE [SLS].[Quotation]  ADD  CONSTRAINT [FK_Quotation_SaleTypeRef] FOREIGN KEY([SaleTypeRef])
REFERENCES [SLS].[SaleType] ([SaleTypeId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_Quotation_FiscalYear')
ALTER TABLE [SLS].[Quotation]  ADD  CONSTRAINT [FK_Quotation_FiscalYear] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearId])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [NAME] = 'FK_Quotation_DeliveryLocationRef')
	ALTER TABLE [SLS].[Quotation] ADD CONSTRAINT [FK_Quotation_DeliveryLocationRef]
	FOREIGN KEY ([DeliveryLocationRef]) REFERENCES [GNR].[DeliveryLocation] ([DeliveryLocationID])

GO

--<< DROP OBJECTS >>--
--<< DROP OBJECTS >>--
