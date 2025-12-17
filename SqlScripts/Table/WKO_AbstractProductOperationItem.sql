If Object_ID('WKO.AbstractProductOperationItem') IS NULL
CREATE TABLE [WKO].[AbstractProductOperationItem] (
    AbstractProductOperationItemID          INT             NOT NULL,
    AbstractProductOperationRef             INT             NOT NULL,
    ParentAbstractProductOperationItemRef   INT             NULL,
    ProductFormulaRef                       INT             NULL,
    ProductFormulaUnitRef                   INT             NULL,
    RequiredProductionQuantity              DECIMAL(19, 4)  NOT NULL,
    ProductRef                              INT             NOT NULL,
    FormulaBOMItemRef                       INT             NULL,
    ActualFormulaQuantity                   DECIMAL(19, 4)  NOT NULL,
    ActualFormulaQuantityUnitRef            INT             NOT NULL
);
GO


--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_AbstractProductOperationItemID')
BEGIN
    ALTER TABLE [WKO].[AbstractProductOperationItem] ADD CONSTRAINT [PK_AbstractProductOperationItemID] PRIMARY KEY CLUSTERED 
    (
        [AbstractProductOperationItemID] ASC
    ) ON [PRIMARY]
END
GO

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_AbstractProductOperationItem_AbstractProductOperationRef')
BEGIN
    ALTER TABLE [WKO].[AbstractProductOperationItem] ADD CONSTRAINT [FK_AbstractProductOperationItem_AbstractProductOperationRef] FOREIGN KEY([AbstractProductOperationRef])
    REFERENCES [WKO].[AbstractProductOperation] ([AbstractProductOperationID])
    ON DELETE CASCADE
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_AbstractProductOperationItem_ParentAbstractProductOperationItemRef')
BEGIN
    ALTER TABLE [WKO].[AbstractProductOperationItem] ADD CONSTRAINT [FK_AbstractProductOperationItem_ParentAbstractProductOperationItemRef] FOREIGN KEY([ParentAbstractProductOperationItemRef])
    REFERENCES [WKO].[AbstractProductOperationItem] ([AbstractProductOperationItemID])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_AbstractProductOperationItem_ProductFormulaRef')
BEGIN
    ALTER TABLE [WKO].[AbstractProductOperationItem] ADD CONSTRAINT [FK_AbstractProductOperationItem_ProductFormulaRef] FOREIGN KEY([ProductFormulaRef])
    REFERENCES [WKO].[ProductFormula] ([ProductFormulaId])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_AbstractProductOperationItem_ProductFormulaUnitRef')
BEGIN
    ALTER TABLE [WKO].[AbstractProductOperationItem] ADD CONSTRAINT [FK_AbstractProductOperationItem_ProductFormulaUnitRef] FOREIGN KEY([ProductFormulaUnitRef])
    REFERENCES [INV].[Unit] ([UnitId])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_AbstractProductOperationItem_ProductRef')
BEGIN
    ALTER TABLE [WKO].[AbstractProductOperationItem] ADD CONSTRAINT [FK_AbstractProductOperationItem_ProductRef] FOREIGN KEY([ProductRef])
    REFERENCES [INV].[Item] ([ItemId])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_AbstractProductOperationItem_FormulaBOMItemRef')
BEGIN
    ALTER TABLE [WKO].[AbstractProductOperationItem] ADD CONSTRAINT [FK_AbstractProductOperationItem_FormulaBOMItemRef] FOREIGN KEY([FormulaBOMItemRef])
    REFERENCES [WKO].[FormulaBomItem] ([FormulaBomItemId])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_AbstractProductOperationItem_ActualFormulaQuantityUnitRef')
BEGIN
    ALTER TABLE [WKO].[AbstractProductOperationItem] ADD CONSTRAINT [FK_AbstractProductOperationItem_ActualFormulaQuantityUnitRef] FOREIGN KEY([ActualFormulaQuantityUnitRef])
    REFERENCES [INV].[Unit] ([UnitId])
END
GO