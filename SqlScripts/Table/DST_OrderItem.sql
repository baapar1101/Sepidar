If Object_ID('DST.OrderItem') Is Null
CREATE TABLE [DST].[OrderItem]
(
	[OrderItemID] [int] NOT NULL,
	[OrderRef] [int] NOT NULL,
	[RowID] [int] NOT NULL,
	[ItemRef] [int] NOT NULL,
	[TracingRef] [int] NULL,
	[StockRef] [int] NULL,
	[OrderedQuantity] [decimal](19, 4) NOT NULL,
	[OrderedSecondaryQuantity] [decimal](19, 4) NULL,
	[Quantity] [decimal](19, 4) NULL,
	[SecondaryQuantity] [decimal](19, 4) NULL,
	[InvoicedQuantity] [decimal](19, 4) NULL,
	[Fee] [decimal](19, 4) NULL,
	[Price] [decimal](19, 4) NULL,
	[PriceInBaseCurrency] [decimal](19, 4) NULL,
	[Discount] [decimal](19, 4) NULL,
	[DiscountInBaseCurrency] [decimal](19, 4) NULL,
	[DiscountItemGroupRef] [int] Null,
	[PriceInfoDiscountRate] [decimal](5, 2) NULL,
	[PriceInfoPriceDiscount] [decimal](19, 4) NULL DEFAULT 0, 
	[PriceInfoPercentDiscount] [decimal](19,4) NULL DEFAULT 0, 
	[CustomerDiscount][decimal](19,4) NULL,
	[CustomerDiscountRate] [decimal](5, 2) NULL,
	[Addition] [decimal](19, 4) NULL,
	[AdditionInBaseCurrency] [decimal](19, 4) NULL,
	[Tax] [decimal](19, 4) NULL,
	[TaxInBaseCurrency] [decimal](19, 4) NULL,
	[Duty] [decimal](19, 4) NULL,
	[DutyInBaseCurrency] [decimal](19, 4) NULL,
	[NetPriceInBaseCurrency] [decimal](19, 4) NULL,
	[Description] [nvarchar](255) NULL,
	[Description_En] [nvarchar](255) NULL,
	[AdditionFactor_VatEffective] [decimal](19, 4) NOT NULL,
	[AdditionFactorInBaseCurrency_VatEffective] [decimal](19, 4) NOT NULL,
	[AdditionFactor_VatIneffective] [decimal](19, 4) NOT NULL,
	[AdditionFactorInBaseCurrency_VatIneffective] [decimal](19, 4) NOT NULL,
	[NetPrice]  AS (((((([Quantity]*[Fee]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective) PERSISTED,
	[DiscountOrderItemRef] [int] NULL,
	[Rate] [decimal](26, 16) NULL,
	[ProductPackRef]  int NULL ,
	[OrderedProductPackQuantity] [decimal](19, 4) NULL ,
	[ProductPackQuantity] [decimal](19, 4) NULL ,
	[AggregateAmountDiscountRate] [decimal](5, 2)  NULL DEFAULT 0, 
	[AggregateAmountPriceDiscount] [decimal](19, 4) NULL DEFAULT 0, 
	[AggregateAmountPercentDiscount] [decimal](19,4) NULL DEFAULT 0, 
	[IsAggregateDiscountInvoiceItem] [bit] NOT NULL DEFAULT (0)
) 
ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('DST.OrderItem') AND
	[name]='IsAggregateDiscountInvoiceItem')
BEGIN
	ALTER TABLE DST.OrderItem ADD [IsAggregateDiscountInvoiceItem] bit NOT NULL DEFAULT (0)
END
GO

if not exists (select 1 from sys.columns where object_id=object_id('DST.OrderItem') and
				[name] = 'ProductPackRef')
begin
    Alter table DST.OrderItem Add [ProductPackRef]  int NULL 
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('DST.OrderItem') and
				[name] = 'ProductPackQuantity')
begin
    Alter table DST.OrderItem Add [ProductPackQuantity] [decimal](19, 4) NULL 
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('DST.OrderItem') and
				[name] = 'OrderedProductPackQuantity')
begin
    Alter table DST.OrderItem Add [OrderedProductPackQuantity] [decimal](19, 4) NULL 
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('DST.OrderItem') and
				[name] = 'AggregateAmountDiscountRate')
begin
    Alter table DST.OrderItem Add [AggregateAmountDiscountRate] [decimal](5, 2)  NULL DEFAULT 0 
	
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('DST.OrderItem') and
				[name] = 'AggregateAmountPriceDiscount')
begin
    Alter table DST.OrderItem Add [AggregateAmountPriceDiscount] [decimal](19, 4) NULL DEFAULT 0	
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('DST.OrderItem') and
				[name] = 'AggregateAmountPercentDiscount')
begin
    Alter table DST.OrderItem Add [AggregateAmountPercentDiscount] [decimal](19,4) NULL DEFAULT 0
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('DST.OrderItem') and
				[name] = 'DiscountItemGroupRef')
begin
    Alter table DST.OrderItem Add [DiscountItemGroupRef] [int] NULL 
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('DST.OrderItem') and
				[name] = 'AdditionFactor_VatEffective')
begin
    Alter table DST.OrderItem Add [AdditionFactor_VatEffective] [decimal](19,4) NULL
	EXEC('UPDATE DST.[OrderItem] SET AdditionFactor_VatEffective=0')
	Alter table DST.OrderItem ALTER COLUMN [AdditionFactor_VatEffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('DST.OrderItem') and
				[name] = 'AdditionFactorInBaseCurrency_VatEffective')
begin
    Alter table DST.OrderItem Add [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NULL
	EXEC('UPDATE DST.[OrderItem] SET AdditionFactorInBaseCurrency_VatEffective=0')
	Alter table DST.OrderItem ALTER COLUMN [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('DST.OrderItem') and
				[name] = 'AdditionFactor_VatIneffective')
begin
    Alter table DST.OrderItem Add [AdditionFactor_VatIneffective] [decimal](19,4) NULL
	EXEC('UPDATE DST.[OrderItem] SET AdditionFactor_VatIneffective=0')
	Alter table DST.OrderItem ALTER COLUMN [AdditionFactor_VatIneffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('DST.OrderItem') and
				[name] = 'AdditionFactorInBaseCurrency_VatIneffective')
begin
    Alter table DST.OrderItem Add [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NULL
	EXEC('UPDATE DST.[OrderItem] SET AdditionFactorInBaseCurrency_VatIneffective=0')
	Alter table DST.OrderItem ALTER COLUMN [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NOT NULL
end
GO

--<< ALTER COLUMNS >>--
if exists (select 1 from sys.columns where object_id=object_id('DST.OrderItem') and
				[name] = 'AdditionFactor_VatEffective' and [is_nullable] = 1)
begin
	UPDATE DST.[OrderItem] SET [AdditionFactor_VatEffective] = 0 where [AdditionFactor_VatEffective] IS NULL

	begin transaction
	IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
				WHERE OBJECT_ID=OBJECT_ID('DST.OrderItem') AND [name] = 'NetPrice')
	BEGIN
		ALTER TABLE DST.[OrderItem] DROP COLUMN NetPrice
	END

	Alter table DST.[OrderItem] ALTER COLUMN [AdditionFactor_VatEffective] [decimal](19,4) NOT NULL
	ALTER TABLE DST.[OrderItem] ADD [NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective)
	commit transaction
end
GO

if exists (select 1 from sys.columns where object_id=object_id('DST.OrderItem') and
				[name] = 'AdditionFactorInBaseCurrency_VatEffective' and [is_nullable] = 1)
begin
	UPDATE DST.[OrderItem] SET [AdditionFactorInBaseCurrency_VatEffective] = 0 where [AdditionFactorInBaseCurrency_VatEffective] IS NULL
    Alter table DST.[OrderItem] ALTER COLUMN [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NOT NULL
end
GO

if exists (select 1 from sys.columns where object_id=object_id('DST.OrderItem') and
				[name] = 'AdditionFactor_VatIneffective' and [is_nullable] = 1)
begin
	UPDATE DST.[OrderItem] SET [AdditionFactor_VatIneffective] = 0 where [AdditionFactor_VatIneffective] IS NULL

	begin transaction
	
	IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
				WHERE OBJECT_ID=OBJECT_ID('DST.OrderItem') AND [name] = 'NetPrice')
	BEGIN
		ALTER TABLE DST.[OrderItem] DROP COLUMN NetPrice
	END

	Alter table DST.[OrderItem] ALTER COLUMN [AdditionFactor_VatIneffective] [decimal](19,4) NOT NULL
	ALTER TABLE DST.[OrderItem] ADD [NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective)

	commit transaction
end
GO

if exists (select 1 from sys.columns where object_id=object_id('DST.OrderItem') and
				[name] = 'AdditionFactorInBaseCurrency_VatIneffective' and [is_nullable] = 1)
begin
	UPDATE DST.[OrderItem] SET [AdditionFactorInBaseCurrency_VatIneffective] = 0 where [AdditionFactorInBaseCurrency_VatIneffective] IS NULL
    Alter table DST.[OrderItem] ALTER COLUMN [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NOT NULL
end
GO

IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
		  WHERE OBJECT_ID=OBJECT_ID('DST.OrderItem') AND [name] = 'NetPrice')
BEGIN
	ALTER TABLE DST.OrderItem DROP COLUMN NetPrice
	ALTER TABLE DST.OrderItem ADD [NetPrice]  AS (((((([Quantity]*[Fee]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective) PERSISTED
END

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_DST_OrderItem')
ALTER TABLE [DST].[OrderItem] ADD  CONSTRAINT [PK_DST_OrderItem] PRIMARY KEY CLUSTERED 
(
	[OrderItemID] ASC
) 
ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_OrderItem_DiscountItemGroupRef')
ALTER TABLE [DST].[OrderItem]  ADD  CONSTRAINT [FK_OrderItem_DiscountItemGroupRef] FOREIGN KEY([DiscountItemGroupRef])
REFERENCES [SLS].[DiscountItemGroup] ([DiscountItemGroupID])
ON DELETE SET NULL
GO

If NOT Exists (select 1 from sys.objects where name = 'FK_OrderItem_OrderRef')
ALTER TABLE [DST].[OrderItem] ADD CONSTRAINT [FK_OrderItem_OrderRef] FOREIGN KEY([OrderRef])
REFERENCES [DST].[Order] ([OrderID])
ON DELETE CASCADE

If NOT Exists (select 1 from sys.objects where name = 'FK_OrderItem_ItemRef')
ALTER TABLE [DST].[OrderItem] ADD CONSTRAINT [FK_OrderItem_ItemRef] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])

If NOT Exists (select 1 from sys.objects where name = 'FK_OrderItem_TracingRef')
ALTER TABLE [DST].[OrderItem] ADD CONSTRAINT [FK_OrderItem_TracingRef] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])

If NOT Exists (select 1 from sys.objects where name = 'FK_OrderItem_StockRef')
ALTER TABLE [DST].[OrderItem] ADD CONSTRAINT [FK_OrderItem_StockRef] FOREIGN KEY([StockRef])
REFERENCES [INV].[Stock] ([StockID])

If NOT Exists (select 1 from sys.objects where name = 'FK_OrderItem_DiscountOrderItemRef')
ALTER TABLE [DST].[OrderItem] ADD CONSTRAINT [FK_OrderItem_DiscountOrderItemRef] FOREIGN KEY([DiscountOrderItemRef])
REFERENCES [DST].[OrderItem] ([OrderItemID])

GO


If NOT Exists (select 1 from sys.objects where name = 'FK_OrderItem_ProductPackRef_ProductPack')
ALTER TABLE [DST].[OrderItem] ADD CONSTRAINT [FK_OrderItem_ProductPackRef_ProductPack] FOREIGN KEY([ProductPackRef])
REFERENCES [sls].[ProductPack] ([ProductPackid])

GO

--<< DROP OBJECTS >>--
