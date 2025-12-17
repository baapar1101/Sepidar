--<<FileName:SLS_InvoiceItem.sql>>--
--<< TABLE DEFINITION >>--

IF Object_ID('SLS.InvoiceItem') Is Null
CREATE TABLE [SLS].[InvoiceItem](
	[InvoiceItemID] [int] NOT NULL,
	[InvoiceRef] [int] NOT NULL,
	[RowID] [int] NOT NULL,
	[ItemRef] [int] NOT NULL,
	[TracingRef] [int] NULL,
	[StockRef] [int] NULL,
	[Quantity] [decimal](19, 4) NOT NULL,
	[SecondaryQuantity] [decimal](19, 4) NULL,
	[Fee] [decimal](19, 4) NOT NULL,
	[Price] [decimal](19, 4) NOT NULL,
	[PriceInBaseCurrency]  [decimal](19, 4) NOT NULL,
	[Discount] [decimal](19, 4) NOT NULL,
	[DiscountInBaseCurrency]  [decimal](19, 4) NOT NULL,
	[DiscountItemGroupRef] [int] Null,
	[PriceInfoDiscountRate] [decimal](5, 2) NOT NULL,
	[PriceInfoPriceDiscount] [decimal](19, 4) NOT NULL DEFAULT 0, 
	[PriceInfoPercentDiscount] [decimal](19,4) NOT NULL DEFAULT 0, 
	[CustomerDiscount][decimal](19,4) NOT NULL,
	[CustomerDiscountRate] [decimal](5, 2) NOT NULL,
	[AggregateAmountDiscountRate] [decimal](5, 2)  NOT NULL DEFAULT 0, 
	[AggregateAmountPriceDiscount] [decimal](19, 4) NOT NULL DEFAULT 0, 
	[AggregateAmountPercentDiscount] [decimal](19,4) NOT NULL DEFAULT 0, 
	[Addition] [decimal](19, 4) NULL,
	[AdditionInBaseCurrency]  [decimal](19, 4) NULL,
	[Tax] [decimal](19, 4) NULL,
	[TaxInBaseCurrency]  [decimal](19, 4) NULL,
	[Duty] [decimal](19, 4) NULL,
	[DutyInBaseCurrency]  [decimal](19, 4) NULL,
	[AdditionFactor_VatEffective] [decimal](19, 4) NOT NULL,
	[AdditionFactorInBaseCurrency_VatEffective] [decimal](19, 4) NOT NULL,
	[AdditionFactor_VatIneffective] [decimal](19, 4) NOT NULL,
	[AdditionFactorInBaseCurrency_VatIneffective] [decimal](19, 4) NOT NULL,
	[NetPrice]  AS (((((([Quantity]*[Fee]+[Tax])+[Duty])+(ISNULL([Addition],0)))-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective) PERSISTED,
	[NetPriceInBaseCurrency] [decimal](19, 4) NOT NULL,
	[Rate] [decimal](26, 16) NULL,
	[QuotationItemRef] [int] NULL,
	[OrderItemRef] [int] NULL,
	[Description] NVARCHAR(255) NULL,
	[Description_En] NVARCHAR(255) NULL,
	[DiscountInvoiceItemRef] INT NULL,
	[ProductPackRef] int null,
	[ProductPackQuantity] [decimal](19, 4)  NULL,
	[BankFeeForCurrencySale] [decimal](19, 4) NULL,
	[BankFeeForCurrencySaleInBaseCurrency] [decimal](19, 4) NULL,
	[IsAggregateDiscountInvoiceItem] [bit] NOT NULL DEFAULT (0),
	[TaxPayerCurrencyPurchaseRate] [decimal](26, 8) NOT NULL DEFAULT (0),
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.InvoiceItem') AND
	[name]='TaxPayerCurrencyPurchaseRate')
BEGIN
	ALTER TABLE SLS.InvoiceItem ADD [TaxPayerCurrencyPurchaseRate] DECIMAL(26,8) NOT NULL DEFAULT (0)
END

GO
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.InvoiceItem') AND
	[name]='IsAggregateDiscountInvoiceItem')
BEGIN
	ALTER TABLE SLS.InvoiceItem ADD [IsAggregateDiscountInvoiceItem] bit NOT NULL DEFAULT (0)
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.InvoiceItem') and
	[name]='BankFeeForCurrencySale')
BEGIN
	ALTER TABLE SLS.InvoiceItem ADD [BankFeeForCurrencySale] DECIMAL(19,4) NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.InvoiceItem') and
	[name]='BankFeeForCurrencySaleInBaseCurrency')
BEGIN
	ALTER TABLE SLS.InvoiceItem ADD [BankFeeForCurrencySaleInBaseCurrency] DECIMAL(19,4) NULL
END
GO

if not exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItem') and
				[name] = 'Description')
begin
    Alter table SLS.InvoiceItem Add Description NVARCHAR(255) NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItem') and
				[name] = 'Description_En')
begin
    Alter table SLS.InvoiceItem Add Description_En NVARCHAR(255) NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItem') and
				[name] = 'DiscountInvoiceItemRef')
begin
    Alter table SLS.InvoiceItem Add DiscountInvoiceItemRef INT NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItem') and
				[name] = 'PriceInfoPriceDiscount')
begin
    Alter table SLS.InvoiceItem Add [PriceInfoPriceDiscount] [decimal](19, 4) NOT NULL DEFAULT 0
end

if not exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItem') and
				[name] = 'PriceInfoPercentDiscount')
begin
    Alter table SLS.InvoiceItem Add [PriceInfoPercentDiscount] [decimal](19, 4) NOT NULL DEFAULT 0
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItem') and
				[name] = 'CustomerDiscount')
begin
    Alter table SLS.InvoiceItem Add [CustomerDiscount] [decimal](19, 4) NULL 
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItem') and
				[name] = 'ProductPackRef')
begin
    Alter table SLS.InvoiceItem Add [ProductPackRef]  int NULL 
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItem') and
				[name] = 'ProductPackQuantity')
begin
    Alter table SLS.InvoiceItem Add [ProductPackQuantity] [decimal](19, 4) NULL 
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItem') and
				[name] = 'AggregateAmountDiscountRate')
begin
    Alter table SLS.InvoiceItem Add [AggregateAmountDiscountRate] [decimal](5, 2)  NOT NULL DEFAULT 0 
	
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItem') and
				[name] = 'AggregateAmountPriceDiscount')
begin
    Alter table SLS.InvoiceItem Add [AggregateAmountPriceDiscount] [decimal](19, 4) NOT NULL DEFAULT 0	
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItem') and
				[name] = 'AggregateAmountPercentDiscount')
begin
    Alter table SLS.InvoiceItem Add [AggregateAmountPercentDiscount] [decimal](19,4) NOT NULL DEFAULT 0
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItem') and
				[name] = 'AdditionFactor_VatEffective')
begin
    Alter table SLS.InvoiceItem Add [AdditionFactor_VatEffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.[InvoiceItem] SET AdditionFactor_VatEffective=0')
	Alter table SLS.InvoiceItem ALTER COLUMN [AdditionFactor_VatEffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItem') and
				[name] = 'AdditionFactorInBaseCurrency_VatEffective')
begin
    Alter table SLS.InvoiceItem Add [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.[InvoiceItem] SET AdditionFactorInBaseCurrency_VatEffective=0')
	Alter table SLS.InvoiceItem ALTER COLUMN [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItem') and
				[name] = 'AdditionFactor_VatIneffective')
begin
    Alter table SLS.InvoiceItem Add [AdditionFactor_VatIneffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.[InvoiceItem] SET AdditionFactor_VatIneffective=0')
	Alter table SLS.InvoiceItem ALTER COLUMN [AdditionFactor_VatIneffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItem') and
				[name] = 'AdditionFactorInBaseCurrency_VatIneffective')
begin
    Alter table SLS.InvoiceItem Add [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.[InvoiceItem] SET AdditionFactorInBaseCurrency_VatIneffective=0')
	Alter table SLS.InvoiceItem ALTER COLUMN [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NOT NULL
end
GO



--<< ALTER COLUMNS >>--

IF EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.InvoiceItem') AND
				[name] = 'NetPriceInBaseCurrency' AND is_Computed = 1)
BEGIN
	IF EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.InvoiceItem') AND
				[name] = 'PriceInBaseCurrency' )
	ALTER TABLE SLS.InvoiceItem DROP COLUMN PriceInBaseCurrency

	IF EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.InvoiceItem') AND
				[name] = 'DiscountInBaseCurrency' )
	ALTER TABLE SLS.InvoiceItem DROP COLUMN DiscountInBaseCurrency

	IF EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.InvoiceItem') AND
				[name] = 'AdditionInBaseCurrency' )
	ALTER TABLE SLS.InvoiceItem DROP COLUMN AdditionInBaseCurrency

	IF EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.InvoiceItem') AND
				[name] = 'TaxInBaseCurrency' )
	ALTER TABLE SLS.InvoiceItem DROP COLUMN TaxInBaseCurrency

	IF EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.InvoiceItem') AND
				[name] = 'DutyInBaseCurrency' )
	ALTER TABLE SLS.InvoiceItem DROP COLUMN DutyInBaseCurrency

	IF EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.InvoiceItem') AND
				[name] = 'NetPriceInBaseCurrency' )
	ALTER TABLE SLS.InvoiceItem DROP COLUMN NetPriceInBaseCurrency


	IF NOT EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.InvoiceItem') AND
				[name] = 'PriceInBaseCurrency' )
	ALTER TABLE SLS.InvoiceItem ADD PriceInBaseCurrency DECIMAL(19,4)

	IF NOT EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.InvoiceItem') AND
				[name] = 'DiscountInBaseCurrency' )
	ALTER TABLE SLS.InvoiceItem ADD DiscountInBaseCurrency DECIMAL(19,4)

	IF NOT EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.InvoiceItem') AND
				[name] = 'AdditionInBaseCurrency' )
	ALTER TABLE SLS.InvoiceItem ADD AdditionInBaseCurrency DECIMAL(19,4)
	
	IF NOT EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.InvoiceItem') AND
				[name] = 'TaxInBaseCurrency' )
	ALTER TABLE SLS.InvoiceItem ADD TaxInBaseCurrency DECIMAL(19,4)

	IF NOT EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.InvoiceItem') AND
				[name] = 'DutyInBaseCurrency' )
	ALTER TABLE SLS.InvoiceItem ADD DutyInBaseCurrency DECIMAL(19,4)

	IF NOT EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.InvoiceItem') AND
				[name] = 'NetPriceInBaseCurrency' )	
	ALTER TABLE SLS.InvoiceItem ADD NetPriceInBaseCurrency DECIMAL(19,4)
END

IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.InvoiceItem') AND
				[name] = 'Quantity' AND scale=3)
BEGIN

	if exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItem') and
				[name] = 'NetPrice')
		ALTER TABLE SLS.InvoiceItem DROP COLUMN [NetPrice]
		
	ALTER TABLE SLS.InvoiceItem ALTER COLUMN [Quantity] [decimal](19, 4) NOT NULL
	ALTER TABLE SLS.InvoiceItem ADD
		[NetPrice]  AS (((([Quantity]*[Fee]+[Tax])+[Duty])+(ISNULL([Addition],0)))-[Discount]) PERSISTED
END

IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.InvoiceItem') AND
				[name] = 'SecondaryQuantity' AND scale=3)
	ALTER TABLE SLS.InvoiceItem ALTER COLUMN [SecondaryQuantity] [decimal](19, 4) NULL


IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.InvoiceItem') AND
				[name] = 'Discount' AND is_nullable = 1)
BEGIN 
	if exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItem') and
				[name] = 'NetPrice')
		ALTER TABLE SLS.InvoiceItem DROP COLUMN [NetPrice]

	IF NOT EXISTS (
					select *
					from sys.all_columns c 
						join sys.tables t on t.object_id = c.object_id
						join sys.schemas s on s.schema_id = t.schema_id
						join sys.default_constraints d on c.default_object_id = d.object_id
					where t.name = 'InvoiceItem' and 
						  c.name = 'Discount' and 
						  s.name = 'SLS' and
						  d.name = 'Discount_Default')
	ALTER TABLE SLS.InvoiceItem ADD CONSTRAINT Discount_Default DEFAULT 0 for Discount

	ALTER TABLE SLS.InvoiceItem ALTER COLUMN [Discount] [decimal](19, 4) NOT NULL
END	

if not exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItem') and
				[name] = 'NetPrice')
BEGIN
	ALTER TABLE SLS.InvoiceItem ADD
		[NetPrice]  AS (((([Quantity]*[Fee]+[Tax])+[Duty])+(ISNULL([Addition],0)))-[Discount]) PERSISTED
END

IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.InvoiceItem') AND
				[name] = 'DiscountInBaseCurrency' AND is_nullable = 1)
BEGIN
	UPDATE SLS.InvoiceItem
	SET DiscountInBaseCurrency = 0
	WHERE DiscountInBaseCurrency IS NULL

	ALTER TABLE SLS.InvoiceItem ALTER COLUMN [DiscountInBaseCurrency]  [decimal](19, 4) NOT NULL
END

IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.InvoiceItem') AND
				[name] = 'PriceInfoDiscountRate' AND is_nullable = 1)
BEGIN
	UPDATE SLS.InvoiceItem
	SET PriceInfoDiscountRate = 0
	WHERE PriceInfoDiscountRate IS NULL

	ALTER TABLE SLS.InvoiceItem ALTER COLUMN [PriceInfoDiscountRate] [decimal](5, 2) NOT NULL
END

IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.InvoiceItem') AND
				[name] = 'PriceInfoPriceDiscount' AND is_nullable = 1)
BEGIN
	UPDATE SLS.InvoiceItem
	SET PriceInfoPriceDiscount = 0
	WHERE PriceInfoPriceDiscount IS NULL

	ALTER TABLE SLS.InvoiceItem ALTER COLUMN [PriceInfoPriceDiscount] [decimal](19, 4) NOT NULL
END

IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.InvoiceItem') AND
				[name] = 'PriceInfoPercentDiscount' AND is_nullable = 1)
BEGIN
	UPDATE SLS.InvoiceItem
	SET PriceInfoPercentDiscount = 0
	WHERE PriceInfoPercentDiscount IS NULL

	ALTER TABLE SLS.InvoiceItem ALTER COLUMN [PriceInfoPercentDiscount] [decimal](19,4) NOT NULL 
END

IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.InvoiceItem') AND
				[name] = 'CustomerDiscountRate' AND is_nullable = 1)
BEGIN
	UPDATE SLS.InvoiceItem
	SET CustomerDiscountRate = 0
	WHERE CustomerDiscountRate IS NULL

	ALTER TABLE SLS.InvoiceItem ALTER COLUMN [CustomerDiscountRate] [decimal](5,2) NOT NULL 
END

IF NOT EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.InvoiceItem') AND
			[name] = 'OrderItemRef' )	
ALTER TABLE SLS.InvoiceItem ADD OrderItemRef int NULL

if not exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItem') and
				[name] = 'DiscountItemGroupRef')
begin
    Alter table SLS.InvoiceItem Add [DiscountItemGroupRef] [int] NULL 
end
GO

if exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItem') and
				[name] = 'AdditionFactor_VatEffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[InvoiceItem] SET [AdditionFactor_VatEffective] = 0 where [AdditionFactor_VatEffective] IS NULL

	begin transaction
	IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
				WHERE OBJECT_ID=OBJECT_ID('SLS.InvoiceItem') AND [name] = 'NetPrice')
	BEGIN
		ALTER TABLE SLS.[InvoiceItem] DROP COLUMN NetPrice
	END

	Alter table SLS.[InvoiceItem] ALTER COLUMN [AdditionFactor_VatEffective] [decimal](19,4) NOT NULL
	ALTER TABLE SLS.[InvoiceItem] ADD [NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective)
	commit transaction
end
GO

if exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItem') and
				[name] = 'AdditionFactorInBaseCurrency_VatEffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[InvoiceItem] SET [AdditionFactorInBaseCurrency_VatEffective] = 0 where [AdditionFactorInBaseCurrency_VatEffective] IS NULL
    Alter table SLS.[InvoiceItem] ALTER COLUMN [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NOT NULL
end
GO

if exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItem') and
				[name] = 'AdditionFactor_VatIneffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[InvoiceItem] SET [AdditionFactor_VatIneffective] = 0 where [AdditionFactor_VatIneffective] IS NULL

	begin transaction
	
	IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
				WHERE OBJECT_ID=OBJECT_ID('SLS.InvoiceItem') AND [name] = 'NetPrice')
	BEGIN
		ALTER TABLE SLS.[InvoiceItem] DROP COLUMN NetPrice
	END

	Alter table SLS.[InvoiceItem] ALTER COLUMN [AdditionFactor_VatIneffective] [decimal](19,4) NOT NULL
	ALTER TABLE SLS.[InvoiceItem] ADD [NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective)

	commit transaction
end
GO

if exists (select 1 from sys.columns where object_id=object_id('SLS.InvoiceItem') and
				[name] = 'AdditionFactorInBaseCurrency_VatIneffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[InvoiceItem] SET [AdditionFactorInBaseCurrency_VatIneffective] = 0 where [AdditionFactorInBaseCurrency_VatIneffective] IS NULL
    Alter table SLS.[InvoiceItem] ALTER COLUMN [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NOT NULL
end
GO

IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
		  WHERE OBJECT_ID=OBJECT_ID('SLS.InvoiceItem') AND [name] = 'NetPrice')
BEGIN
	ALTER TABLE SLS.InvoiceItem DROP COLUMN NetPrice
	ALTER TABLE SLS.InvoiceItem ADD [NetPrice]  AS (((((([Quantity]*[Fee]+[Tax])+[Duty])+(ISNULL([Addition],0)))-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective) PERSISTED
END

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_InvoiceItem')
ALTER TABLE [SLS].[InvoiceItem] ADD  CONSTRAINT [PK_InvoiceItem] PRIMARY KEY CLUSTERED 
(
	[InvoiceItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--
IF NOT EXISTS (
select *
from sys.all_columns c 
	join sys.tables t on t.object_id = c.object_id
    join sys.schemas s on s.schema_id = t.schema_id
    join sys.default_constraints d on c.default_object_id = d.object_id
where t.name = 'InvoiceItem' and 
	  c.name = 'PriceInfoPriceDiscount' and 
	  s.name = 'SLS')
BEGIN
	ALTER TABLE [SLS].[InvoiceItem] ADD  DEFAULT ((0)) FOR [PriceInfoPriceDiscount]
END

IF NOT EXISTS (
select *
from sys.all_columns c 
	join sys.tables t on t.object_id = c.object_id
    join sys.schemas s on s.schema_id = t.schema_id
    join sys.default_constraints d on c.default_object_id = d.object_id
where t.name = 'InvoiceItem' and 
	  c.name = 'PriceInfoPercentDiscount' and 
	  s.name = 'SLS')
BEGIN
	ALTER TABLE [SLS].[InvoiceItem] ADD  DEFAULT ((0)) FOR [PriceInfoPercentDiscount]
END
--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

If not Exists (select 1 from sys.indexes where name = 'IX_InvoiceItem_QuotationItemRef')
CREATE NONCLUSTERED INDEX [IX_InvoiceItem_QuotationItemRef] ON [SLS].[InvoiceItem] 
(
	[QuotationItemRef] ASC
) ON [PRIMARY]

GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_InvoiceItem_ItemStockRef')
	CREATE NONCLUSTERED INDEX IX_InvoiceItem_ItemStockRef
		ON [SLS].[InvoiceItem] ([ItemRef],[StockRef])
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_InvoiceItem_InvoiceRef')
	CREATE NONCLUSTERED INDEX [IX_InvoiceItem_InvoiceRef]
		ON [SLS].[InvoiceItem] ([InvoiceRef])
GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_InvoiceItem_DiscountItemGroupRef')
ALTER TABLE [SLS].[InvoiceItem]  ADD  CONSTRAINT [FK_InvoiceItem_DiscountItemGroupRef] FOREIGN KEY([DiscountItemGroupRef])
REFERENCES [SLS].[DiscountItemGroup] ([DiscountItemGroupID])
ON DELETE SET NULL
GO

If not Exists (select 1 from sys.objects where name = 'FK_InvoiceItem_InvoiceRef')
ALTER TABLE [SLS].[InvoiceItem]  ADD  CONSTRAINT [FK_InvoiceItem_InvoiceRef] FOREIGN KEY([InvoiceRef])
REFERENCES [SLS].[Invoice] ([InvoiceId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

If not Exists (select 1 from sys.objects where name = 'FK_InvoiceItem_ItemRef')
ALTER TABLE [SLS].[InvoiceItem]  ADD  CONSTRAINT [FK_InvoiceItem_ItemRef] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_InvoiceItem_QuotationItemRef')
ALTER TABLE [SLS].[InvoiceItem]  ADD  CONSTRAINT [FK_InvoiceItem_QuotationItemRef] FOREIGN KEY([QuotationItemRef])
REFERENCES [SLS].[QuotationItem] ([QuotationItemID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_InvoiceItem_StockRef')
ALTER TABLE [SLS].[InvoiceItem]  ADD  CONSTRAINT [FK_InvoiceItem_StockRef] FOREIGN KEY([StockRef])
REFERENCES [INV].[Stock] ([StockID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_InvoiceItem_TracingRef')
ALTER TABLE [SLS].[InvoiceItem]  ADD  CONSTRAINT [FK_InvoiceItem_TracingRef] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])
GO

If not Exists (select 1 from sys.objects where name = 'FK_InvoiceItem_DiscountInvoiceItemRef')
ALTER TABLE [SLS].[InvoiceItem]  ADD  CONSTRAINT [FK_InvoiceItem_DiscountInvoiceItemRef] FOREIGN KEY([DiscountInvoiceItemRef])
REFERENCES [SLS].[InvoiceItem] ([InvoiceItemID])
--ON UPDATE CASCADE
--ON DELETE CASCADE
GO

If not Exists (select 1 from sys.objects where name = 'FK_InvoiceItem_OrderItemRef')
ALTER TABLE [SLS].[InvoiceItem]  ADD  CONSTRAINT [FK_InvoiceItem_OrderItemRef] FOREIGN KEY([OrderItemRef])
REFERENCES [DST].[OrderItem] ([OrderItemID])
GO
If not Exists (select 1 from sys.objects where name = 'FK_InvoiceItem_ProductPackRef_ProductPack')
ALTER TABLE [SLS].[InvoiceItem]  ADD  CONSTRAINT [FK_InvoiceItem_ProductPackRef_ProductPack] FOREIGN KEY([ProductPackRef])
REFERENCES [sls].[ProductPack] ([ProductPackid])
GO
--<< DROP OBJECTS >>--
