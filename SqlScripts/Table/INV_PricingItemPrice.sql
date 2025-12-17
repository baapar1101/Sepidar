--<<FileName:INV_PricingItemPrice.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('INV.PricingItemPrice') Is Null
CREATE TABLE [INV].[PricingItemPrice](
	[PricingItemPriceID] [int] NOT NULL,
	[InventoryPricingRef] [int] NOT NULL,
	[ItemRef] [int] NOT NULL,
	[Quantity] [decimal](19, 4) NOT NULL,
	[TotalPrice] [decimal](19, 4) NOT NULL,
	[Date] [datetime] NOT NULL,
	[Version] [int] NOT NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = object_id('INV.PricingItemPrice' ) AND
				[name] = 'Date')
BEGIN
	ALTER TABLE INV.PricingItemPrice
		ADD [Date] [datetime] NULL
END

GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id = object_id('INV.PricingItemPrice' ) AND
				[name] = 'Date' AND is_nullable=1)
BEGIN
	UPDATE IP SET IP.Date = P.EndDate FROM
		INV.PricingItemPrice IP INNER JOIN INV.InventoryPricing P ON
		IP.InventoryPricingRef=P.InventoryPricingID

	ALTER TABLE INV.PricingItemPrice
		ALTER COLUMN Date datetime NOT NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.PricingItemPrice' ) AND
				[name] = 'TotalPrice')
	ALTER TABLE INV.PricingItemPrice ADD TotalPrice [decimal](19,4) NULL

GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.PricingItemPrice' ) AND
				[name] = 'TotalPrice' AND is_nullable=1)
BEGIN
	IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.PricingItemPrice') AND
			[name] = 'Price')
		EXEC sp_executesql N'UPDATE INV.PricingItemPrice SET TotalPrice=ROUND(Price*Quantity,0)'
	ELSE
		UPDATE INV.PricingItemPrice SET TotalPrice=0 WHERE TotalPrice IS NULL
END

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.PricingItemPrice' ) AND
				[name] = 'TotalPrice' AND is_nullable=1)
	ALTER TABLE INV.PricingItemPrice ALTER COLUMN TotalPrice [decimal](19,4) NOT NULL

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.PricingItemPrice') AND
		[name] = 'Price')
	ALTER TABLE INV.PricingItemPrice DROP COLUMN Price


--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('INV.PricingItemPrice') and
				[name] = 'ColumnName')
begin
    Alter table INV.PricingItemPrice Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

ALTER TABLE INV.PricingItemPrice ALTER COLUMN [Quantity] [decimal](19, 4) NOT NULL

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_InventoryPricingItem')
ALTER TABLE [INV].[PricingItemPrice] ADD  CONSTRAINT [PK_InventoryPricingItem] PRIMARY KEY CLUSTERED 
(
	[PricingItemPriceID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_InventoryPricingItem_InventoryPricing')
ALTER TABLE [INV].[PricingItemPrice]  ADD  CONSTRAINT [FK_InventoryPricingItem_InventoryPricing] FOREIGN KEY([InventoryPricingRef])
REFERENCES [INV].[InventoryPricing] ([InventoryPricingID])
ON DELETE CASCADE

GO
IF EXISTS (SELECT 1 FROM sys.objects WHERE Name = 'FK_InventoryPricingItem_Item' )
	ALTER TABLE INV.PricingItemPrice
	DROP CONSTRAINT FK_InventoryPricingItem_Item
GO

If not Exists (select 1 from sys.objects where name = 'FK_InventoryPricingItem_Item')
	ALTER TABLE INV.PricingItemPrice ADD CONSTRAINT FK_InventoryPricingItem_Item FOREIGN KEY ( ItemRef)
	REFERENCES INV.Item ( ItemID ) ON UPDATE  NO ACTION  ON DELETE  CASCADE 

GO

--<< DROP OBJECTS >>--
