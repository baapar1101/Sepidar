If Object_ID('DST.Order') Is Null
CREATE TABLE [DST].[Order]
(
	[OrderID] [int] NOT NULL,
	[State] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[CurrencyRef] [int] NOT NULL,
	[Rate] [decimal](26, 16) NOT NULL,
	[BrokerPartyRef] [int] NULL,
	[CustomerPartyRef] [int] NOT NULL,
	[CustomerPartyAddressRef] [int] NOT NULL,
	[SaleTypeRef] [int] NOT NULL,
	[FiscalYearRef] [int] NOT NULL,
	[DeliveryDate] [datetime] NULL,

	[Price] [decimal](19, 4) NULL,
	[PriceInBaseCurrency] [decimal](19, 4) NULL,
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
	[NetPriceInBaseCurrency] [decimal](19, 4) NULL,
	[AgreementRef] [int] NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Guid] [nvarchar](36) NULL,



) 
ON [PRIMARY]

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

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('DST.Order') and
	[name]='Guid')
BEGIN
	ALTER TABLE DST.[Order] ADD [Guid] [nvarchar](36) NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('DST.Order') and
	[name]='Description')
BEGIN
	ALTER TABLE DST.[Order] ADD [Description] [nvarchar](255) NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('DST.Order') AND
	[name] = 'SignatureRef' )
BEGIN
	ALTER TABLE DST.[Order] ADD [SignatureRef] [int] NULL
END
GO




IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('DST.Order') AND
			[name] = 'AgreementRef')
BEGIN
		ALTER TABLE DST.[Order] ADD [AgreementRef] [int] NULL DEFAULT(NULL)
END
GO

if not exists (select 1 from sys.columns where object_id=object_id('DST.Order') and
				[name] = 'AdditionFactor_VatEffective')
begin
    Alter table DST.[Order] Add [AdditionFactor_VatEffective] [decimal](19,4) NULL
	EXEC('UPDATE DST.[Order] SET AdditionFactor_VatEffective=0')
	Alter table DST.[Order] ALTER COLUMN [AdditionFactor_VatEffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('DST.Order') and
				[name] = 'AdditionFactorInBaseCurrency_VatEffective')
begin
    Alter table DST.[Order] Add [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NULL
	EXEC('UPDATE DST.[Order] SET AdditionFactorInBaseCurrency_VatEffective=0')
    Alter table DST.[Order] ALTER COLUMN [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('DST.Order') and
				[name] = 'AdditionFactor_VatIneffective')
begin
    Alter table DST.[Order] Add [AdditionFactor_VatIneffective] [decimal](19,4) NULL
	EXEC('UPDATE DST.[Order] SET AdditionFactor_VatIneffective=0')
    Alter table DST.[Order] ALTER COLUMN [AdditionFactor_VatIneffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('DST.Order') and
				[name] = 'AdditionFactorInBaseCurrency_VatIneffective')
begin
    Alter table DST.[Order] Add [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NULL
	EXEC('UPDATE DST.[Order] SET AdditionFactorInBaseCurrency_VatIneffective=0')
    Alter table DST.[Order] ALTER COLUMN [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NOT NULL
end
GO

--<< ALTER COLUMNS >>--
if exists (select 1 from sys.columns where object_id=object_id('DST.Order') and
				[name] = 'AdditionFactor_VatEffective' and [is_nullable] = 1)
begin
	UPDATE DST.[Order] SET [AdditionFactor_VatEffective] = 0 where [AdditionFactor_VatEffective] IS NULL

	begin transaction
	IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
				WHERE OBJECT_ID=OBJECT_ID('DST.Order') AND [name] = 'NetPrice')
	BEGIN
		ALTER TABLE DST.[Order] DROP COLUMN NetPrice
	END

	Alter table DST.[Order] ALTER COLUMN [AdditionFactor_VatEffective] [decimal](19,4) NOT NULL
	ALTER TABLE DST.[Order] ADD [NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective)
	commit transaction
end
GO

if exists (select 1 from sys.columns where object_id=object_id('DST.Order') and
				[name] = 'AdditionFactorInBaseCurrency_VatEffective' and [is_nullable] = 1)
begin
	UPDATE DST.[Order] SET [AdditionFactorInBaseCurrency_VatEffective] = 0 where [AdditionFactorInBaseCurrency_VatEffective] IS NULL
    Alter table DST.[Order] ALTER COLUMN [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NOT NULL
end
GO

if exists (select 1 from sys.columns where object_id=object_id('DST.Order') and
				[name] = 'AdditionFactor_VatIneffective' and [is_nullable] = 1)
begin
	UPDATE DST.[Order] SET [AdditionFactor_VatIneffective] = 0 where [AdditionFactor_VatIneffective] IS NULL

	begin transaction
	
	IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
				WHERE OBJECT_ID=OBJECT_ID('DST.Order') AND [name] = 'NetPrice')
	BEGIN
		ALTER TABLE DST.[Order] DROP COLUMN NetPrice
	END

	Alter table DST.[Order] ALTER COLUMN [AdditionFactor_VatIneffective] [decimal](19,4) NOT NULL
	ALTER TABLE DST.[Order] ADD [NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective)

	commit transaction
end
GO

if exists (select 1 from sys.columns where object_id=object_id('DST.Order') and
				[name] = 'AdditionFactorInBaseCurrency_VatIneffective' and [is_nullable] = 1)
begin
	UPDATE DST.[Order] SET [AdditionFactorInBaseCurrency_VatIneffective] = 0 where [AdditionFactorInBaseCurrency_VatIneffective] IS NULL
    Alter table DST.[Order] ALTER COLUMN [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NOT NULL
end
GO

IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
		  WHERE OBJECT_ID=OBJECT_ID('DST.Order') AND [name] = 'NetPrice')
BEGIN
	ALTER TABLE DST.[Order] DROP COLUMN NetPrice
	ALTER TABLE DST.[Order] ADD [NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective)
END
--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_DST_Order')
ALTER TABLE [DST].[Order] ADD  CONSTRAINT [PK_DST_Order] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
) 
ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_Order_Guid')
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Order_Guid] ON [DST].[Order]
(
	[Guid] ASC
) WHERE [Guid] IS NOT NULL ON [PRIMARY]
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'UIX_Order_Date')
CREATE NONCLUSTERED INDEX [UIX_Order_Date] ON [DST].[Order]
(
	[Date] ASC
) ON [PRIMARY]
GO

--<< FOREIGNKEYS DEFINITION >>--

If NOT Exists (select 1 from sys.objects where name = 'FK_Order_CurrencyRef')
ALTER TABLE [DST].[Order] ADD CONSTRAINT [FK_Order_CurrencyRef] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

If NOT Exists (select 1 from sys.objects where name = 'FK_Order_BrokerPartyRef')
ALTER TABLE [DST].[Order] ADD CONSTRAINT [FK_Order_BrokerPartyRef] FOREIGN KEY([BrokerPartyRef])
REFERENCES [GNR].[Party] ([PartyID])

If NOT Exists (select 1 from sys.objects where name = 'FK_Order_CustomerPartyRef')
ALTER TABLE [DST].[Order] ADD CONSTRAINT [FK_Order_CustomerPartyRef] FOREIGN KEY([CustomerPartyRef])
REFERENCES [GNR].[Party] ([PartyID])

If NOT Exists (select 1 from sys.objects where name = 'FK_Order_CustomerPartyAddressRef')
ALTER TABLE [DST].[Order] ADD CONSTRAINT [FK_Order_CustomerPartyAddressRef] FOREIGN KEY([CustomerPartyAddressRef])
REFERENCES [GNR].[PartyAddress] ([PartyAddressID])

If NOT Exists (select 1 from sys.objects where name = 'FK_Order_SaleTypeRef')
ALTER TABLE [DST].[Order] ADD CONSTRAINT [FK_Order_SaleTypeRef] FOREIGN KEY([SaleTypeRef])
REFERENCES [SLS].[SaleType] ([SaleTypeID])

If NOT Exists (select 1 from sys.objects where name = 'FK_Order_FiscalYearRef')
ALTER TABLE [DST].[Order] ADD CONSTRAINT [FK_Order_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
REFERENCES [FMK].[FiscalYear] ([FiscalYearID])

GO

--<< DROP OBJECTS >>--
