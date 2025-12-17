--<<FileName:INV_Item.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('INV.Item') IS NULL
	CREATE TABLE [INV].[Item] (
		[ItemID] [INT] NOT NULL
	   ,[Type] [INT] NOT NULL
	   ,[Code] [NVARCHAR](250) NOT NULL
	   ,[Title] [NVARCHAR](250) NOT NULL
	   ,[Title_En] [NVARCHAR](250) NOT NULL
	   ,[BarCode] [NVARCHAR](250) NULL
	   ,[UnitRef] [INT] NULL
	   ,[SecondaryUnitRef] [INT] NULL
	   ,[SaleUnitRef] AS ([UnitRef])
	   ,[IsUnitRatioConstant] [BIT] NOT NULL CONSTRAINT [DF_Item_IsUnitRatioConstant] DEFAULT ((0))
	   ,[UnitsRatio] [FLOAT] NULL
	   ,[MinimumAmount] [FLOAT] NULL
	   ,[MaximumAmount] [FLOAT] NULL
	   ,[CanHaveTracing] [BIT] NOT NULL CONSTRAINT [DF_Item_CanHaveTracing] DEFAULT ((0))
	   ,[TracingCategoryRef] [INT] NULL
	   ,[IsPricingBasedOnTracing] [BIT] NOT NULL CONSTRAINT [DF_Item_PricingBasedOnTracing] DEFAULT ((0))
	   ,[TaxExempt] [BIT] NOT NULL CONSTRAINT [DF_Item_TaxExempt] DEFAULT ((0))
	   ,[TaxExemptPurchase] [BIT] NOT NULL CONSTRAINT [DF_Item_TaxExemptPurchase] DEFAULT ((0))
	   ,[Sellable] [BIT] NOT NULL CONSTRAINT [DF_Item_Sellable] DEFAULT ((1))
	   ,[DefaultStockRef] [INT] NULL
	   ,[PurchaseGroupRef] [INT] NULL
	   ,[SaleGroupRef] [INT] NULL
	   ,[CompoundBarcodeRef] [INT] NULL
	   ,[ItemCategoryRef] [INT] NULL
	   ,[Creator] [INT] NOT NULL
	   ,[CreationDate] [DATETIME] NOT NULL
	   ,[LastModifier] [INT] NOT NULL
	   ,[LastModificationDate] [DATETIME] NOT NULL
	   ,[Version] [INT] NOT NULL
	   ,[IsActive] [BIT] NOT NULL
	   ,[AccountSLRef] [INT] NULL
	   ,[TaxRate] [DECIMAL](19, 4) NOT NULL
	   ,[DutyRate] [DECIMAL](19, 4) NOT NULL
	   ,[CodingGroupRef] [INT] NULL
	   ,[SerialTracking] [BIT] NOT NULL DEFAULT ((0))
	   ,[Weight] [DECIMAL](19, 4) NULL
	   ,[Volume] [DECIMAL](19, 4) NULL
	   ,[ConsumerFee] [DECIMAL](19, 4) NULL
	) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--
IF NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [name] = 'Weight')
BEGIN
	ALTER TABLE INV.Item ADD [Weight] [DECIMAL](19, 4) NULL
END

GO

IF NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [name] = 'Volume')
BEGIN
	ALTER TABLE INV.Item ADD [Volume] [DECIMAL](19, 4) NULL
END

GO

IF NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [name] = 'ConsumerFee')
BEGIN
	ALTER TABLE INV.Item ADD [ConsumerFee] [DECIMAL](19, 4) NULL
END

GO

IF NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [Name] = 'IranCode')
BEGIN
	ALTER TABLE INV.Item ADD [IranCode] [nvarchar](250) NULL
END


IF NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [Name] = 'TaxExempt')
	ALTER TABLE INV.Item ADD [TaxExempt] [bit] NOT NULL CONSTRAINT [DF_Item_TaxExempt] DEFAULT ((0))

IF NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [Name] = 'Sellable')
	ALTER TABLE INV.Item ADD [Sellable] [bit] NOT NULL CONSTRAINT [DF_Item_Sellable] DEFAULT ((1))

IF EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [Name] = 'DefaultStock')
BEGIN
	--sp_rename 'INV.Item.DefaultStock', 'DefaultStockRef', 'COLUMN';
	ALTER TABLE INV.Item
	DROP COLUMN DefaultStock
END

IF NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [Name] = 'CodingGroupRef')
	ALTER TABLE INV.Item ADD [CodingGroupRef] [INT] NULL

GO

IF EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [Name] = 'GroupRef')
BEGIN

	IF EXISTS (SELECT
				1
			FROM sys.[columns] c
			WHERE OBJECT_ID = OBJECT_ID('INV.GROUP'))
	BEGIN
		IF (EXISTS (SELECT
					1
				FROM sys.objects
				WHERE NAME = 'FK_Item_GroupRef')
			)
		BEGIN
			ALTER TABLE INV.[Item] DROP CONSTRAINT FK_Item_GroupRef
		END
		IF (EXISTS (SELECT
					1
				FROM sys.objects
				WHERE NAME = 'FK_ItemGroup_Group')
			)
		BEGIN
			ALTER TABLE INV.[Group] DROP CONSTRAINT FK_ItemGroup_Group
		END
		IF (EXISTS (SELECT
					1
				FROM sys.objects
				WHERE NAME = 'FK_Group_Group')
			)
		BEGIN
			ALTER TABLE INV.[Group] DROP CONSTRAINT FK_Group_Group
		END



		DROP TABLE INV.[Group]
	END

	ALTER TABLE INV.Item
	DROP COLUMN GroupRef
END

GO

IF NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [Name] = 'DefaultStockRef')
	ALTER TABLE INV.Item ADD [DefaultStockRef] [INT] NULL

IF NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [Name] = 'PurchaseGroupRef')
	ALTER TABLE INV.Item ADD [PurchaseGroupRef] [INT] NULL

IF NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [Name] = 'SaleGroupRef')
	ALTER TABLE INV.Item ADD [SaleGroupRef] [INT] NULL

GO

IF NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [Name] = 'TaxExemptPurchase')
BEGIN
	ALTER TABLE INV.Item ADD [TaxExemptPurchase] [bit] NOT NULL CONSTRAINT [DF_Item_TaxExemptPurchase] DEFAULT ((0))
	EXEC sp_executesql N'UPDATE INV.Item SET [TaxExemptPurchase] = [TaxExempt]'
END

GO


IF NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [Name] = 'CompoundBarcodeRef')
	ALTER TABLE INV.Item ADD [CompoundBarcodeRef] [INT] NULL

GO

IF NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [Name] = 'ItemCategoryRef')
	ALTER TABLE INV.Item ADD [ItemCategoryRef] [INT] NULL

GO

IF NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [Name] = 'IsActive')
	ALTER TABLE INV.Item ADD [IsActive] [bit] NOT NULL DEFAULT 1

GO

IF NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [Name] = 'AccountSLRef')
	ALTER TABLE INV.Item ADD [AccountSLRef] [INT] NULL
GO

IF NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [Name] = 'SerialTracking')
	ALTER TABLE INV.Item ADD [SerialTracking] [bit] NOT NULL DEFAULT ((0))
GO

IF NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [Name] = 'TaxRate2')
	AND NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [Name] = 'TaxRate')
	ALTER TABLE INV.Item ADD [TaxRate2] [decimal](19, 4) NULL
GO

IF NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [Name] = 'TaxRate')
	AND (EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [Name] = 'TaxRate2')
	)
BEGIN

	EXEC sp_executesql N'UPDATE INV.Item SET TaxRate2 = ISNULL((SELECT  CAST(Value AS decimal(19,4)) FROM FMK.Configuration WHERE [key] = ''TaxRate''),0) WHERE TaxRate2 IS NULL'
	EXEC sp_rename 'INV.Item.TaxRate2'
				  ,'TaxRate'
				  ,'COLUMN'
	EXEC sp_executesql N'ALTER TABLE INV.Item ALTER COLUMN TaxRate [decimal](19, 4)NOT NULL'
END
GO

IF NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [Name] = 'DutyRate2')
	AND NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [Name] = 'DutyRate')
	ALTER TABLE INV.Item ADD [DutyRate2] [decimal](19, 4) NULL
GO

IF NOT EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [Name] = 'DutyRate')
	AND (EXISTS (SELECT
			1
		FROM sys.columns
		WHERE object_id = OBJECT_ID('INV.Item')
		AND [Name] = 'DutyRate2')
	)
BEGIN

	EXEC sp_executesql N'UPDATE INV.Item SET DutyRate2 = ISNULL((SELECT  CAST(Value AS decimal(19,4)) FROM FMK.Configuration WHERE [key] = ''DutyRate''),0) WHERE DutyRate2 IS NULL'
	EXEC sp_rename 'INV.Item.DutyRate2'
				  ,'DutyRate'
				  ,'COLUMN'
	EXEC sp_executesql N'ALTER TABLE INV.Item ALTER COLUMN DutyRate [decimal](19, 4)NOT NULL'
END
GO
--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('INV.Item') and
				[name] = 'ColumnName')
begin
    Alter table INV.Item Add ColumnName DataType Nullable
end
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT
			1
		FROM sys.objects
		WHERE name = 'PK_Item')
	ALTER TABLE [INV].[Item] ADD CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED
	(
	[ItemID] ASC
	) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

IF NOT EXISTS (SELECT
			1
		FROM sys.objects
		WHERE NAME = 'DF_Item_CanHaveTracing')
	ALTER TABLE [INV].[Item] ADD CONSTRAINT [DF_Item_CanHaveTracing] DEFAULT ((0)) FOR [CanHaveTracing]

IF NOT EXISTS (SELECT
			1
		FROM sys.objects
		WHERE NAME = 'DF_Item_IsUnitRatioConstant')
	ALTER TABLE [INV].[Item] ADD CONSTRAINT [DF_Item_IsUnitRatioConstant] DEFAULT ((0)) FOR [IsUnitRatioConstant]

IF NOT EXISTS (SELECT
			1
		FROM sys.objects
		WHERE NAME = 'DF_Item_PricingBasedOnTracing')
	ALTER TABLE [INV].[Item] ADD CONSTRAINT [DF_Item_PricingBasedOnTracing] DEFAULT ((0)) FOR [IsPricingBasedOnTracing]

IF NOT EXISTS (SELECT
			1
		FROM sys.objects
		WHERE NAME = 'DF_Item_TaxExempt')
	ALTER TABLE INV.Item ADD CONSTRAINT [DF_Item_TaxExempt] DEFAULT ((0)) FOR [TaxExempt]

IF NOT EXISTS (SELECT
			1
		FROM sys.objects
		WHERE NAME = 'DF_Item_TaxExemptPurchase')
	ALTER TABLE INV.Item ADD CONSTRAINT [DF_Item_TaxExemptPurchase] DEFAULT ((0)) FOR [TaxExemptPurchase]

IF NOT EXISTS (SELECT
			1
		FROM sys.objects
		WHERE NAME = 'DF_Item_Sellable')
	ALTER TABLE INV.Item ADD CONSTRAINT [DF_Item_Sellable] DEFAULT ((0)) FOR [Sellable]

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT
			1
		FROM sys.indexes
		WHERE name = 'IX_BarCode')
	CREATE NONCLUSTERED INDEX [IX_BarCode] ON [INV].[Item]
	(
	[BarCode] ASC
	) ON [PRIMARY]

GO

-- Dropping incorrect indexes
IF EXISTS (SELECT
			1
		FROM sys.objects
		WHERE NAME = 'IX_Item_Title')
	ALTER TABLE [INV].[Item] DROP CONSTRAINT [IX_Item_Title]

IF EXISTS (SELECT
			1
		FROM sys.objects
		WHERE NAME = 'IX_Item_Title_En')
	ALTER TABLE [INV].[Item] DROP CONSTRAINT [IX_Item_Title_En]

IF EXISTS (SELECT
			1
		FROM sys.objects
		WHERE NAME = 'IX_Item_Code')
	ALTER TABLE [INV].[Item] DROP CONSTRAINT [IX_Item_Code]
GO


-- WorkItem 6879: Drop unique indexes for item title
IF EXISTS (SELECT
			1
		FROM sys.indexes
		WHERE NAME = 'IX_Item_Title')
	DROP INDEX [INV].[Item].[IX_Item_Title]
GO

IF EXISTS (SELECT
			1
		FROM sys.indexes
		WHERE NAME = 'IX_Item_Title_En')
	DROP INDEX [INV].[Item].[IX_Item_Title_En]
GO


--******* WHY COMMENTED: WorkItem 6879
--IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'IX_Item_Title')
--CREATE UNIQUE NONCLUSTERED INDEX [IX_Item_Title] ON [INV].[Item] 
--( [Title] ASC )
--GO

--IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE NAME = 'IX_Item_Title_En')
--CREATE UNIQUE NONCLUSTERED INDEX [IX_Item_Title_En] ON [INV].[Item] 
--( [Title_En] ASC )
--GO

IF NOT EXISTS (SELECT
			1
		FROM sys.indexes
		WHERE NAME = 'IX_Item_Code')
	CREATE UNIQUE NONCLUSTERED INDEX [IX_Item_Code] ON [INV].[Item]
	([Code] ASC)
GO


--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT
			1
		FROM sys.objects
		WHERE name = 'FK_Item_TracingCategory')
	ALTER TABLE [INV].[Item] ADD CONSTRAINT [FK_Item_TracingCategory] FOREIGN KEY ([TracingCategoryRef])
	REFERENCES [INV].[TracingCategory] ([TracingCategoryID])

GO
IF NOT EXISTS (SELECT
			1
		FROM sys.objects
		WHERE name = 'FK_Item_Unit_1')
	ALTER TABLE [INV].[Item] ADD CONSTRAINT [FK_Item_Unit_1] FOREIGN KEY ([UnitRef])
	REFERENCES [INV].[Unit] ([UnitID])

GO
IF NOT EXISTS (SELECT
			1
		FROM sys.objects
		WHERE name = 'FK_Item_Unit_2')
	ALTER TABLE [INV].[Item] ADD CONSTRAINT [FK_Item_Unit_2] FOREIGN KEY ([SecondaryUnitRef])
	REFERENCES [INV].[Unit] ([UnitID])

GO

IF EXISTS (SELECT
			1
		FROM sys.objects
		WHERE Name = 'FK_Item_DefaultStockRef')
	ALTER TABLE INV.Item
	DROP CONSTRAINT FK_Item_DefaultStockRef

IF NOT EXISTS (SELECT
			1
		FROM sys.objects
		WHERE Name = 'FK_Item_CodingGroup')
	ALTER TABLE INV.Item ADD CONSTRAINT
	FK_Item_CodingGroup FOREIGN KEY (CodingGroupRef)
	REFERENCES [GNR].[Grouping] ([GroupingID])

IF NOT EXISTS (SELECT
			1
		FROM sys.objects
		WHERE Name = 'FK_Item_DefaultStockRef')
	ALTER TABLE INV.Item ADD CONSTRAINT
	FK_Item_DefaultStockRef FOREIGN KEY (DefaultStockRef)
	REFERENCES INV.Stock (StockID) ON UPDATE NO ACTION ON DELETE SET NULL

IF NOT EXISTS (SELECT
			1
		FROM sys.objects
		WHERE Name = 'FK_Item_PurchaseGroup')
	ALTER TABLE INV.Item ADD CONSTRAINT
	FK_Item_PurchaseGroup FOREIGN KEY (PurchaseGroupRef)
	REFERENCES [GNR].[Grouping] ([GroupingID])

IF NOT EXISTS (SELECT
			1
		FROM sys.objects
		WHERE Name = 'FK_Item_SaleGroup')
	ALTER TABLE INV.Item ADD CONSTRAINT
	FK_Item_SaleGroup FOREIGN KEY (SaleGroupRef)
	REFERENCES [GNR].[Grouping] ([GroupingID])

GO

IF NOT EXISTS (SELECT
			1
		FROM sys.objects
		WHERE Name = 'FK_Item_CompoundBarcodeRef')
	ALTER TABLE INV.Item ADD CONSTRAINT
	[FK_Item_CompoundBarcodeRef] FOREIGN KEY (CompoundBarcodeRef)
	REFERENCES [INV].[CompoundBarcode] (CompoundBarcodeID)

GO

IF NOT EXISTS (SELECT
			1
		FROM sys.objects
		WHERE Name = 'FK_Item_ItemCategoryRef')
	ALTER TABLE INV.Item ADD CONSTRAINT
	[FK_Item_ItemCategoryRef] FOREIGN KEY (ItemCategoryRef)
	REFERENCES [INV].[ItemCategory] (ItemCategoryID)
GO

IF NOT EXISTS (SELECT
			1
		FROM sys.objects
		WHERE name = 'FK_Item_Account')
	ALTER TABLE [INV].[Item] ADD CONSTRAINT [FK_Item_Account] FOREIGN KEY ([AccountSLRef])
	REFERENCES [ACC].[Account] ([AccountId])
GO


--<< DROP OBJECTS >>--
