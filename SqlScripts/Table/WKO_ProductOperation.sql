
If Object_ID('WKO.ProductOperation') IS NULL
CREATE TABLE [WKO].[ProductOperation] (
    ProductOperationID              INT             NOT NULL,
    ProductRef                      INT             NOT NULL,
    CustomerPartyRef                INT             NULL,
    [Number]                        INT             NOT NULL,
    [Date]                          DATETIME        NOT NULL,
    BaseProductOperationRef         INT             NULL,
    Quantity						DECIMAL(19, 4)  NOT NULL,
    FiscalYearRef                   INT             NOT NULL,
    BaseQuotationItemRef            INT             NULL,
    AbstractProductOperationRef     INT             NULL,
    ItemUnitRef                     INT             NOT NULL,
    Creator                         INT             NOT NULL,
	CreationDate                    DATETIME        NOT NULL,
	LastModifier                    INT             NOT NULL,
    LastModificationDate            DATETIME        NOT NULL,
	[Version]                       INT             NOT NULL
);
GO


IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('WKO.ProductOperation') AND
				[name] = 'AbstractProductOperationRef')
BEGIN
    ALTER TABLE [WKO].[ProductOperation] ADD [AbstractProductOperationRef] INT NULL
END
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOperation_ProductFormulaRef')
BEGIN
	ALTER TABLE [WKO].[ProductOperation] DROP CONSTRAINT [FK_ProductOperation_ProductFormulaRef]
END
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('WKO.ProductOperation') AND
				[name] = 'ProductFormulaRef')
BEGIN
    ALTER TABLE [WKO].[ProductOperation] DROP COLUMN [ProductFormulaRef]
END
GO

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_ProductOperationID')
BEGIN
	ALTER TABLE [WKO].[ProductOperation] ADD CONSTRAINT [PK_ProductOperationID] PRIMARY KEY CLUSTERED 
	(
		[ProductOperationID] ASC
	) ON [PRIMARY]
END
GO

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOperation_ProductRef')
BEGIN
	ALTER TABLE [WKO].[ProductOperation] ADD CONSTRAINT [FK_ProductOperation_ProductRef] FOREIGN KEY([ProductRef])
	REFERENCES [INV].[Item] ([ItemId])
END
GO


IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOperation_CustomerPartyRef')
BEGIN
	ALTER TABLE [WKO].[ProductOperation] ADD CONSTRAINT [FK_ProductOperation_CustomerPartyRef] FOREIGN KEY([CustomerPartyRef])
	REFERENCES [GNR].[Party] ([PartyId])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOperation_BaseProductOperationRef')
BEGIN
	ALTER TABLE [WKO].[ProductOperation] ADD CONSTRAINT [FK_ProductOperation_BaseProductOperationRef] FOREIGN KEY([BaseProductOperationRef])
	REFERENCES [WKO].[ProductOperation] ([ProductOperationID])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOperation_FiscalYearRef')
BEGIN
	ALTER TABLE [WKO].[ProductOperation] ADD CONSTRAINT [FK_ProductOperation_FiscalYearRef] FOREIGN KEY([FiscalYearRef])
	REFERENCES [FMK].[FiscalYear] ([FiscalYearId])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOperation_BaseQuotationItemRef')
BEGIN
	ALTER TABLE [WKO].[ProductOperation] ADD CONSTRAINT [FK_ProductOperation_BaseQuotationItemRef] FOREIGN KEY([BaseQuotationItemRef])
	REFERENCES [SLS].[QuotationItem] ([QuotationItemID])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOperation_AbstractProductOperationRef')
BEGIN
	ALTER TABLE [WKO].[ProductOperation] ADD CONSTRAINT [FK_ProductOperation_AbstractProductOperationRef] FOREIGN KEY([AbstractProductOperationRef])
	REFERENCES [WKO].[AbstractProductOperation] ([AbstractProductOperationID])
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_ProductOperation_ItemUnitRef')
BEGIN
	ALTER TABLE [WKO].[ProductOperation] ADD CONSTRAINT [FK_ProductOperation_ItemUnitRef] FOREIGN KEY([ItemUnitRef])
	REFERENCES [INV].[Unit] ([UnitID])
END
GO
