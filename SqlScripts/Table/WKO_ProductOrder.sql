--<<FileName:WKO_ProductOrder.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('WKO.ProductOrder') IS NULL
CREATE TABLE [WKO].[ProductOrder](
	[ProductOrderID] [int] NOT NULL,
	[Number] [int] NOT NULL,
    [Date] [datetime] NOT NULL,
	[BaseProductOrderRef] [int] NULL,
    [CostCenterRef] [int] NOT NULL,
    [ProductRef] [int] NOT NULL,
    [ProductFormulaRef] [int] NULL,
    [Quantity] [decimal](19,4) NOT NULL,    
    [WastageQuantity] [decimal](19,4) NULL,
    [CustomerPartyRef] [int] NULL,
    [State] [int] NOT NULL,
    [RemainingBOMCost] [decimal](19,4) NULL,
    [BOMCost] [decimal](19,4) NULL,
    [EstimatedLabourCost] [decimal](19,4) NULL,
    [EstimatedOverheadCost] [decimal](19,4) NULL,
    [Cost] AS (CONVERT([decimal](19,4),ISNULL([BOMCost],0) + ISNULL([EstimatedLabourCost],0) + ISNULL([EstimatedOverheadCost],0))) PERSISTED,
	[FiscalYearRef] [int] NOT NULL,
	[CanTransferNextPeriod] [bit] NOT NULL,
	[IsInitial] [bit] NOT NULL,	
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL,
	[IndirectMaterialsCost] [decimal](19,4) NULL,
	[BaseQuotationItemRef] [int] NULL,
	[TracingTitle] [nvarchar](4000) NULL,
	[ProductFormulaUnitRef] [int] NULL

) ON [PRIMARY]

--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO

--<< ADD CLOLUMNS >>--
/*IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('WKO.ProductOrder') AND
				[Name] = 'ColumnName')
BEGIN
	ALTER TABLE WKO.ProductOrder ADD ColumnName DataType Nullable
END
GO*/

IF COLUMNPROPERTY(OBJECT_ID('WKO.ProductOrder'), 'BaseProductOrderRef' , 'AllowsNull') IS NULL
BEGIN
  ALTER TABLE WKO.ProductOrder ADD [BaseProductOrderRef] [int] NULL
END
GO
IF COLUMNPROPERTY(OBJECT_ID('WKO.ProductOrder'), 'RemainingBOMCost' , 'AllowsNull') IS NULL
BEGIN
  ALTER TABLE WKO.ProductOrder ADD [RemainingBOMCost] [decimal](19,4) NULL
END
GO

IF COLUMNPROPERTY(OBJECT_ID('WKO.ProductOrder'), 'CanTransferNextPeriod' , 'AllowsNull') IS NULL
BEGIN
  ALTER TABLE WKO.ProductOrder ADD [CanTransferNextPeriod] [bit] NULL
END
GO
IF COLUMNPROPERTY(OBJECT_ID('WKO.ProductOrder'), 'IsInitial' , 'AllowsNull') IS NULL
BEGIN
  ALTER TABLE WKO.ProductOrder ADD [IsInitial] [bit] NULL
END
GO
IF COLUMNPROPERTY(OBJECT_ID('WKO.ProductOrder'), 'IndirectMaterialsCost' , 'AllowsNull') IS NULL
BEGIN
  ALTER TABLE WKO.ProductOrder ADD [IndirectMaterialsCost] [decimal](19,4) NULL
END
GO
IF COLUMNPROPERTY(OBJECT_ID('WKO.ProductOrder'), 'BaseQuotationItemRef' , 'AllowsNull') IS NULL
BEGIN
  ALTER TABLE WKO.ProductOrder ADD [BaseQuotationItemRef] [int] NULL
END
GO
IF COLUMNPROPERTY(OBJECT_ID('WKO.ProductOrder'), 'TracingTitle' , 'AllowsNull') IS NULL
BEGIN
  ALTER TABLE WKO.ProductOrder ADD [TracingTitle] [nvarchar](4000) NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns where object_id=object_id('WKO.ProductOrder') AND
				[Name] = 'ProductFormulaUnitRef')
BEGIN
	ALTER TABLE WKO.ProductOrder ADD [ProductFormulaUnitRef] [int] NULL
END

--<< ALTER COLUMNS >>--

/*IF EXISTS (SELECT 1 FROM sys.columns WHERE  object_id=object_id('WKO.ProductOrder') AND
	[Name] = 'ColumnName')
BEGIN
	ALTER TABLE WKO.ProductOrder ALTER COLUMN ColumnName DataType NOT NULL
END*/

IF COLUMNPROPERTY(OBJECT_ID('WKO.ProductOrder'), 'CanTransferNextPeriod' , 'AllowsNull') = 1
BEGIN
  UPDATE WKO.ProductOrder Set [CanTransferNextPeriod] = ISNULL([CanTransferNextPeriod] , 0) WHERE [CanTransferNextPeriod] IS NULL
  ALTER TABLE WKO.ProductOrder Alter Column [CanTransferNextPeriod] [bit] NOT NULL
END
GO

IF COLUMNPROPERTY(OBJECT_ID('WKO.ProductOrder'), 'IsInitial' , 'AllowsNull') = 1
BEGIN
  UPDATE WKO.ProductOrder Set [IsInitial] = ISNULL([IsInitial] , 0) WHERE [IsInitial] IS NULL
  ALTER TABLE WKO.ProductOrder Alter Column [IsInitial] [bit] NOT NULL
END
GO

IF COLUMNPROPERTY(OBJECT_ID('WKO.ProductOrder'), 'Cost', 'IsComputed') = 1
BEGIN
    ALTER TABLE WKO.ProductOrder DROP COLUMN [Cost]
END
GO
ALTER TABLE WKO.ProductOrder
ADD [Cost] AS (CONVERT([decimal](19,4), ISNULL([IndirectMaterialsCost], 0) +ISNULL([BOMCost], 0) + ISNULL([EstimatedLabourCost], 0) + ISNULL([EstimatedOverheadCost], 0))) PERSISTED
GO

IF EXISTS (SELECT 1 
    FROM sys.columns 
    WHERE object_id = OBJECT_ID('WKO.ProductOrder') 
      AND [name] = 'ProductFormulaRef' 
      AND is_nullable = 0)
BEGIN
    ALTER TABLE WKO.ProductOrder 
    ALTER COLUMN [ProductFormulaRef] INT NULL
END
GO


--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_ProductOrderID')
BEGIN
	ALTER TABLE [WKO].[ProductOrder] ADD CONSTRAINT [PK_ProductOrderID] PRIMARY KEY CLUSTERED 
	(
		[ProductOrderID] ASC
	) ON [PRIMARY]
END
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOrder_BaseProductOrderRef')
BEGIN
	ALTER TABLE [WKO].[ProductOrder] ADD CONSTRAINT [FK_ProductOrder_BaseProductOrderRef] FOREIGN KEY([BaseProductOrderRef])
	REFERENCES [WKO].[ProductOrder] ([ProductOrderId])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOrder_CostCenterRef')
BEGIN
	ALTER TABLE [WKO].[ProductOrder] ADD CONSTRAINT [FK_ProductOrder_CostCenterRef] FOREIGN KEY([CostCenterRef])
	REFERENCES [GNR].[CostCenter] ([CostCenterId])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOrder_ProductRef')
BEGIN
	ALTER TABLE [WKO].[ProductOrder] ADD CONSTRAINT [FK_ProductOrder_ProductRef] FOREIGN KEY([ProductRef])
	REFERENCES [INV].[Item] ([ItemId])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOrder_ProductFormulaRef')
BEGIN
	ALTER TABLE [WKO].[ProductOrder] ADD CONSTRAINT [FK_ProductOrder_ProductFormulaRef] FOREIGN KEY([ProductFormulaRef])
	REFERENCES [WKO].[ProductFormula] ([ProductFormulaId])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOrder_CustomerPartyRef')
BEGIN
	ALTER TABLE [WKO].[ProductOrder] ADD CONSTRAINT [FK_ProductOrder_CustomerPartyRef] FOREIGN KEY([CustomerPartyRef])
	REFERENCES [GNR].[Party] ([PartyId])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOrder_FiscalYearRef')
BEGIN
	ALTER TABLE [WKO].[ProductOrder] ADD CONSTRAINT [FK_ProductOrder_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
	REFERENCES [FMK].[FiscalYear] ([FiscalYearId])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOrder_ProductFormulaUnitRef')
BEGIN
	ALTER TABLE [WKO].[ProductOrder] ADD CONSTRAINT [FK_ProductOrder_ProductFormulaUnitRef] FOREIGN KEY([ProductFormulaUnitRef])
	REFERENCES [INV].[Unit] ([UnitID])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOrder_BaseQuotationItemRef')
BEGIN
	ALTER TABLE [WKO].[ProductOrder] ADD CONSTRAINT [FK_ProductOrder_BaseQuotationItemRef] FOREIGN KEY([BaseQuotationItemRef])
	REFERENCES [SLS].[QuotationItem] ([QuotationItemID])
END
GO

--<< DROP OBJECTS >>--

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('WKO.ProductOrder') AND
			[name] = 'BOMPercent')
	BEGIN
		ALTER TABLE WKO.ProductOrder DROP COLUMN BOMPercent
	END

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('WKO.ProductOrder') AND
			[name] = 'EstimatedLabourPercent')
	BEGIN
		ALTER TABLE WKO.ProductOrder DROP COLUMN EstimatedLabourPercent
	END

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('WKO.ProductOrder') AND
			[name] = 'EstimatedOverheadPercent')
	BEGIN
		ALTER TABLE WKO.ProductOrder DROP COLUMN EstimatedOverheadPercent
	END