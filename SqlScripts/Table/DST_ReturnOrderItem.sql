If Object_ID('DST.ReturnOrderItem') Is Null
CREATE TABLE [DST].[ReturnOrderItem]
(
	[ReturnOrderItemID] [int] NOT NULL,
	[ReturnOrderRef] [int] NOT NULL,
	[RowID] [int] NOT NULL,
	[InvoiceItemRef] [int] NULL,
	[ItemRef] [int] NOT NULL,
	[TracingRef] [int] NULL,
	[StockRef] [int] NULL,
	[Quantity] [decimal](19, 4) NOT NULL,
	[SecondaryQuantity] [decimal](19, 4) NULL,
	[Fee] [decimal](19, 4) NULL,
	[Price] [decimal](19, 4) NULL,
	[PriceInBaseCurrency] [decimal](19, 4) NULL,
	[Discount] [decimal](19, 4) NULL,
	[DiscountInBaseCurrency] [decimal](19, 4) NULL,
	[PriceInfoDiscountRate] [decimal](5, 2) NULL,
	[PriceInfoPriceDiscount] [decimal](19, 4) NULL, 
	[PriceInfoPercentDiscount] [decimal](19,4) NULL, 
	[CustomerDiscount][decimal](19,4) NULL,
	[CustomerDiscountRate] [decimal](5, 2) NULL,
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
	[NetPrice]  AS (((((([Quantity]*[Fee]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective) PERSISTED,
	[NetPriceInBaseCurrency] [decimal](19, 4) NULL,
	[Description] [nvarchar](255) NULL,
	[Description_En] [nvarchar](255) NULL,
	[DiscountReturnOrderItemRef] [int] NULL,
	[Rate] [decimal](26, 16) NULL,
    [ReurnReasonRef] INT NULL,
	[ProductPackRef]  int NULL ,	
	[ProductPackQuantity] [decimal](19, 4) NULL ,
	[AggregateAmountDiscountRate] [decimal](5, 2)  NULL, 
	[AggregateAmountPriceDiscount] [decimal](19, 4) NULL, 
	[AggregateAmountPercentDiscount] [decimal](19,4) NULL, 
	[IsAggregateDiscountInvoiceItem] [bit] NOT NULL DEFAULT (0),
	[ForDiscountInvoiceItemRef] [int] NULL,
) 
ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('DST.ReturnOrderItem') AND
	[name]='ForDiscountInvoiceItemRef')
BEGIN
	ALTER TABLE DST.ReturnOrderItem ADD [ForDiscountInvoiceItemRef] [int] NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('DST.ReturnOrderItem') AND
	[name]='IsAggregateDiscountInvoiceItem')
BEGIN
	ALTER TABLE DST.ReturnOrderItem ADD [IsAggregateDiscountInvoiceItem] bit NOT NULL DEFAULT (0)
END
GO

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('SLS.Quotation') and
				[name] = 'ColumnName')
begin
    Alter table SLS.Quotation Add ColumnName DataType Nullable
end
GO*/
if not exists (select 1 from sys.columns where object_id=object_id('DST.ReturnOrderItem') and
				[name] = 'ProductPackRef')
begin
    Alter table DST.ReturnOrderItem Add [ProductPackRef]  int NULL 
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('DST.ReturnOrderItem') and
				[name] = 'ProductPackQuantity')
begin
    Alter table DST.ReturnOrderItem Add [ProductPackQuantity] [decimal](19, 4) NULL 
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('DST.ReturnOrderItem') and
				[name] = 'AggregateAmountDiscountRate')
begin
    Alter table DST.ReturnOrderItem Add [AggregateAmountDiscountRate] [decimal](5, 2) NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('DST.ReturnOrderItem') and
				[name] = 'AggregateAmountPriceDiscount')
begin
    Alter table DST.ReturnOrderItem Add [AggregateAmountPriceDiscount] [decimal](19, 4) NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('DST.ReturnOrderItem') and
				[name] = 'AggregateAmountPercentDiscount')
begin
    Alter table DST.ReturnOrderItem Add [AggregateAmountPercentDiscount] [decimal](19,4) NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('DST.ReturnOrderItem') and
				[name] = 'ReturnReasonRef')
begin
    Alter table DST.ReturnOrderItem Add [ReturnReasonRef] INT NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('DST.ReturnOrderItem') and
				[name] = 'AdditionFactor_VatEffective')
begin
    Alter table DST.ReturnOrderItem Add [AdditionFactor_VatEffective] [decimal](19,4) NULL
	EXEC('UPDATE DST.[ReturnOrderItem] SET AdditionFactor_VatEffective=0')
	Alter table DST.ReturnOrderItem ALTER COLUMN [AdditionFactor_VatEffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('DST.ReturnOrderItem') and
				[name] = 'AdditionFactorInBaseCurrency_VatEffective')
begin
    Alter table DST.ReturnOrderItem Add [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NULL
	EXEC('UPDATE DST.[ReturnOrderItem] SET AdditionFactorInBaseCurrency_VatEffective=0')
	Alter table DST.ReturnOrderItem ALTER COLUMN [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('DST.ReturnOrderItem') and
				[name] = 'AdditionFactor_VatIneffective')
begin
    Alter table DST.ReturnOrderItem Add [AdditionFactor_VatIneffective] [decimal](19,4) NULL
	EXEC('UPDATE DST.[ReturnOrderItem] SET AdditionFactor_VatIneffective=0')
	Alter table DST.ReturnOrderItem ALTER COLUMN [AdditionFactor_VatIneffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('DST.ReturnOrderItem') and
				[name] = 'AdditionFactorInBaseCurrency_VatIneffective')
begin
    Alter table DST.ReturnOrderItem Add [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NULL
	EXEC('UPDATE DST.[ReturnOrderItem] SET AdditionFactorInBaseCurrency_VatIneffective=0')
	Alter table DST.ReturnOrderItem ALTER COLUMN [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NOT NULL
end
GO

--<< ALTER COLUMNS >>--
if exists (select 1 from sys.columns where object_id=object_id('DST.ReturnOrderItem') and
				[name] = 'AdditionFactor_VatEffective' and [is_nullable] = 1)
begin
	UPDATE DST.[ReturnOrderItem] SET [AdditionFactor_VatEffective] = 0 where [AdditionFactor_VatEffective] IS NULL

	begin transaction
	IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
				WHERE OBJECT_ID=OBJECT_ID('DST.ReturnOrderItem') AND [name] = 'NetPrice')
	BEGIN
		ALTER TABLE DST.[ReturnOrderItem] DROP COLUMN NetPrice
	END

	Alter table DST.[ReturnOrderItem] ALTER COLUMN [AdditionFactor_VatEffective] [decimal](19,4) NOT NULL
	ALTER TABLE DST.[ReturnOrderItem] ADD [NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective)
	commit transaction
end
GO

if exists (select 1 from sys.columns where object_id=object_id('DST.ReturnOrderItem') and
				[name] = 'AdditionFactorInBaseCurrency_VatEffective' and [is_nullable] = 1)
begin
	UPDATE DST.[ReturnOrderItem] SET [AdditionFactorInBaseCurrency_VatEffective] = 0 where [AdditionFactorInBaseCurrency_VatEffective] IS NULL
    Alter table DST.[ReturnOrderItem] ALTER COLUMN [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NOT NULL
end
GO

if exists (select 1 from sys.columns where object_id=object_id('DST.ReturnOrderItem') and
				[name] = 'AdditionFactor_VatIneffective' and [is_nullable] = 1)
begin
	UPDATE DST.[ReturnOrderItem] SET [AdditionFactor_VatIneffective] = 0 where [AdditionFactor_VatIneffective] IS NULL

	begin transaction
	
	IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
				WHERE OBJECT_ID=OBJECT_ID('DST.ReturnOrderItem') AND [name] = 'NetPrice')
	BEGIN
		ALTER TABLE DST.[ReturnOrderItem] DROP COLUMN NetPrice
	END

	Alter table DST.[ReturnOrderItem] ALTER COLUMN [AdditionFactor_VatIneffective] [decimal](19,4) NOT NULL
	ALTER TABLE DST.[ReturnOrderItem] ADD [NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective)

	commit transaction
end
GO

if exists (select 1 from sys.columns where object_id=object_id('DST.ReturnOrderItem') and
				[name] = 'AdditionFactorInBaseCurrency_VatIneffective' and [is_nullable] = 1)
begin
	UPDATE DST.[ReturnOrderItem] SET [AdditionFactorInBaseCurrency_VatIneffective] = 0 where [AdditionFactorInBaseCurrency_VatIneffective] IS NULL
    Alter table DST.[ReturnOrderItem] ALTER COLUMN [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NOT NULL
end
GO

IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
		  WHERE OBJECT_ID=OBJECT_ID('DST.ReturnOrderItem') AND [name] = 'NetPrice')
BEGIN
	ALTER TABLE DST.ReturnOrderItem DROP COLUMN NetPrice
	ALTER TABLE DST.ReturnOrderItem ADD [NetPrice]  AS (((((([Quantity]*[Fee]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective) PERSISTED
END

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_DST_ReturnOrderItem')
ALTER TABLE [DST].[ReturnOrderItem] ADD  CONSTRAINT [PK_DST_ReturnOrderItem] PRIMARY KEY CLUSTERED 
(
	[ReturnOrderItemID] ASC
) 
ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If NOT Exists (select 1 from sys.objects where name = 'FK_ReturnOrderItem_ReturnOrderRef')
ALTER TABLE [DST].[ReturnOrderItem] ADD CONSTRAINT [FK_ReturnOrderItem_ReturnOrderRef] FOREIGN KEY([ReturnOrderRef])
REFERENCES [DST].[ReturnOrder] ([ReturnOrderID])
ON DELETE CASCADE

If NOT Exists (select 1 from sys.objects where name = 'FK_ReturnOrderItem_InvoiceItemRef')
ALTER TABLE [DST].[ReturnOrderItem] ADD CONSTRAINT [FK_ReturnOrderItem_InvoiceItemRef] FOREIGN KEY([InvoiceItemRef])
REFERENCES [SLS].[InvoiceItem] ([InvoiceItemID])

If NOT Exists (select 1 from sys.objects where name = 'FK_ReturnOrderItem_ItemRef')
ALTER TABLE [DST].[ReturnOrderItem] ADD CONSTRAINT [FK_ReturnOrderItem_ItemRef] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])

If NOT Exists (select 1 from sys.objects where name = 'FK_ReturnOrderItem_TracingRef')
ALTER TABLE [DST].[ReturnOrderItem] ADD CONSTRAINT [FK_ReturnOrderItem_TracingRef] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])

If NOT Exists (select 1 from sys.objects where name = 'FK_ReturnOrderItem_StockRef')
ALTER TABLE [DST].[ReturnOrderItem] ADD CONSTRAINT [FK_ReturnOrderItem_StockRef] FOREIGN KEY([StockRef])
REFERENCES [INV].[Stock] ([StockID])

If NOT Exists (select 1 from sys.objects where name = 'FK_ReturnOrderItem_DiscountReturnOrderItemRef')
ALTER TABLE [DST].[ReturnOrderItem] ADD CONSTRAINT [FK_ReturnOrderItem_DiscountReturnOrderItemRef] FOREIGN KEY([DiscountReturnOrderItemRef])
REFERENCES [DST].[ReturnOrderItem] ([ReturnOrderItemID])

If NOT Exists (select 1 from sys.objects where name = 'FK_ReturnOrderItem_ReturnReasonRef')
ALTER TABLE [DST].[ReturnOrderItem] ADD CONSTRAINT [FK_ReturnOrderItem_ReturnReasonRef] FOREIGN KEY([ReturnReasonRef])
REFERENCES [DST].[ReturnReason] ([ReturnReasonID])

GO
If NOT Exists (select 1 from sys.objects where name = 'FK_ReturnOrderItem_ProductPackRef_ProductPack')
ALTER TABLE [DST].[ReturnOrderItem] ADD CONSTRAINT [FK_ReturnOrderItem_ProductPackRef_ProductPack] FOREIGN KEY([ProductPackRef])
REFERENCES [sls].[ProductPack] ([ProductPackid])

GO

IF NOT EXISTS (select 1 from sys.objects where name = 'FK_ReturnOrderItem_ForDiscountInvoiceItemRef')
ALTER TABLE [DST].[ReturnOrderItem] ADD CONSTRAINT [FK_ReturnOrderItem_ForDiscountInvoiceItemRef] FOREIGN KEY([ForDiscountInvoiceItemRef])
REFERENCES [SLS].[InvoiceItem] ([InvoiceItemID])

GO
--<< DROP OBJECTS >>--
