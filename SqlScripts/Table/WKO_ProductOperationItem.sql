
If Object_ID('WKO.ProductOperationItem') IS NULL
CREATE TABLE [WKO].[ProductOperationItem] (
    ProductOperationItemID          INT             NOT NULL,
    ProductOperationRef             INT             NOT NULL,
    ParentProductOperationItemRef   INT             NULL,
    ProductFormulaRef               INT             NULL,
    CostCenterRef                   INT             NULL,
    RequiredProductionQuantity      DECIMAL(19, 4)  NOT NULL,
    ActualFormulaQuantity           DECIMAL(19, 4)  NOT NULL,
    ProductRef                      INT             NOT NULL,
	IsAddedManually					BIT				NOT NULL,
	ProductOrderRef					INT				NULL,
	FormulaBOMItemRef				INT				NULL,
	ProductFormulaUnitRef			INT				NULL,
	ActualFormulaQuantityUnitRef	INT				NOT NULL,
	BaseProductOrderRef				INT				NULL,
);
GO

--<< ADD CLOLUMNS >>--

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('WKO.ProductOperationItem') AND
				[name] = 'ProductOrderRef')
BEGIN
    ALTER TABLE WKO.ProductOperationItem ADD [ProductOrderRef] INT NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('WKO.ProductOperationItem') AND
				[name] = 'FormulaBOMItemRef')
BEGIN
    ALTER TABLE WKO.ProductOperationItem ADD [FormulaBOMItemRef] INT NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('WKO.ProductOperationItem') AND
				[name] = 'ProductFormulaUnitRef')
BEGIN
    ALTER TABLE WKO.ProductOperationItem ADD [ProductFormulaUnitRef] INT NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('WKO.ProductOperationItem') AND
				[name] = 'ActualFormulaQuantityUnitRef')
BEGIN
    ALTER TABLE WKO.ProductOperationItem ADD [ActualFormulaQuantityUnitRef] INT NOT NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('WKO.ProductOperationItem') AND
				[name] = 'BaseProductOrderRef')
BEGIN
    ALTER TABLE WKO.ProductOperationItem ADD [BaseProductOrderRef] INT NULL
END
GO

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_ProductOperationItemID')
BEGIN
	ALTER TABLE [WKO].[ProductOperationItem] ADD CONSTRAINT [PK_ProductOperationItemID] PRIMARY KEY CLUSTERED 
	(
		[ProductOperationItemID] ASC
	) ON [PRIMARY]
END
GO


--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOperationItem_ProductOperationRef')
BEGIN
	ALTER TABLE [WKO].[ProductOperationItem] ADD CONSTRAINT [FK_ProductOperationItem_ProductOperationRef] FOREIGN KEY([ProductOperationRef])
	REFERENCES [WKO].[ProductOperation] ([ProductOperationID])
	ON DELETE CASCADE
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOperationItem_ParentProductOperationItemRef')
BEGIN
	ALTER TABLE [WKO].[ProductOperationItem] ADD CONSTRAINT [FK_ProductOperationItem_ParentProductOperationItemRef] FOREIGN KEY([ParentProductOperationItemRef])
	REFERENCES [WKO].[ProductOperationItem] ([ProductOperationItemID])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOperationItem_ProductFormulaRef')
BEGIN
	ALTER TABLE [WKO].[ProductOperationItem] ADD CONSTRAINT [FK_ProductOperationItem_ProductFormulaRef] FOREIGN KEY([ProductFormulaRef])
	REFERENCES [WKO].[ProductFormula] ([ProductFormulaId])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOperationItem_CostCenterRef')
BEGIN
	ALTER TABLE [WKO].[ProductOperationItem] ADD CONSTRAINT [FK_ProductOperationItem_CostCenterRef] FOREIGN KEY([CostCenterRef])
	REFERENCES [GNR].[CostCenter] ([CostCenterId])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOperationItem_ProductRef')
BEGIN
	ALTER TABLE [WKO].[ProductOperationItem] ADD CONSTRAINT [FK_ProductOperationItem_ProductRef] FOREIGN KEY([ProductRef])
	REFERENCES [INV].[Item] ([ItemId])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOperationItem_ProductOrderRef')
BEGIN
	ALTER TABLE [WKO].[ProductOperationItem] ADD CONSTRAINT [FK_ProductOperationItem_ProductOrderRef] FOREIGN KEY([ProductOrderRef])
	REFERENCES [WKO].[ProductOrder] ([ProductOrderId])
	ON DELETE SET NULL
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOperationItem_FormulaBOMItemRef')
BEGIN
	ALTER TABLE [WKO].[ProductOperationItem] ADD CONSTRAINT [FK_ProductOperationItem_FormulaBOMItemRef] FOREIGN KEY([FormulaBOMItemRef])
	REFERENCES [WKO].[FormulaBomItem] ([FormulaBomItemId])
END
GO

