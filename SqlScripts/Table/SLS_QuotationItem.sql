--<<FileName:SLS_QuotationItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.QuotationItem') Is Null
CREATE TABLE [SLS].[QuotationItem](
       [QuotationItemID] [int] NOT NULL,
       [QuotationRef] [int] NOT NULL,
       [RowID] [int] NOT NULL,
       [ItemRef] [int] NOT NULL,
       [TracingRef] [int] NULL,
       [StockRef] [int] NULL,
       [Quantity] [decimal](19, 4) NOT NULL,
       [SecondaryQuantity] [decimal](19, 4) NULL,
       [Fee] [decimal](19, 4) NOT NULL,
       [Price] [decimal](19, 4) NOT NULL,
       [PriceInBaseCurrency] [decimal](19, 4) NOT NULL,
       [Discount] [decimal](19, 4) NULL,
       [DiscountInBaseCurrency] [decimal](19, 4) NULL,
       [PriceInfoDiscountRate] [decimal](5, 2) NULL,
       [PriceInfoPriceDiscount] [decimal] (19,4) NOT NULL DEFAULT 0,
       [PriceInfoPercentDiscount] [decimal](19,4) NOT NULL DEFAULT 0,
       [AggregateAmountDiscountRate] [decimal](5, 2)  NOT NULL DEFAULT 0, 
	   [AggregateAmountPriceDiscount] [decimal](19, 4) NOT NULL DEFAULT 0, 
	   [AggregateAmountPercentDiscount] [decimal](19,4) NOT NULL DEFAULT 0, 
	
       [CustomerDiscount][decimal](19,4) NOT NULL,
       [CustomerDiscountRate] [decimal](5, 2) NULL,
       [Addition] [decimal](19, 4) NULL DEFAULT 0,
       [AdditionInBaseCurrency] [decimal](19, 4) NULL DEFAULT 0,
       [Tax] [decimal](19, 4) NULL,
       [TaxInBaseCurrency] [decimal](19, 4) NULL,
       [Duty] [decimal](19, 4) NULL,
       [DutyInBaseCurrency] [decimal](19, 4) NULL,
       [AdditionFactor_VatEffective] [decimal](19, 4) NOT NULL,
       [AdditionFactorInBaseCurrency_VatEffective] [decimal](19, 4) NOT NULL,
       [AdditionFactor_VatIneffective] [decimal](19, 4) NOT NULL,
       [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19, 4) NOT NULL,
       [NetPrice]  AS (((((([Quantity]*[Fee]+[Tax])+[Duty])+(ISNULL([Addition],0)))-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective) PERSISTED,
       [NetPriceInBaseCurrency] [decimal](19, 4) NOT NULL,
       [Rate] [decimal](26, 16) NOT NULL,
       [UsedQuantity] [decimal](19, 4) NOT NULL,
       [Description] NVARCHAR(255) NULL,
       [DiscountQuotationItemRef] INT NULL,
	   [ProductPackRef] int null,
	   [ProductPackQuantity] [decimal](19, 4)  NULL,
	   [IsAggregateDiscountInvoiceItem] [bit] NOT NULL DEFAULT (0),
	   [IsReadyForProductOrder] [bit] NOT NULL DEFAULT (1),
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.QuotationItem') AND
	[name]='IsAggregateDiscountInvoiceItem')
BEGIN
	ALTER TABLE SLS.QuotationItem ADD [IsAggregateDiscountInvoiceItem] bit NOT NULL DEFAULT (0)
END
GO

if not exists (select 1 from sys.columns where object_id=object_id('SLS.QuotationItem') and
				[name] = 'ProductPackRef')
begin
    Alter table SLS.QuotationItem Add [ProductPackRef]  int NULL 
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('SLS.QuotationItem') and
				[name] = 'ProductPackQuantity')
begin
    Alter table SLS.QuotationItem Add [ProductPackQuantity] [decimal](19, 4) NULL 
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.QuotationItem') and
				[name] = 'AggregateAmountDiscountRate')
begin
    Alter table SLS.QuotationItem Add [AggregateAmountDiscountRate] [decimal](5, 2)  NOT NULL DEFAULT 0 
	
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.QuotationItem') and
				[name] = 'AggregateAmountPriceDiscount')
begin
    Alter table SLS.QuotationItem Add [AggregateAmountPriceDiscount] [decimal](19, 4) NOT NULL DEFAULT 0	
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.QuotationItem') and
				[name] = 'AggregateAmountPercentDiscount')
begin
    Alter table SLS.QuotationItem Add [AggregateAmountPercentDiscount] [decimal](19,4) NOT NULL DEFAULT 0
end
GO
--<<Sample>>--
if not exists (select 1 from sys.columns where object_id=object_id('SLS.QuotationItem') and
                           [name] = 'Description')
begin
    Alter table SLS.QuotationItem Add Description NVARCHAR(255) NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.QuotationItem') and
                           [name] = 'Description_En')
begin
    Alter table SLS.QuotationItem Add Description_En NVARCHAR(255) NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.QuotationItem') and
                           [name] = 'DiscountQuotationItemRef')
begin
    Alter table SLS.QuotationItem Add DiscountQuotationItemRef INT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.QuotationItem') and
                           [name] = 'PriceInfoPriceDiscount')
begin
    Alter table SLS.QuotationItem Add [PriceInfoPriceDiscount] [decimal] (19,4) NOT NULL DEFAULT 0
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.QuotationItem') and
                           [name] = 'PriceInfoPercentDiscount')
begin
    Alter table SLS.QuotationItem Add [PriceInfoPercentDiscount] [decimal](19,4) NOT NULL DEFAULT 0
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('SLS.QuotationItem') and
                           [name] = 'CustomerDiscount')
begin
    Alter table SLS.QuotationItem Add [CustomerDiscount] [decimal](19, 4) NULL 
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('SLS.QuotationItem') and
                           [name] = 'IsReadyForProductOrder')
begin
    Alter table SLS.QuotationItem Add [IsReadyForProductOrder] [bit] NOT NULL DEFAULT (1)
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('SLS.QuotationItem') and
				[name] = 'AdditionFactor_VatEffective')
begin
    Alter table SLS.QuotationItem Add [AdditionFactor_VatEffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.[QuotationItem] SET AdditionFactor_VatEffective=0')
	Alter table SLS.QuotationItem ALTER COLUMN [AdditionFactor_VatEffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.QuotationItem') and
				[name] = 'AdditionFactorInBaseCurrency_VatEffective')
begin
    Alter table SLS.QuotationItem Add [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.[QuotationItem] SET AdditionFactorInBaseCurrency_VatEffective=0')
	Alter table SLS.QuotationItem ALTER COLUMN [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.QuotationItem') and
				[name] = 'AdditionFactor_VatIneffective')
begin
    Alter table SLS.QuotationItem Add [AdditionFactor_VatIneffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.[QuotationItem] SET AdditionFactor_VatIneffective=0')
	Alter table SLS.QuotationItem ALTER COLUMN [AdditionFactor_VatIneffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.QuotationItem') and
				[name] = 'AdditionFactorInBaseCurrency_VatIneffective')
begin
    Alter table SLS.QuotationItem Add [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.[QuotationItem] SET AdditionFactorInBaseCurrency_VatIneffective=0')
	Alter table SLS.QuotationItem ALTER COLUMN [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NOT NULL
end
GO

--<< ALTER COLUMNS >>--

IF EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.QuotationItem') AND
                           [name] = 'NetPriceInBaseCurrency' AND is_Computed = 1)
BEGIN
       ALTER TABLE SLS.QuotationItem DROP COLUMN PriceInBaseCurrency
       ALTER TABLE SLS.QuotationItem DROP COLUMN DiscountInBaseCurrency
       ALTER TABLE SLS.QuotationItem DROP COLUMN AdditionInBaseCurrency
       ALTER TABLE SLS.QuotationItem DROP COLUMN TaxInBaseCurrency
       ALTER TABLE SLS.QuotationItem DROP COLUMN DutyInBaseCurrency
       ALTER TABLE SLS.QuotationItem DROP COLUMN NetPriceInBaseCurrency

       ALTER TABLE SLS.QuotationItem ADD PriceInBaseCurrency  DECIMAL(19,4)
       ALTER TABLE SLS.QuotationItem ADD DiscountInBaseCurrency DECIMAL(19,4)
       ALTER TABLE SLS.QuotationItem ADD AdditionInBaseCurrency DECIMAL(19,4)
       ALTER TABLE SLS.QuotationItem ADD TaxInBaseCurrency DECIMAL(19,4)
       ALTER TABLE SLS.QuotationItem ADD DutyInBaseCurrency DECIMAL(19,4)
       ALTER TABLE SLS.QuotationItem ADD NetPriceInBaseCurrency DECIMAL(19,4)
END


ALTER TABLE SLS.QuotationItem ALTER COLUMN UsedQuantity DECIMAL(19,4)

IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.QuotationItem') AND
                           [name] = 'Quantity' AND scale=3)
BEGIN
       IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.QuotationItem') AND
                           [name] = 'NetPrice' )
              ALTER TABLE SLS.QuotationItem DROP COLUMN [NetPrice]
       ALTER TABLE SLS.QuotationItem ALTER COLUMN [Quantity] [decimal](19, 4) NOT NULL
       ALTER TABLE SLS.QuotationItem ADD
              [NetPrice]  AS (((([Quantity]*[Fee]+[Tax])+[Duty])+(ISNULL([Addition],0)))-[Discount]) PERSISTED
END

IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.QuotationItem') AND
                           [name] = 'SecondaryQuantity' AND scale=3)
       ALTER TABLE SLS.QuotationItem ALTER COLUMN [SecondaryQuantity] [decimal](19, 4) NULL



IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.QuotationItem') AND
                           [name] = 'Discount' AND is_nullable = 1)
BEGIN 
IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.QuotationItem') AND
                           [name] = 'NetPrice' )
       ALTER TABLE SLS.QuotationItem DROP COLUMN [NetPrice]

       if NOT EXISTS(SELECT    *     FROM sys.default_constraints  
                           WHERE name ='QutationItem_Discount_Default')
       ALTER TABLE SLS.QuotationItem ADD CONSTRAINT QutationItem_Discount_Default DEFAULT 0 for Discount

       ALTER TABLE SLS.QuotationItem ALTER COLUMN [Discount] [decimal](19, 4) NOT NULL
       ALTER TABLE SLS.QuotationItem ADD
              [NetPrice]  AS (((([Quantity]*[Fee]+[Tax])+[Duty])+(ISNULL([Addition],0)))-[Discount]) PERSISTED
END

IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.QuotationItem') AND
                           [name] = 'DiscountInBaseCurrency' AND is_nullable = 1)
BEGIN
       UPDATE SLS.QuotationItem
       SET DiscountInBaseCurrency = 0
       WHERE DiscountInBaseCurrency IS NULL

       ALTER TABLE SLS.QuotationItem ALTER COLUMN [DiscountInBaseCurrency]  [decimal](19, 4) NOT NULL
END

IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.QuotationItem') AND
                           [name] = 'PriceInfoDiscountRate' AND is_nullable = 1)
BEGIN
       UPDATE SLS.QuotationItem
       SET PriceInfoDiscountRate = 0
       WHERE PriceInfoDiscountRate IS NULL

       ALTER TABLE SLS.QuotationItem ALTER COLUMN [PriceInfoDiscountRate] [decimal](5, 2) NOT NULL
END

IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.QuotationItem') AND
                           [name] = 'PriceInfoPriceDiscount' AND is_nullable = 1)
BEGIN
       UPDATE SLS.QuotationItem
       SET PriceInfoPriceDiscount = 0
       WHERE PriceInfoPriceDiscount IS NULL

       ALTER TABLE SLS.QuotationItem ALTER COLUMN [PriceInfoPriceDiscount] [decimal](19, 4) NOT NULL
END

IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.QuotationItem') AND
                           [name] = 'PriceInfoPercentDiscount' AND is_nullable = 1)
BEGIN
       UPDATE SLS.QuotationItem
       SET PriceInfoPercentDiscount = 0
       WHERE PriceInfoPercentDiscount IS NULL

       ALTER TABLE SLS.QuotationItem ALTER COLUMN [PriceInfoPercentDiscount] [decimal](19,4) NOT NULL 
END

IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.QuotationItem') AND
                           [name] = 'CustomerDiscountRate' AND is_nullable = 1)
BEGIN
       UPDATE SLS.QuotationItem
       SET CustomerDiscountRate = 0
       WHERE CustomerDiscountRate IS NULL

       ALTER TABLE SLS.QuotationItem ALTER COLUMN [CustomerDiscountRate] [decimal](5,2) NOT NULL 
END

if exists (select 1 from sys.columns where object_id=object_id('SLS.QuotationItem') and
				[name] = 'AdditionFactor_VatEffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[QuotationItem] SET [AdditionFactor_VatEffective] = 0 where [AdditionFactor_VatEffective] IS NULL

	begin transaction
	IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
				WHERE OBJECT_ID=OBJECT_ID('SLS.QuotationItem') AND [name] = 'NetPrice')
	BEGIN
		ALTER TABLE SLS.[QuotationItem] DROP COLUMN NetPrice
	END

	Alter table SLS.[QuotationItem] ALTER COLUMN [AdditionFactor_VatEffective] [decimal](19,4) NOT NULL
	ALTER TABLE SLS.[QuotationItem] ADD [NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective)
	commit transaction
end
GO

if exists (select 1 from sys.columns where object_id=object_id('SLS.QuotationItem') and
				[name] = 'AdditionFactorInBaseCurrency_VatEffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[QuotationItem] SET [AdditionFactorInBaseCurrency_VatEffective] = 0 where [AdditionFactorInBaseCurrency_VatEffective] IS NULL
    Alter table SLS.[QuotationItem] ALTER COLUMN [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NOT NULL
end
GO

if exists (select 1 from sys.columns where object_id=object_id('SLS.QuotationItem') and
				[name] = 'AdditionFactor_VatIneffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[QuotationItem] SET [AdditionFactor_VatIneffective] = 0 where [AdditionFactor_VatIneffective] IS NULL

	begin transaction
	
	IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
				WHERE OBJECT_ID=OBJECT_ID('SLS.QuotationItem') AND [name] = 'NetPrice')
	BEGIN
		ALTER TABLE SLS.[QuotationItem] DROP COLUMN NetPrice
	END

	Alter table SLS.[QuotationItem] ALTER COLUMN [AdditionFactor_VatIneffective] [decimal](19,4) NOT NULL
	ALTER TABLE SLS.[QuotationItem] ADD [NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective)

	commit transaction
end
GO

if exists (select 1 from sys.columns where object_id=object_id('SLS.QuotationItem') and
				[name] = 'AdditionFactorInBaseCurrency_VatIneffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[QuotationItem] SET [AdditionFactorInBaseCurrency_VatIneffective] = 0 where [AdditionFactorInBaseCurrency_VatIneffective] IS NULL
    Alter table SLS.[QuotationItem] ALTER COLUMN [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NOT NULL
end
GO

IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
		  WHERE OBJECT_ID=OBJECT_ID('SLS.QuotationItem') AND [name] = 'NetPrice')
BEGIN
	ALTER TABLE SLS.QuotationItem DROP COLUMN NetPrice
	ALTER TABLE SLS.QuotationItem ADD [NetPrice]  AS (((((([Quantity]*[Fee]+[Tax])+[Duty])+(ISNULL([Addition],0)))-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective) PERSISTED
END

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_QuotationItem')
ALTER TABLE [SLS].[QuotationItem] ADD  CONSTRAINT [PK_QuotationItem] PRIMARY KEY CLUSTERED 
(
       [QuotationItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--
IF NOT EXISTS (
select *
from sys.all_columns c 
       join sys.tables t on t.object_id = c.object_id
    join sys.schemas s on s.schema_id = t.schema_id
    join sys.default_constraints d on c.default_object_id = d.object_id
where t.name = 'QuotationItem' and 
         c.name = 'PriceInfoPriceDiscount' and 
         s.name = 'SLS')
BEGIN
       ALTER TABLE [SLS].[QuotationItem] ADD  DEFAULT ((0)) FOR [PriceInfoPriceDiscount]
END

IF NOT EXISTS (
select *
from sys.all_columns c 
       join sys.tables t on t.object_id = c.object_id
    join sys.schemas s on s.schema_id = t.schema_id
    join sys.default_constraints d on c.default_object_id = d.object_id
where t.name = 'QuotationItem' and 
         c.name = 'PriceInfoPercentDiscount' and 
         s.name = 'SLS')
BEGIN
       ALTER TABLE [SLS].[QuotationItem] ADD  DEFAULT ((0)) FOR [PriceInfoPercentDiscount]
END
--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_QuotationItem_ItemRef')
ALTER TABLE [SLS].[QuotationItem]  ADD  CONSTRAINT [FK_QuotationItem_ItemRef] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_QuotationItem_QuotationRef')
ALTER TABLE [SLS].[QuotationItem]  ADD  CONSTRAINT [FK_QuotationItem_QuotationRef] FOREIGN KEY([QuotationRef])
REFERENCES [SLS].[Quotation] ([QuotationId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_QuotationItem_StockRef')
ALTER TABLE [SLS].[QuotationItem]  ADD  CONSTRAINT [FK_QuotationItem_StockRef] FOREIGN KEY([StockRef])
REFERENCES [INV].[Stock] ([StockID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_QuotationItem_TracingRef')
ALTER TABLE [SLS].[QuotationItem]  ADD  CONSTRAINT [FK_QuotationItem_TracingRef] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])

GO

If not Exists (select 1 from sys.objects where name = 'FK_QuotationItem_DiscountQuotationItemRef')
ALTER TABLE [SLS].[QuotationItem]  ADD  CONSTRAINT [FK_QuotationItem_DiscountQuotationItemRef] FOREIGN KEY([DiscountQuotationItemRef])
REFERENCES [SLS].[QuotationItem] ([QuotationItemID])

GO

--<< DROP OBJECTS >>--
