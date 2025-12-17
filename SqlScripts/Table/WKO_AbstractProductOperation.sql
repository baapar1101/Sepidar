If Object_ID('WKO.AbstractProductOperation') IS NULL
CREATE TABLE [WKO].[AbstractProductOperation] (
    AbstractProductOperationID INT              NOT NULL,
    ProductRef                 INT              NOT NULL,
    Quantity                   DECIMAL(19, 4)   NOT NULL,
    Code                       NVARCHAR(250)    NOT NULL,
    Title                      NVARCHAR(250)    NOT NULL,
    IsActive                   BIT              NOT NULL,
    Creator                    INT              NOT NULL,
    CreationDate               DATETIME         NOT NULL,
    LastModifier               INT              NOT NULL,
    LastModificationDate       DATETIME         NOT NULL,
    [Version]                  INT              NOT NULL
);
GO


-------------------- should be deleted later --------------------------

IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_AbstractProductOperation_ProductFormulaRef')
BEGIN
    ALTER TABLE [WKO].[AbstractProductOperation] DROP CONSTRAINT FK_AbstractProductOperation_ProductFormulaRef;
END

IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_AbstractProductOperation_ProductFormulaUnitRef')
BEGIN
    ALTER TABLE [WKO].[AbstractProductOperation] DROP CONSTRAINT FK_AbstractProductOperation_ProductFormulaUnitRef;
END

IF EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('WKO.AbstractProductOperation') AND
				[name] = 'ProductFormulaRef')
BEGIN
    ALTER TABLE [WKO].[AbstractProductOperation] DROP COLUMN [ProductFormulaRef]
END
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('WKO.AbstractProductOperation') AND
				[name] = 'ProductFormulaUnitRef')
BEGIN
    ALTER TABLE [WKO].[AbstractProductOperation] DROP COLUMN [ProductFormulaUnitRef]
END
GO

---------------------------------------------------

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE OBJECT_ID = OBJECT_ID('WKO.AbstractProductOperation') AND
				[name] = 'IsActive')
BEGIN
    ALTER TABLE [WKO].[AbstractProductOperation] ADD [IsActive] BIT NOT NULL
END
GO

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PK_AbstractProductOperationID')
BEGIN
    ALTER TABLE [WKO].[AbstractProductOperation] ADD CONSTRAINT [PK_AbstractProductOperationID] PRIMARY KEY CLUSTERED 
    (
        [AbstractProductOperationID] ASC
    ) ON [PRIMARY]
END
GO

--<< FOREIGNKEYS DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'FK_AbstractProductOperation_ProductRef')
BEGIN
    ALTER TABLE [WKO].[AbstractProductOperation] ADD CONSTRAINT [FK_AbstractProductOperation_ProductRef] FOREIGN KEY([ProductRef])
    REFERENCES [INV].[Item] ([ItemId])
END
GO