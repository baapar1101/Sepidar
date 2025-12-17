--<<FileName:SLS_ReturnedInvoiceItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('SLS.ReturnedInvoiceItem') Is Null
CREATE TABLE [SLS].[ReturnedInvoiceItem](
	[ReturnedInvoiceItemID] [int] NOT NULL,
	[ReturnedInvoiceRef] [int] NOT NULL,
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
	[CustomerDiscount][decimal](19,4) NOT NULL,
	[CustomerDiscountRate] [decimal](5, 2) NULL,
	[PriceInfoPriceDiscount] [decimal](19,4) NOT NULL,
	[PriceInfoPercentDiscount] [decimal](19,4) NOT NULL,
	[AggregateAmountDiscountRate] [decimal](5, 2)  NOT NULL DEFAULT 0, 
	[AggregateAmountPriceDiscount] [decimal](19, 4) NOT NULL DEFAULT 0, 
	[AggregateAmountPercentDiscount] [decimal](19,4) NOT NULL DEFAULT 0, 	
	[Addition] [decimal](19, 4) NULL,
	[AdditionInBaseCurrency]  [decimal](19, 4) NULL,
	[Tax] [decimal](19, 4) NULL,
	[TaxInBaseCurrency] [decimal](19, 4) NULL,
	[Duty] [decimal](19, 4) NULL,
	[DutyInBaseCurrency] [decimal](19, 4) NULL,
	[AdditionFactor_VatEffective] [decimal](19, 4) NOT NULL,
	[AdditionFactorInBaseCurrency_VatEffective] [decimal](19, 4) NOT NULL,
	[AdditionFactor_VatIneffective] [decimal](19, 4) NOT NULL,
	[AdditionFactorInBaseCurrency_VatIneffective] [decimal](19, 4) NOT NULL,
	[NetPrice]  AS (((((([Quantity]*[Fee]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective) PERSISTED,
	[NetPriceInBaseCurrency]  [decimal](19, 4) NOT NULL,
	[Rate] [decimal](26, 16) NULL,
	[InvoiceItemRef] [int] NULL,
	[ReturnOrderItemRef] [int] NULL,
	[Description] NVARCHAR(255) NULL,
	[Description_En] NVARCHAR(255) NULL,
	[DiscountReturnedInvoiceItemRef] INT NULL,
	[ProductPackRef] int null,
	[ProductPackQuantity] [decimal](19, 4)  NULL,
	[ReturnReasonRef] INT NULL,
	[ForDiscountInvoiceItemRef] [int] NULL,
	[ForDiscountReturnedOrderItemRef] [int] NULL,
	[IsAggregateDiscountInvoiceItem] [bit] NOT NULL DEFAULT (0)
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.ReturnedInvoiceItem') AND
				[name] = 'ForDiscountReturnedOrderItemRef')
BEGIN
    ALTER TABLE SLS.ReturnedInvoiceItem Add [ForDiscountReturnedOrderItemRef] INT NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('SLS.ReturnedInvoiceItem') AND
	[name]='IsAggregateDiscountInvoiceItem')
BEGIN
	ALTER TABLE SLS.ReturnedInvoiceItem ADD [IsAggregateDiscountInvoiceItem] bit NOT NULL DEFAULT (0)
END
GO

if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
				[name] = 'ProductPackRef')
begin
    Alter table SLS.ReturnedInvoiceItem Add [ProductPackRef]  int NULL 
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
				[name] = 'ProductPackQuantity')
begin
    Alter table SLS.ReturnedInvoiceItem Add [ProductPackQuantity] [decimal](19, 4) NULL 
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
				[name] = 'AggregateAmountDiscountRate')
begin
    Alter table SLS.ReturnedInvoiceItem Add [AggregateAmountDiscountRate] [decimal](5, 2)  NOT NULL DEFAULT 0 
	
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
				[name] = 'AggregateAmountPriceDiscount')
begin
    Alter table SLS.ReturnedInvoiceItem Add [AggregateAmountPriceDiscount] [decimal](19, 4) NOT NULL DEFAULT 0	
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
				[name] = 'AggregateAmountPercentDiscount')
begin
    Alter table SLS.ReturnedInvoiceItem Add [AggregateAmountPercentDiscount] [decimal](19,4) NOT NULL DEFAULT 0
end
GO
--<<Sample>>--
if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
				[name] = 'Description')
begin
    Alter table SLS.ReturnedInvoiceItem Add Description NVARCHAR(255) NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
				[name] = 'Description_En')
begin
    Alter table SLS.ReturnedInvoiceItem Add Description_En NVARCHAR(255) NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
				[name] = 'DiscountReturnedInvoiceItemRef')
begin
    Alter table SLS.ReturnedInvoiceItem Add DiscountReturnedInvoiceItemRef INT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
				[name] = 'PriceInfoPriceDiscount')
begin
    Alter table SLS.ReturnedInvoiceItem Add [PriceInfoPriceDiscount] [decimal](19, 4) NOT NULL DEFAULT 0
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
				[name] = 'PriceInfoPercentDiscount')
begin
    Alter table SLS.ReturnedInvoiceItem Add [PriceInfoPercentDiscount] [decimal](19, 4) NOT NULL DEFAULT 0
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
				[name] = 'CustomerDiscount')
begin
    Alter table SLS.ReturnedInvoiceItem Add [CustomerDiscount] [decimal](19, 4) NULL 
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
				[name] = 'ReturnOrderItemRef')
begin
    Alter table SLS.ReturnedInvoiceItem Add [ReturnOrderItemRef] [int] NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
				[name] = 'ReturnReasonRef')
begin
    Alter table SLS.ReturnedInvoiceItem Add [ReturnReasonRef] INT NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
				[name] = 'ForDiscountInvoiceItemRef')
begin
    Alter table SLS.ReturnedInvoiceItem Add [ForDiscountInvoiceItemRef] INT NULL
end
GO

if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
				[name] = 'AdditionFactor_VatEffective')
begin
    Alter table SLS.ReturnedInvoiceItem Add [AdditionFactor_VatEffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.[ReturnedInvoiceItem] SET AdditionFactor_VatEffective=0')
	Alter table SLS.ReturnedInvoiceItem ALTER COLUMN [AdditionFactor_VatEffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
				[name] = 'AdditionFactorInBaseCurrency_VatEffective')
begin
    Alter table SLS.ReturnedInvoiceItem Add [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.[ReturnedInvoiceItem] SET AdditionFactorInBaseCurrency_VatEffective=0')
	Alter table SLS.ReturnedInvoiceItem ALTER COLUMN [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
				[name] = 'AdditionFactor_VatIneffective')
begin
    Alter table SLS.ReturnedInvoiceItem Add [AdditionFactor_VatIneffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.[ReturnedInvoiceItem] SET AdditionFactor_VatIneffective=0')
	Alter table SLS.ReturnedInvoiceItem ALTER COLUMN [AdditionFactor_VatIneffective] [decimal](19,4) NOT NULL
end
GO
if not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
				[name] = 'AdditionFactorInBaseCurrency_VatIneffective')
begin
    Alter table SLS.ReturnedInvoiceItem Add [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NULL
	EXEC('UPDATE SLS.[ReturnedInvoiceItem] SET AdditionFactorInBaseCurrency_VatIneffective=0')
	Alter table SLS.ReturnedInvoiceItem ALTER COLUMN [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NOT NULL
end
GO


--<< ALTER COLUMNS >>--
IF EXISTS(SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID=OBJECT_ID('SLS.ReturnedInvoiceItem') AND
				[name] = 'NetPriceInBaseCurrency' AND is_Computed = 1)
BEGIN
	if  exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
					[name] = 'PriceInBaseCurrency')
	ALTER TABLE SLS.ReturnedInvoiceItem DROP COLUMN PriceInBaseCurrency
	if  exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
					[name] = 'DiscountInBaseCurrency')
	ALTER TABLE SLS.ReturnedInvoiceItem DROP COLUMN DiscountInBaseCurrency
	if  exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
					[name] = 'AdditionInBaseCurrency')
	ALTER TABLE SLS.ReturnedInvoiceItem DROP COLUMN AdditionInBaseCurrency
	if  exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
					[name] = 'TaxInBaseCurrency')
	ALTER TABLE SLS.ReturnedInvoiceItem DROP COLUMN TaxInBaseCurrency
	if  exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
					[name] = 'DutyInBaseCurrency')
	ALTER TABLE SLS.ReturnedInvoiceItem DROP COLUMN DutyInBaseCurrency
	if  exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
					[name] = 'NetPriceInBaseCurrency')
	ALTER TABLE SLS.ReturnedInvoiceItem DROP COLUMN NetPriceInBaseCurrency

	if  not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
					[name] = 'PriceInBaseCurrency')
	ALTER TABLE SLS.ReturnedInvoiceItem ADD PriceInBaseCurrency DECIMAL(19,4)

	if  not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
					[name] = 'DiscountInBaseCurrency')
	ALTER TABLE SLS.ReturnedInvoiceItem ADD DiscountInBaseCurrency DECIMAL(19,4)

	if  not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
					[name] = 'AdditionInBaseCurrency')
	ALTER TABLE SLS.ReturnedInvoiceItem ADD AdditionInBaseCurrency DECIMAL(19,4)

	if  not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
					[name] = 'TaxInBaseCurrency')
	ALTER TABLE SLS.ReturnedInvoiceItem ADD TaxInBaseCurrency DECIMAL(19,4)

	if  not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
					[name] = 'DutyInBaseCurrency')
	ALTER TABLE SLS.ReturnedInvoiceItem ADD DutyInBaseCurrency DECIMAL(19,4)

	if  not exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
					[name] = 'NetPriceInBaseCurrency')
	ALTER TABLE SLS.ReturnedInvoiceItem ADD NetPriceInBaseCurrency DECIMAL(19,4)
END

IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.ReturnedInvoiceItem') AND
				[name] = 'Quantity' AND scale=3)
BEGIN
	if  exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and [name] = 'NetPrice')
	ALTER TABLE SLS.ReturnedInvoiceItem DROP COLUMN [NetPrice]

	if  exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and [name] = 'Quantity')
	ALTER TABLE SLS.ReturnedInvoiceItem ALTER COLUMN [Quantity] [decimal](19, 4) NOT NULL
	
	if NOT exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and [name] = 'NetPrice')
	ALTER TABLE SLS.ReturnedInvoiceItem ADD
		[NetPrice]  AS (((([Quantity]*[Fee]+[Tax])+[Duty])+[Addition])-[Discount]) PERSISTED
END

IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.ReturnedInvoiceItem') AND
				[name] = 'SecondaryQuantity' AND scale=3)
	ALTER TABLE SLS.ReturnedInvoiceItem ALTER COLUMN [SecondaryQuantity] [decimal](19, 4) NULL


IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.ReturnedInvoiceItem') AND
				[name] = 'Discount' AND is_nullable = 1)
BEGIN 
	if  exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and [name] = 'NetPrice')
	ALTER TABLE SLS.ReturnedInvoiceItem DROP COLUMN [NetPrice]
	
	IF NOT EXISTS (
					select *
					from sys.all_columns c 
						join sys.tables t on t.object_id = c.object_id
						join sys.schemas s on s.schema_id = t.schema_id
						join sys.default_constraints d on c.default_object_id = d.object_id
					where t.name = 'ReturnedInvoiceItem' and 
						  c.name = 'Discount' and 
						  s.name = 'SLS' and
						  d.name = 'ReturnedInvoiceItem_Discount_Default')
	ALTER TABLE SLS.ReturnedInvoiceItem ADD CONSTRAINT ReturnedInvoiceItem_Discount_Default DEFAULT 0 for Discount

	ALTER TABLE SLS.ReturnedInvoiceItem ALTER COLUMN [Discount] [decimal](19, 4) NOT NULL

	if  NOT exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and [name] = 'NetPrice')
	ALTER TABLE SLS.ReturnedInvoiceItem ADD
		[NetPrice]  AS (((([Quantity]*[Fee]+[Tax])+[Duty])+[Addition])-[Discount]) PERSISTED
END

IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.ReturnedInvoiceItem') AND
				[name] = 'DiscountInBaseCurrency' AND is_nullable = 1)
BEGIN
	UPDATE SLS.ReturnedInvoiceItem
	SET DiscountInBaseCurrency = 0
	WHERE DiscountInBaseCurrency IS NULL

	ALTER TABLE SLS.ReturnedInvoiceItem ALTER COLUMN [DiscountInBaseCurrency]  [decimal](19, 4) NOT NULL
END

IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.ReturnedInvoiceItem') AND
				[name] = 'PriceInfoDiscountRate' AND is_nullable = 1)
BEGIN
	UPDATE SLS.ReturnedInvoiceItem
	SET PriceInfoDiscountRate = 0
	WHERE PriceInfoDiscountRate IS NULL

	ALTER TABLE SLS.ReturnedInvoiceItem ALTER COLUMN [PriceInfoDiscountRate] [decimal](5, 2) NOT NULL
END

IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.ReturnedInvoiceItem') AND
				[name] = 'PriceInfoPriceDiscount' AND is_nullable = 1)
BEGIN
UPDATE SLS.ReturnedInvoiceItem
	SET PriceInfoPriceDiscount = 0
	WHERE PriceInfoPriceDiscount IS NULL

	ALTER TABLE SLS.ReturnedInvoiceItem ALTER COLUMN [PriceInfoPriceDiscount] [decimal](19, 4) NOT NULL
END

IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.ReturnedInvoiceItem') AND
				[name] = 'PriceInfoPercentDiscount' AND is_nullable = 1)
BEGIN
	UPDATE SLS.ReturnedInvoiceItem
	SET PriceInfoPercentDiscount = 0
	WHERE PriceInfoPercentDiscount IS NULL

	ALTER TABLE SLS.ReturnedInvoiceItem ALTER COLUMN [PriceInfoPercentDiscount] [decimal](19,4) NOT NULL 
END

IF EXISTS (SELECT 1 FROM SYS.Columns WHERE object_id=object_id('SLS.ReturnedInvoiceItem') AND
				[name] = 'CustomerDiscountRate' AND is_nullable = 1)
BEGIN
	UPDATE SLS.ReturnedInvoiceItem
	SET CustomerDiscountRate = 0
	WHERE CustomerDiscountRate IS NULL

	ALTER TABLE SLS.ReturnedInvoiceItem ALTER COLUMN [CustomerDiscountRate] [decimal](5,2) NOT NULL 
END

if exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
				[name] = 'AdditionFactor_VatEffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[ReturnedInvoiceItem] SET [AdditionFactor_VatEffective] = 0 where [AdditionFactor_VatEffective] IS NULL

	begin transaction
	IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
				WHERE OBJECT_ID=OBJECT_ID('SLS.ReturnedInvoiceItem') AND [name] = 'NetPrice')
	BEGIN
		ALTER TABLE SLS.[ReturnedInvoiceItem] DROP COLUMN NetPrice
	END

	Alter table SLS.[ReturnedInvoiceItem] ALTER COLUMN [AdditionFactor_VatEffective] [decimal](19,4) NOT NULL
	ALTER TABLE SLS.[ReturnedInvoiceItem] ADD [NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective)
	commit transaction
end
GO

if exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
				[name] = 'AdditionFactorInBaseCurrency_VatEffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[ReturnedInvoiceItem] SET [AdditionFactorInBaseCurrency_VatEffective] = 0 where [AdditionFactorInBaseCurrency_VatEffective] IS NULL
    Alter table SLS.[ReturnedInvoiceItem] ALTER COLUMN [AdditionFactorInBaseCurrency_VatEffective] [decimal](19,4) NOT NULL
end
GO

if exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
				[name] = 'AdditionFactor_VatIneffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[ReturnedInvoiceItem] SET [AdditionFactor_VatIneffective] = 0 where [AdditionFactor_VatIneffective] IS NULL

	begin transaction
	
	IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
				WHERE OBJECT_ID=OBJECT_ID('SLS.ReturnedInvoiceItem') AND [name] = 'NetPrice')
	BEGIN
		ALTER TABLE SLS.[ReturnedInvoiceItem] DROP COLUMN NetPrice
	END

	Alter table SLS.[ReturnedInvoiceItem] ALTER COLUMN [AdditionFactor_VatIneffective] [decimal](19,4) NOT NULL
	ALTER TABLE SLS.[ReturnedInvoiceItem] ADD [NetPrice]  AS (((((([Price]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective)

	commit transaction
end
GO

if exists (select 1 from sys.columns where object_id=object_id('SLS.ReturnedInvoiceItem') and
				[name] = 'AdditionFactorInBaseCurrency_VatIneffective' and [is_nullable] = 1)
begin
	UPDATE SLS.[ReturnedInvoiceItem] SET [AdditionFactorInBaseCurrency_VatIneffective] = 0 where [AdditionFactorInBaseCurrency_VatIneffective] IS NULL
    Alter table SLS.[ReturnedInvoiceItem] ALTER COLUMN [AdditionFactorInBaseCurrency_VatIneffective] [decimal](19,4) NOT NULL
end
GO

IF EXISTS(SELECT 1 FROM SYS.COLUMNS 
		  WHERE OBJECT_ID=OBJECT_ID('SLS.ReturnedInvoiceItem') AND [name] = 'NetPrice')
BEGIN
	ALTER TABLE SLS.ReturnedInvoiceItem DROP COLUMN NetPrice
	ALTER TABLE SLS.ReturnedInvoiceItem ADD [NetPrice]  AS (((((([Quantity]*[Fee]+[Tax])+[Duty])+[Addition])-[Discount])+AdditionFactor_VatEffective)+AdditionFactor_VatIneffective) PERSISTED
END

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_ReturnedInvoiceItem')
ALTER TABLE [SLS].[ReturnedInvoiceItem] ADD  CONSTRAINT [PK_ReturnedInvoiceItem] PRIMARY KEY CLUSTERED 
(
	[ReturnedInvoiceItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--
IF NOT EXISTS (
select *
from sys.all_columns c 
	join sys.tables t on t.object_id = c.object_id
    join sys.schemas s on s.schema_id = t.schema_id
    join sys.default_constraints d on c.default_object_id = d.object_id
where t.name = 'ReturnedInvoiceItem' and 
	  c.name = 'PriceInfoPriceDiscount' and 
	  s.name = 'SLS')
BEGIN
	ALTER TABLE [SLS].[ReturnedInvoiceItem] ADD  DEFAULT ((0)) FOR [PriceInfoPriceDiscount]
END

IF NOT EXISTS (
select *
from sys.all_columns c 
	join sys.tables t on t.object_id = c.object_id
    join sys.schemas s on s.schema_id = t.schema_id
    join sys.default_constraints d on c.default_object_id = d.object_id
where t.name = 'ReturnedInvoiceItem' and 
	  c.name = 'PriceInfoPercentDiscount' and 
	  s.name = 'SLS')
BEGIN
	ALTER TABLE [SLS].[ReturnedInvoiceItem] ADD  DEFAULT ((0)) FOR [PriceInfoPercentDiscount]
END
--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_ReturnedInvoiceItem_InvoiceItemRef')
ALTER TABLE [SLS].[ReturnedInvoiceItem]  ADD  CONSTRAINT [FK_ReturnedInvoiceItem_InvoiceItemRef] FOREIGN KEY([InvoiceItemRef])
REFERENCES [SLS].[InvoiceItem] ([InvoiceItemID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReturnedInvoiceItem_ItemRef')
ALTER TABLE [SLS].[ReturnedInvoiceItem]  ADD  CONSTRAINT [FK_ReturnedInvoiceItem_ItemRef] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReturnedInvoiceItem_ReturnedInvoiceRef')
ALTER TABLE [SLS].[ReturnedInvoiceItem]  ADD  CONSTRAINT [FK_ReturnedInvoiceItem_ReturnedInvoiceRef] FOREIGN KEY([ReturnedInvoiceRef])
REFERENCES [SLS].[ReturnedInvoice] ([ReturnedInvoiceId])
ON UPDATE CASCADE
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReturnedInvoiceItem_StockRef')
ALTER TABLE [SLS].[ReturnedInvoiceItem]  ADD  CONSTRAINT [FK_ReturnedInvoiceItem_StockRef] FOREIGN KEY([StockRef])
REFERENCES [INV].[Stock] ([StockID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReturnedInvoiceItem_TracingRef')
ALTER TABLE [SLS].[ReturnedInvoiceItem]  ADD  CONSTRAINT [FK_ReturnedInvoiceItem_TracingRef] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])

GO

If not Exists (select 1 from sys.objects where name = 'FK_ReturnedInvoiceItem_DiscountReturnedInvoiceItemRef')
ALTER TABLE [SLS].[ReturnedInvoiceItem]  ADD  CONSTRAINT [FK_ReturnedInvoiceItem_DiscountReturnedInvoiceItemRef] FOREIGN KEY([DiscountReturnedInvoiceItemRef])
REFERENCES [SLS].[ReturnedInvoiceItem] ([ReturnedInvoiceItemId])

GO

If not Exists (select 1 from sys.objects where name = 'FK_ReturnedInvoiceItem_ReturnOrderItemRef')
ALTER TABLE [SLS].[ReturnedInvoiceItem]  ADD  CONSTRAINT [FK_ReturnedInvoiceItem_ReturnOrderItemRef] FOREIGN KEY([ReturnOrderItemRef])
REFERENCES [DST].[ReturnOrderItem] ([ReturnOrderItemID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_ReturnedInvoiceItem_ProductPackRef_ProductPack')
ALTER TABLE [SLS].[ReturnedInvoiceItem]  ADD  CONSTRAINT [FK_ReturnedInvoiceItem_ProductPackRef_ProductPack] FOREIGN KEY([ProductPackRef])
REFERENCES [sls].[ProductPack] ([ProductPackid])

GO
If NOT Exists (select 1 from sys.objects where name = 'FK_ReturnedInvoiceItem_ReturnReasonRef')
ALTER TABLE [SLS].[ReturnedInvoiceItem] ADD CONSTRAINT [FK_ReturnedInvoiceItem_ReturnReasonRef] FOREIGN KEY([ReturnReasonRef])
REFERENCES [DST].[ReturnReason] ([ReturnReasonID])

GO

If NOT Exists (select 1 from sys.objects where name = 'FK_ReturnedInvoiceItem_ForDiscountInvoiceItemRef')
ALTER TABLE [SLS].[ReturnedInvoiceItem] ADD CONSTRAINT [FK_ReturnedInvoiceItem_ForDiscountInvoiceItemRef] FOREIGN KEY([ForDiscountInvoiceItemRef])
REFERENCES [SLS].[InvoiceItem] ([InvoiceItemID])

GO

IF NOT EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE NAME = 'FK_ReturnedInvoiceItem_ForDiscountReturnedOrderItemRef')
ALTER TABLE [SLS].[ReturnedInvoiceItem]
ADD CONSTRAINT [FK_ReturnedInvoiceItem_ForDiscountReturnedOrderItemRef] FOREIGN KEY([ForDiscountReturnedOrderItemRef])
REFERENCES [DST].[ReturnOrderItem] ([ReturnOrderItemID])

GO

--<< DROP OBJECTS >>--
