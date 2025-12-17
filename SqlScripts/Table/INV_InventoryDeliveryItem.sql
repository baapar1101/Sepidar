                                                                                                                                                                                                                                                                                                                           --<<FileName:INV_InventoryDeliveryItem.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('INV.InventoryDeliveryItem') Is Null
CREATE TABLE [INV].[InventoryDeliveryItem](
	[InventoryDeliveryItemID] [int] NOT NULL,
	[InventoryDeliveryRef] [int] NOT NULL,
	[IsReturn] [bit] NOT NULL CONSTRAINT [DF_InventoryDeliveryItem_IsReturn]  DEFAULT ((0)),
	[RowNumber] [int] NOT NULL,
	[BaseInvoiceItem] [int] NULL,
	[BaseInventoryDeliveryItem] [int] NULL,
	[BaseReturnedInvoiceItem] [int] NULL,
	[ItemRequestItemRef] [int] NULL,
	[ItemDescription] [nvarchar](500) NULL,
	[QuotationItemRef] [int] NULL,
	[ItemRef] [int] NOT NULL,
	[TracingRef] [int] NULL,
	[Quantity] [decimal](19, 4) NOT NULL,
	[SecondaryQuantity] [decimal](19, 4) NULL,
	[RemainingQuantity] [decimal](19, 4) NOT NULL CONSTRAINT [DF_InventoryDeliveryItem_RemainingQuantity]  DEFAULT ((0)),
	[RemainingSecondaryQuantity] [decimal](19, 4) NULL,
	[SLAccountRef] [int] NULL,
	[Fee] AS CAST( (CASE WHEN [Quantity]=(0) THEN (0) ELSE [Price]/[Quantity] END) AS decimal(19,4) ) PERSISTED,
	[Price] [decimal](19, 4) NULL,
	[Description] [nvarchar](4000) NULL,
	[Description_En] [nvarchar](4000) NULL,
	[Version] [int] NOT NULL,
	[ProductOrderRef] [int] NULL,
	[ParityCheck] [nvarchar] (250)NULL,
	[WeighingRef] [int] NULL
) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('INV.InventoryDeliveryItem') and
				[name] = 'ColumnName')
begin
    Alter table INV.InventoryDeliveryItem Add ColumnName DataType Nullable
end
GO*/

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryDeliveryItem') AND
				[Name] = 'ParityCheck')
BEGIN
	ALTER TABLE INV.InventoryDeliveryItem ADD ParityCheck [nvarchar] (250) NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryDeliveryItem') AND
				[Name] = 'QuotationItemRef')
BEGIN
	ALTER TABLE INV.InventoryDeliveryItem ADD [QuotationItemRef] [int] NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryDeliveryItem') AND
				[Name] = 'WeighingRef')
BEGIN
	ALTER TABLE INV.InventoryDeliveryItem ADD [WeighingRef] [int] NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryDeliveryItem') AND
				[Name] = 'ItemRequestItemRef')
BEGIN
	ALTER TABLE INV.InventoryDeliveryItem ADD [ItemRequestItemRef] [int] NULL
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryDeliveryItem') AND
				[Name] = 'ItemDescription')
BEGIN
	ALTER TABLE INV.InventoryDeliveryItem ADD ItemDescription [nvarchar] (500) NULL
END
GO

--<< ALTER COLUMNS >>--


-- Only drop column when it is computed and the expression does not match the required one.
IF EXISTS (
	SELECT 1
	FROM sys.columns c INNER JOIN sys.computed_columns cc
		ON (c.object_id = cc.object_id and c.name = cc.name )
	WHERE c.object_id=object_id('INV.InventoryDeliveryItem') AND
		c.[Name] = 'Fee' AND c.is_computed=1 AND
		(definition<>'(CONVERT([decimal](19,4),case when [Quantity]=(0) then (0) else [Price]/[Quantity] end,0))' OR is_persisted<>1))
BEGIN
	ALTER TABLE INV.InventoryDeliveryItem
		DROP COLUMN Fee
END

IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryDeliveryItem') AND
				[Name] = 'Price' AND is_computed=1)
BEGIN
	IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryDeliveryItem') AND
				[Name] = 'Price2')
		ALTER TABLE INV.InventoryDeliveryItem
			ADD Price2 [decimal](19, 4) NULL
END
GO
IF
	EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryDeliveryItem') AND
		[Name] = 'Price') AND
	EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryDeliveryItem') AND
		[Name] = 'Price2')
BEGIN
	DECLARE @sql NVARCHAR(500)
	SET @sql = N'UPDATE INV.InventoryDeliveryItem SET [Price2]=[Price]'
	EXEC sp_executesql @stmt=@sql
	--UPDATE INV.InventoryDeliveryItem SET [Price2]=[Price]
	ALTER TABLE INV.InventoryDeliveryItem
		DROP COLUMN Price
END
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryDeliveryItem') AND
		[Name] = 'Price2')
	EXEC sp_rename 'INV.InventoryDeliveryItem.Price2', 'Price', 'COLUMN'

GO
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('INV.InventoryDeliveryItem') AND
		[Name] = 'Price')
	ALTER TABLE INV.InventoryDeliveryItem
		ADD Price [decimal](19,4) NULL

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = object_id('INV.InventoryDeliveryItem') AND
				[Name] = 'ProductOrderRef')
	ALTER TABLE INV.InventoryDeliveryItem ADD [ProductOrderRef] [int] NULL

GO

-- Drop column if it is not computed.
IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryDeliveryItem') AND
				[Name] = 'Fee' AND is_computed=0)
BEGIN
	ALTER TABLE INV.InventoryDeliveryItem
		DROP COLUMN Fee
END

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryDeliveryItem') AND
				[Name] = 'Fee')
	ALTER TABLE INV.InventoryDeliveryItem
		ADD [Fee] AS CAST( (CASE WHEN [Quantity]=(0) THEN (0) ELSE [Price]/[Quantity] END) AS decimal(19,4) ) PERSISTED


--****************************************************************
-- Change decimal digits of Quantity and SecondaryQuantity to 4

-- First, remove the Fee column. It is computed and is dependent on Quantity
IF EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('INV.InventoryDeliveryItem') AND [Name] = 'Fee')
	ALTER TABLE INV.InventoryDeliveryItem DROP COLUMN [Fee]

ALTER TABLE INV.InventoryDeliveryItem ALTER COLUMN [Quantity] [decimal](19, 4) NOT NULL

ALTER TABLE INV.InventoryDeliveryItem
	ADD [Fee] AS CAST( (CASE WHEN [Quantity]=(0) THEN (0) ELSE [Price]/[Quantity] END) AS decimal(19,4) ) PERSISTED

ALTER TABLE INV.InventoryDeliveryItem ALTER COLUMN [SecondaryQuantity] [decimal](19, 4) NULL
ALTER TABLE INV.InventoryDeliveryItem ALTER COLUMN [RemainingQuantity] [decimal](19, 4) NOT NULL
ALTER TABLE INV.InventoryDeliveryItem ALTER COLUMN [RemainingSecondaryQuantity] [decimal](19, 4) NULL

--****************************************************************


--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'PK_InventoryDeliveryItem')
ALTER TABLE [INV].[InventoryDeliveryItem] ADD  CONSTRAINT [PK_InventoryDeliveryItem] PRIMARY KEY CLUSTERED 
(
	[InventoryDeliveryItemID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'DF_InventoryDeliveryItem_IsReturn' )
	ALTER TABLE [INV].[InventoryDeliveryItem]
	ADD CONSTRAINT [DF_InventoryDeliveryItem_IsReturn]  DEFAULT ((0)) FOR IsReturn

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE NAME = 'DF_InventoryDeliveryItem_RemainingQuantity' )
	ALTER TABLE [INV].[InventoryDeliveryItem]
	ADD CONSTRAINT [DF_InventoryDeliveryItem_RemainingQuantity]  DEFAULT ((0)) FOR RemainingQuantity

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_InventoryDeliveryItem_InventoryDeliveryRef')
	CREATE NONCLUSTERED INDEX IX_InventoryDeliveryItem_InventoryDeliveryRef
		ON [INV].[InventoryDeliveryItem] ([InventoryDeliveryRef])

go 

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_InventoryDeliveryItem_ProductOrderRef')
	CREATE NONCLUSTERED INDEX IX_InventoryDeliveryItem_ProductOrderRef
		ON [INV].[InventoryDeliveryItem] ([ProductOrderRef])
		INCLUDE ([ItemRef])

go 

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_InventoryDeliveryItem_IsReturnItemRef')
	CREATE NONCLUSTERED INDEX IX_InventoryDeliveryItem_IsReturnItemRef
ON [INV].[InventoryDeliveryItem] ([IsReturn],[ItemRef])

go 

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_InventoryDeliveryItem_WeighingRef')
	CREATE NONCLUSTERED INDEX IX_InventoryDeliveryItem_WeighingRef
ON [INV].[InventoryDeliveryItem] ([WeighingRef])
GO


IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_InventoryDeliveryItem_IsReturn')
	CREATE NONCLUSTERED INDEX IX_InventoryDeliveryItem_IsReturn
	ON [INV].[InventoryDeliveryItem] ([IsReturn])
	INCLUDE ([BaseInventoryDeliveryItem],[Quantity])

Go
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_InventoryDeliveryItem')
	CREATE NONCLUSTERED INDEX IX_InventoryDeliveryItem
		ON INV.InventoryDeliveryItem (BaseInvoiceItem) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_InventoryDeliveryRef')
	CREATE NONCLUSTERED INDEX IX_InventoryDeliveryRef
		ON INV.InventoryDeliveryItem (InventoryDeliveryRef) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_ParityCheck')
BEGIN
	IF NOT EXISTS(SELECT 1 WHERE cast(SERVERPROPERTY('ProductVersion') AS varchar) LIKE '1%')							
	BEGIN
		CREATE UNIQUE NONCLUSTERED INDEX [IX_ParityCheck] ON [INV].[InventoryDeliveryItem]
		(
			[ParityCheck] ASC
		) 		
		ON [PRIMARY]
	END
	ELSE -- The Version  Of Sql Server Is 2008 Or More
	BEGIN
		Exec('CREATE UNIQUE NONCLUSTERED INDEX [IX_ParityCheck] ON [INV].[InventoryDeliveryItem] 
				(
					[ParityCheck] ASC
				) 
			WHERE [ParityCheck] IS Not NULL
			ON [PRIMARY]')
	END
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_InventoryDaliveryItem_QuotationItemRef' )
    CREATE INDEX IX_InventoryDaliveryItem_QuotationItemRef 
      ON [INV].[InventoryDeliveryItem] (QuotationItemRef)
		
--<< FOREIGNKEYS DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'FK_InventoryDeliveryItem_Account')
ALTER TABLE [INV].[InventoryDeliveryItem]  ADD  CONSTRAINT [FK_InventoryDeliveryItem_Account] FOREIGN KEY([SLAccountRef])
REFERENCES [ACC].[Account] ([AccountId])

GO
If not Exists (select 1 from sys.objects where name = 'FK_InventoryDeliveryItem_InventoryDelivery')
ALTER TABLE [INV].[InventoryDeliveryItem]  ADD  CONSTRAINT [FK_InventoryDeliveryItem_InventoryDelivery] FOREIGN KEY([InventoryDeliveryRef])
REFERENCES [INV].[InventoryDelivery] ([InventoryDeliveryID])
ON DELETE CASCADE

GO
If not Exists (select 1 from sys.objects where name = 'FK_InventoryDeliveryItem_InvoiceItem')
ALTER TABLE [INV].[InventoryDeliveryItem]  ADD  CONSTRAINT [FK_InventoryDeliveryItem_InvoiceItem] FOREIGN KEY([BaseInvoiceItem])
REFERENCES [SLS].[InvoiceItem] ([InvoiceItemID])

GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_InventoryDeliveryItem_QuotationItem')
ALTER TABLE [INV].[InventoryDeliveryItem] ADD CONSTRAINT [FK_InventoryDeliveryItem_QuotationItem] FOREIGN KEY([QuotationItemRef])
REFERENCES [SLS].[QuotationItem] ([QuotationItemID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_InventoryDeliveryItem_Item')
ALTER TABLE [INV].[InventoryDeliveryItem]  ADD  CONSTRAINT [FK_InventoryDeliveryItem_Item] FOREIGN KEY([ItemRef])
REFERENCES [INV].[Item] ([ItemID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_InventoryDeliveryItem_ReturnedInvoiceItem')
ALTER TABLE [INV].[InventoryDeliveryItem]  ADD  CONSTRAINT [FK_InventoryDeliveryItem_ReturnedInvoiceItem] FOREIGN KEY([BaseReturnedInvoiceItem])
REFERENCES [SLS].[ReturnedInvoiceItem] ([ReturnedInvoiceItemID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_InventoryDeliveryItem_Tracing')
ALTER TABLE [INV].[InventoryDeliveryItem]  ADD  CONSTRAINT [FK_InventoryDeliveryItem_Tracing] FOREIGN KEY([TracingRef])
REFERENCES [INV].[Tracing] ([TracingID])

GO
If not Exists (select 1 from sys.objects where name = 'FK_InventoryDeliveryReturnItem_InventoryDeliveryItem')
ALTER TABLE [INV].[InventoryDeliveryItem]  ADD  CONSTRAINT [FK_InventoryDeliveryReturnItem_InventoryDeliveryItem] FOREIGN KEY([BaseInventoryDeliveryItem])
REFERENCES [INV].[InventoryDeliveryItem] ([InventoryDeliveryItemID])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects where name = 'FK_InventoryDeliveryItem_ProductOrder')
ALTER TABLE [INV].[InventoryDeliveryItem]  ADD  CONSTRAINT [FK_InventoryDeliveryItem_ProductOrder] FOREIGN KEY([ProductOrderRef])
REFERENCES [WKO].[ProductOrder] ([ProductOrderID])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects where name = 'FK_InventoryDeliveryItem_Weighing')
ALTER TABLE [INV].[InventoryDeliveryItem]  ADD  CONSTRAINT [FK_InventoryDeliveryItem_Weighing] FOREIGN KEY([WeighingRef])
REFERENCES [INV].[InventoryWeighing] ([InventoryWeighingID])

GO

IF NOT EXISTS (SELECT 1 FROM sys.objects where name = 'FK_InventoryDeliveryItem_ItemRequestItemRef')
ALTER TABLE [INV].[InventoryDeliveryItem]  ADD  CONSTRAINT [FK_InventoryDeliveryItem_ItemRequestItemRef] FOREIGN KEY([ItemRequestItemRef])
REFERENCES [POM].[ItemRequestItem] ([ItemRequestItemID])

GO





--<< DROP OBJECTS >>--
