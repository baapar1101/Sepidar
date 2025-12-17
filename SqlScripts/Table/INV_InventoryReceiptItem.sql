--<<FileName:INV_InventoryReceiptItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('INV.InventoryReceiptItem') Is Null
CREATE TABLE [INV].[InventoryReceiptItem](
	[InventoryReceiptItemID] [int] NOT NULL,
	[InventoryReceiptRef] [int] NOT NULL,
	[IsReturn] [bit] NOT NULL CONSTRAINT [DF_InventoryReceiptItem_IsReturn]  DEFAULT ((0)),
	[RowNumber] [int] NOT NULL,
	[Base] [int] NULL,
	[ReturnBase] [int] NULL,
	[ItemRef] [int] NOT NULL,
	[TracingRef] [int] NULL,
	[Quantity] [decimal](19, 4) NOT NULL,
	[SecondaryQuantity] [decimal](19, 4) NULL,
	[RemainingQuantity] [decimal](19, 4) NOT NULL CONSTRAINT [DF_InventoryReceiptItem_RemainingQuantity]  DEFAULT ((0)),
	[RemainingSecondaryQuantity] [decimal](19, 4) NULL,
	[CurrencyRef] [int] NULL,
	[CurrencyRate] [decimal](26,16) NULL,
	[CurrencyValue] [decimal](19, 4) NULL,
	[Price]  [decimal](19,4) NULL,
	[Tax] [decimal](19, 4) NULL,
	[TaxCurrencyValue] [decimal](19, 4) NULL,
	[Duty] [decimal](19, 4) NULL,
	[DutyCurrencyValue] [decimal](19, 4) NULL,
	[TransportPrice] [decimal](19, 4) NULL,
	[TransportTax] [decimal](19, 4) NULL,
	[TransportDuty] [decimal](19, 4) NULL,
	[TransportDescription] [nvarchar](250) NULL,
	[Description] [nvarchar](4000) NULL,
	[Description_En] [nvarchar](4000) NULL,
	[Version] [int] NOT NULL,
	[BasePurchaseInvoiceItemRef] [int] NULL,
	[BaseImportPurchaseInvoiceItemRef] [int] NULL,
	[ParityCheck] [nvarchar] (250)NULL,
	[ProductOrderRef] [int] NULL,
	[InventoryDeliveryItemRef] [int] NULL,
	[WeighingRef] [int] NULL,
	[ReturnedPrice]  [decimal](19,4) NULL,
	[AllotmenedOtherCostInBaseCurrency] [decimal](19,4) NULL,
	[ImportOrderFinalFee] [decimal](19,4) NULL,
	[ServiceInventoryPurchaseInvoiceRef] [int] NULL,
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND
				[Name] = 'BasePurchaseInvoiceItemRef')
BEGIN
	ALTER TABLE INV.InventoryReceiptItem ADD BasePurchaseInvoiceItemRef DECIMAL(19,4) NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND
				[Name] = 'AllotmenedOtherCostInBaseCurrency')
BEGIN
	ALTER TABLE INV.InventoryReceiptItem ADD AllotmenedOtherCostInBaseCurrency DECIMAL(19,4) NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND
				[Name] = 'ServiceInventoryPurchaseInvoiceRef')
BEGIN
	ALTER TABLE INV.InventoryReceiptItem ADD ServiceInventoryPurchaseInvoiceRef int NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND
				[Name] = 'ImportOrderFinalFee')
BEGIN
	ALTER TABLE INV.InventoryReceiptItem ADD ImportOrderFinalFee int NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND
				[Name] = 'BaseImportPurchaseInvoiceItemRef')
BEGIN
	ALTER TABLE INV.InventoryReceiptItem ADD BaseImportPurchaseInvoiceItemRef int NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND
				[Name] = 'WeighingRef')
BEGIN
	ALTER TABLE INV.InventoryReceiptItem ADD [WeighingRef] [int] NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND
				[Name] = 'TaxCurrencyValue')
BEGIN
	ALTER TABLE INV.InventoryReceiptItem ADD [TaxCurrencyValue] [decimal](19, 4) NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND
				[Name] = 'DutyCurrencyValue')
BEGIN
	ALTER TABLE INV.InventoryReceiptItem ADD [DutyCurrencyValue] [decimal](19, 4) NULL
END
GO


IF EXISTS (SELECT 1 FROM sys.columns c
			inner join sys.types t on c.system_Type_Id = t.system_type_id
			where c.object_id=object_id('INV.InventoryReceiptItem') AND
				c.[Name] = 'CurrencyRate' and 
				t.name = 'float'
)
BEGIN
	ALTER TABLE INV.InventoryReceiptItem Alter Column [CurrencyRate] [decimal](26,16) NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND
				[Name] = 'ParityCheck')
BEGIN
	ALTER TABLE INV.InventoryReceiptItem ADD ParityCheck [nvarchar] (250) NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND
				[Name] = 'ProductOrderRef')
BEGIN
	ALTER TABLE INV.InventoryReceiptItem ADD [ProductOrderRef] [int] NULL
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND
				[Name] = 'InventoryDeliveryItemRef')
BEGIN
	ALTER TABLE INV.InventoryReceiptItem ADD [InventoryDeliveryItemRef] [int] NULL
END

GO

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('INV.InventoryReceiptItem') and
				[name] = 'ColumnName')
begin
    Alter table INV.InventoryReceiptItem Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND
				[Name] = 'Price' AND is_computed=1)
BEGIN
	IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryReceiptItem') AND
				[Name] = 'Price2')
		ALTER TABLE INV.InventoryReceiptItem
			ADD Price2 [decimal](19, 4) NULL
END
GO

IF  EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryReceiptItem') AND [Name] = 'Price' ) AND
	EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryReceiptItem') AND [Name] = 'Price2')
BEGIN
	DECLARE @sql NVARCHAR(500)
	SET @sql = N'UPDATE INV.InventoryReceiptItem SET [Price2]=[Price]'
	EXEC sp_executesql @stmt=@sql
	--UPDATE INV.InventoryReceiptItem SET [Price2]=[Price]
	ALTER TABLE INV.InventoryReceiptItem DROP COLUMN Price
END
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryReceiptItem') AND [Name] = 'Price2')
	EXEC sp_rename 'INV.InventoryReceiptItem.Price2', 'Price', 'COLUMN'
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryReceiptItem') AND [Name] = 'Price')
	ALTER TABLE INV.InventoryReceiptItem ADD Price [decimal](19,4) NULL
GO

-- Change decimal digits of Quantity and SecondaryQuantity to 4
if exists(select 1 from sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND [Name] = 'Quantity' and precision <> 19 and scale <> 4)
BEGIN
   -- First, remove the Fee & ReturnedFee columns. there are is computed and is dependent on Quantity
	IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND [Name] = 'Fee')
		ALTER TABLE INV.InventoryReceiptItem DROP COLUMN [Fee]

	IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND [Name] = 'ReturnedFee')
		ALTER TABLE INV.InventoryReceiptItem DROP COLUMN [ReturnedFee]

	ALTER TABLE INV.InventoryReceiptItem ALTER COLUMN [Quantity] [decimal](19, 4) NOT NULL
END
GO
if exists(select 1 from sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND [Name] = 'SecondaryQuantity' and precision <> 19 and scale <> 4)
BEGIN
	ALTER TABLE INV.InventoryReceiptItem ALTER COLUMN [SecondaryQuantity] [decimal](19, 4) NULL
END
GO
if exists(select 1 from sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND [Name] = 'RemainingQuantity' and precision <> 19 and scale <> 4)
BEGIN
	ALTER TABLE INV.InventoryReceiptItem ALTER COLUMN [RemainingQuantity] [decimal](19, 4) NOT NULL
END
Go
if exists(select 1 from sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND [Name] = 'RemainingSecondaryQuantity' and precision <> 19 and scale <> 4)
BEGIN
	ALTER TABLE INV.InventoryReceiptItem ALTER COLUMN [RemainingSecondaryQuantity] [decimal](19, 4) NULL
END
Go
IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND [Name] = 'ReturnedPrice')
BEGIN
	ALTER TABLE INV.InventoryReceiptItem ADD [ReturnedPrice] [decimal](19,4) NULL
	execute ('
			 UPDATE A 
			 SET  ReturnedPrice = Price 
			 FROM INV.InventoryReceiptItem A
			 JOIN INV.InventoryReceipt     B ON A.InventoryReceiptRef = B.InventoryReceiptID
			 WHERE A.IsReturn = 1
			 AND   B.[Type]  <> 2 /*Production*/
            ')
	EXECUTE('
             UPDATE IRRI 
             SET  IRRI.CurrencyValue = ISNULL(Price,0) / ISNULL(CurrencyRate, 1) 
             FROM INV.InventoryReceiptItem IRRI
             JOIN INV.InventoryReceipt     IRR ON IRRI.InventoryReceiptRef = IRR.InventoryReceiptID
             WHERE IRRI.IsReturn = 1
               AND IRR.[Type]  <> 2 /*Production*/
			   AND IRRI.Price IS NOT NULL
               AND IRRI.CurrencyRef IS NOT NULL AND IRRI.CurrencyRate IS NOT NULL
            '
			)		
END
GO
/*------------------------------------------------------------------------------------------------------------------------------------*/
EXEC GNR.sp_recreate_computed_column '[INV].[InventoryReceiptItem]' , 'Fee' , 'decimal(19,4)' , 'CASE WHEN Quantity = 0 THEN 0 ELSE Price / Quantity END'
GO

DECLARE @Expression nvarchar(max)
SET @Expression = '
		CASE WHEN IsReturn = 1 THEN 
			ISNULL(Price, 0) + ISNULL(TransportPrice, 0) + ISNULL(AllotmenedOtherCostInBaseCurrency, 0)
		ELSE 
			ISNULL(Price, 0) + ISNULL(TransportPrice, 0) + ISNULL(AllotmenedOtherCostInBaseCurrency, 0) +ISNULL(Tax, 0) + ISNULL(Duty, 0) + ISNULL(TransportTax, 0) + ISNULL(TransportDuty, 0) 
		END
'
EXEC GNR.sp_recreate_computed_column '[INV].[InventoryReceiptItem]' , 'NetPrice'    , 'decimal(19,4)' , @Expression
GO

EXEC GNR.sp_recreate_computed_column '[INV].[InventoryReceiptItem]' , 'ReturnedFee' , 'decimal(19,4)' , 'CASE WHEN Quantity = 0 THEN 0 ELSE ReturnedPrice / Quantity END'
GO

DECLARE @Expression nvarchar(max)
SET @Expression = 
'
		CASE WHEN IsReturn = 1 THEN 
			ISNULL(ReturnedPrice  , 0) + ISNULL(TransportPrice , 0) +
			ISNULL(Tax            , 0) + ISNULL(Duty           , 0) +
			ISNULL(TransportTax   , 0) + ISNULL(TransportDuty  , 0)	+
			ISNULL(AllotmenedOtherCostInBaseCurrency, 0)
		END 
'
EXEC GNR.sp_recreate_computed_column '[INV].[InventoryReceiptItem]' , 'ReturnedNetPrice' , 'decimal(19,4)' , @Expression
GO
/*--UPDATE----------------------------------------------------------------------------------------------------------------------------*/
UPDATE  r SET
    TotalNetPrice         = sumNetPrice,
	TotalTransportPrice   = sumTransportPrice,
	TotalReturnedPrice    = sumReturnedPrice,
	TotalReturnedNetPrice = sumReturnedNetPrice
FROM INV.InventoryReceipt r		
LEFT JOIN
(
	SELECT  IRI.InventoryReceiptRef,
	        SUM(ISNULL(IRI.TransportPrice    ,0)) sumTransportPrice,
			SUM(ISNULL(IRI.NetPrice          ,0)) sumNetPrice,
			SUM(ISNULL(IRI.ReturnedPrice     ,0)) sumReturnedPrice,
			SUM(ISNULL(IRI.ReturnedNetPrice  ,0)) sumReturnedNetPrice
	FROM INV.InventoryReceiptItem IRI
	GROUP BY IRI.InventoryReceiptRef
)IRI ON IRI.InventoryReceiptRef = r.InventoryReceiptID
WHERE ISNULL(TotalNetPrice         , 0) <> ISNULL(sumNetPrice         , 0) 
OR    ISNULL(TotalTransportPrice   , 0) <> ISNULL(sumTransportPrice   , 0) 
OR    ISNULL(TotalReturnedPrice    , 0) <> ISNULL(sumReturnedPrice    , 0) 
OR    ISNULL(TotalReturnedNetPrice , 0) <> ISNULL(sumReturnedNetPrice , 0) 
GO

IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND [Name] = 'TaxCurrencyValue')
BEGIN
	execute ('
UPDATE IRI 
SET  TaxCurrencyValue =  ISNULL(Tax, 0) / ISNULL(CurrencyRate, 1)
FROM INV.InventoryReceiptItem  IRI
WHERE IRI.CurrencyRef IS NOT NULL 
	AND IRI.Tax IS NOT NULL 
	AND IRI.TaxCurrencyValue IS NULL
            ')		
END
GO

IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND [Name] = 'DutyCurrencyValue')
BEGIN
	execute ('
UPDATE IRI 
SET  DutyCurrencyValue =  ISNULL(Duty, 0) / ISNULL(CurrencyRate, 1)
FROM INV.InventoryReceiptItem  IRI
WHERE IRI.CurrencyRef IS NOT NULL 
	AND IRI.Duty IS NOT NULL 
	AND IRI.DutyCurrencyValue IS NULL
            ')		
END
GO

/*------------------------------------------------------------------------------------------------------------------------------------*/
IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND [Name] = 'Transporter')
BEGIN
    EXEC sp_rename 'INV.InventoryReceiptItem.Transporter', 'TransportDescription', 'COLUMN'
END
GO
--****************************************************************
IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND [Name] = 'ReceivedFee')
	ALTER TABLE INV.InventoryReceiptItem DROP COLUMN [ReceivedFee]
GO
IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND [Name] = 'ReceivedNetPrice')
  ALTER TABLE INV.InventoryReceiptItem DROP COLUMN [ReceivedNetPrice]
 GO
IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryReceiptItem') AND [Name] = 'ReceivedPrice')
  ALTER TABLE INV.InventoryReceiptItem DROP COLUMN [ReceivedPrice]
GO
--****************************************************************

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_InventoryReceiptItem')
ALTER TABLE [INV].[InventoryReceiptItem] ADD  CONSTRAINT [PK_InventoryReceiptItem] PRIMARY KEY CLUSTERED 
(
	[InventoryReceiptItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'DF_InventoryReceiptItem_RemainingQuantity')
	ALTER TABLE INV.InventoryReceiptItem
	ADD CONSTRAINT [DF_InventoryReceiptItem_RemainingQuantity]  DEFAULT ((0)) FOR RemainingQuantity
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'DF_InventoryReceiptItem_IsReturn')
	ALTER TABLE INV.InventoryReceiptItem
	ADD CONSTRAINT [DF_InventoryReceiptItem_IsReturn]  DEFAULT ((0)) FOR IsReturn
GO

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_InventoryReceiptRef')
	CREATE NONCLUSTERED INDEX IX_InventoryReceiptRef
		ON INV.InventoryReceiptItem (InventoryReceiptRef) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_InventoryReceiptItem_IsReturnItemRef')
	CREATE NONCLUSTERED INDEX IX_InventoryReceiptItem_IsReturnItemRef
ON [INV].[InventoryReceiptItem] ([IsReturn],[ItemRef])

GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_InventoryReceiptItem_WeighingRef')
	CREATE NONCLUSTERED INDEX IX_InventoryReceiptItem_WeighingRef
ON [INV].[InventoryReceiptItem] ([WeighingRef])
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_InventoryReceiptItem_ServiceInventoryPurchaseInvoiceRef')
	CREATE NONCLUSTERED INDEX IX_InventoryReceiptItem_ServiceInventoryPurchaseInvoiceRef
ON [INV].[InventoryReceiptItem] ([ServiceInventoryPurchaseInvoiceRef])
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_ParityCheck')
BEGIN
	IF NOT EXISTS(SELECT 1 WHERE cast(SERVERPROPERTY('ProductVersion') AS varchar) LIKE '1%')							
	BEGIN
		CREATE UNIQUE NONCLUSTERED INDEX [IX_ParityCheck] ON [INV].[InventoryReceiptItem]
		(
			[ParityCheck] ASC
		) 		
		ON [PRIMARY]
	END
	ELSE -- The Version  Of Sql Server Is 2008 Or More
	BEGIN
		Exec('CREATE UNIQUE NONCLUSTERED INDEX [IX_ParityCheck] ON [INV].[InventoryReceiptItem] 
				(
					[ParityCheck] ASC
				) 
			WHERE [ParityCheck] IS Not NULL
			ON [PRIMARY]')
	END
END
GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_InventoryReceiptItem_Currency')
ALTER TABLE [INV].[InventoryReceiptItem]  ADD  CONSTRAINT [FK_InventoryReceiptItem_Currency] FOREIGN KEY([CurrencyRef])
REFERENCES [GNR].[Currency] ([CurrencyID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_InventoryReceiptItem_InventoryReceipt')
ALTER TABLE [INV].[InventoryReceiptItem]  ADD  CONSTRAINT [FK_InventoryReceiptItem_InventoryReceipt] FOREIGN KEY([InventoryReceiptRef])
REFERENCES [INV].[InventoryReceipt] ([InventoryReceiptID])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_InventoryReceiptItem_Item')
ALTER TABLE [INV].[InventoryReceiptItem]  ADD  CONSTRAINT [FK_InventoryReceiptItem_Item] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_InventoryReceiptItem_ReturnBase')
ALTER TABLE [INV].[InventoryReceiptItem]  ADD  CONSTRAINT [FK_InventoryReceiptItem_ReturnBase] FOREIGN KEY([ReturnBase])
REFERENCES [INV].[InventoryReceiptItem] ([InventoryReceiptItemID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_InventoryReceiptItem_Tracing')
ALTER TABLE [INV].[InventoryReceiptItem]  ADD  CONSTRAINT [FK_InventoryReceiptItem_Tracing] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects where name = 'FK_InventoryReceiptItem_ProductOrder')
ALTER TABLE [INV].[InventoryReceiptItem]  ADD  CONSTRAINT [FK_InventoryReceiptItem_ProductOrder] FOREIGN KEY([ProductOrderRef])
REFERENCES [WKO].[ProductOrder] ([ProductOrderID])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE Name= 'FK_InventoryReceiptItem_InventoryPurchaseInvoiceItem')
ALTER TABLE INV.InventoryReceiptItem ADD CONSTRAINT FK_InventoryReceiptItem_InventoryPurchaseInvoiceItem FOREIGN KEY
	( BasePurchaseInvoiceItemRef ) REFERENCES INV.InventoryPurchaseInvoiceItem ( InventoryPurchaseInvoiceItemID )
	 ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE Name= 'FK_InventoryReceiptItem_ImportPurchaseInvoiceItem')
ALTER TABLE INV.InventoryReceiptItem ADD CONSTRAINT FK_InventoryReceiptItem_ImportPurchaseInvoiceItem FOREIGN KEY
	( BaseImportPurchaseInvoiceItemRef ) REFERENCES POM.PurchaseInvoiceItem ( PurchaseInvoiceItemID )
	 ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE Name= 'FK_InventoryReceiptItem_ServiceInventoryPurchaseInvoiceRef')
ALTER TABLE INV.InventoryReceiptItem ADD CONSTRAINT FK_InventoryReceiptItem_ServiceInventoryPurchaseInvoiceRef FOREIGN KEY
	( ServiceInventoryPurchaseInvoiceRef ) REFERENCES INV.InventoryPurchaseInvoiceItem ( InventoryPurchaseInvoiceItemID )
	 ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE Name= 'FK_InventoryReceiptItem_InventoryDeliveryItem')
ALTER TABLE INV.InventoryReceiptItem ADD CONSTRAINT FK_InventoryReceiptItem_InventoryDeliveryItem FOREIGN KEY
	( InventoryDeliveryItemRef ) REFERENCES INV.InventoryDeliveryItem ( InventoryDeliveryItemID )
GO

--<< DROP OBJECTS >>--
