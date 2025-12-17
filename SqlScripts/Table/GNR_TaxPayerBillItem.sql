--<< TABLE DEFINITION >>--
IF Object_ID('GNR.TaxPayerBillItem') IS NULL
CREATE TABLE [GNR].[TaxPayerBillItem]
(
    [TaxPayerBillItemId]             [int]             NOT NULL,
    [TaxPayerBillRef]                [int]             NOT NULL,

    [InvoiceItemRef]                 [int]             NULL,
    [ReturnedInvoiceItemRef]         [int]             NULL,
    [StatusItemRef]                  [int]             NULL,
    [CustomsDeclarationItemRef]      [int]             NULL,
    [AssetSaleItemRef]               [int]             NULL,
    [TaxPayerBillItemRef]            [int]             NULL,

    [ItemCodeSstid]                  [varchar](250)    NULL,
    [ItemTitleSstt]                  [varchar](250)    NULL,
    [QuantityAm]                     [decimal](19, 4)  NULL,
    [UnitCodeMu]                     [varchar](250)    NULL,
    [FeeFee]                         [decimal](23, 8)  NULL,
    [CurrencyFeeCfee]                [decimal](19, 4)  NULL,
    [CurrencyCut]                    [varchar](250)    NULL,
    [CurrencyRateExr]                [decimal](26, 16) NULL,
    [PurchaseSaleDifferencePspd]     [decimal](19, 4)  NULL,
    [CurrencyPurchaseRateCpr]        [decimal](26, 8)  NULL,
    [TaxSourceSovat]                 [decimal](19, 4)  NULL,
    [TaxSourcePerItem]               [decimal](19, 4)  NULL,

    [DiscountDis]                    [decimal](19, 4)  NULL,
    [AmountBeforeDiscountPrdis]      [decimal](19, 4)  NULL,
    [AmountAfterDiscountAdis]        [decimal](19, 4)  NULL,
    [TaxRateVra]                     [decimal](26, 16) NULL,
    [TaxVam]                         [decimal](19, 4)  NULL,
    [NetPriceTsstam]                 [decimal](19, 4)  NULL,

    [CashPaymentShareCop]            [decimal](19, 4)  NULL,
    [VatShareVop]                    [decimal](19, 4)  NULL,

    [OtherTaxesTitleOdt]             [varchar](250)    NULL,
    [OtherTaxesRateOdr]              [decimal](26, 16) NULL,
    [OtherTaxesAmountOdam]           [decimal](19, 4)  NULL,
    [OtherAmountsTitleOlt]           [varchar](250)    NULL,
    [OtherAmountsRateOlr]            [decimal](26, 16) NULL,
    [OtherAmountsAmountOlam]         [decimal](19, 4)  NULL,

    [ExportPriceSscv]                [decimal](19, 4)  NULL,
    [ExportPriceInBaseCurrencySsrv]  [decimal](19, 4)  NULL,
    [NetWeightNw]                    [decimal](19, 4)  NULL,

) ON [PRIMARY]

GO

--<< ADD COLUMNS >>--
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBillItem') and [name] = 'CurrencyPurchaseRateCpr')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBillItem] Add [CurrencyPurchaseRateCpr] [decimal](26, 8)  NULL
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBillItem') and [name] = 'TaxSourcePerItem')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBillItem] Add [TaxSourcePerItem] [decimal](19, 4)  NULL
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBillItem') and [name] = 'TaxSourceSovat')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBillItem] Add [TaxSourceSovat] [decimal](19, 4)  NULL
END

GO

IF NOT EXISTS (select 1 from sys.columns where object_id=object_id('GNR.TaxPayerBillItem') and [name] = 'StatusItemRef')
BEGIN
    ALTER TABLE GNR.TaxPayerBillItem ADD StatusItemRef INT NULL
END

GO

IF NOT EXISTS (select 1 from sys.columns where object_id=object_id('GNR.TaxPayerBillItem') and [name] = 'CustomsDeclarationItemRef')
BEGIN
    ALTER TABLE GNR.TaxPayerBillItem ADD CustomsDeclarationItemRef INT NULL
END

GO

IF NOT EXISTS (select 1 from sys.columns where object_id=object_id('GNR.TaxPayerBillItem') and [name] = 'ReturnedInvoiceItemRef')
BEGIN
    ALTER TABLE GNR.TaxPayerBillItem ADD ReturnedInvoiceItemRef INT NULL
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBillItem') and [name] = 'ExportPriceSscv')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBillItem] Add [ExportPriceSscv] [decimal](19, 4) NULL
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBillItem') and [name] = 'ExportPriceInBaseCurrencySsrv')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBillItem] Add [ExportPriceInBaseCurrencySsrv] [decimal](19, 4) NULL
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBillItem') and [name] = 'NetWeightNw')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBillItem] Add [NetWeightNw] [decimal](19, 4)  NULL
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBillItem') and [name] = 'PurchaseSaleDifferencePspd')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBillItem] Add [PurchaseSaleDifferencePspd] [decimal](19, 4)  NULL
END

GO

IF NOT EXISTS (select 1 from sys.columns where object_id=object_id('GNR.TaxPayerBillItem') and [name] = 'AssetSaleItemRef')
BEGIN
    ALTER TABLE GNR.TaxPayerBillItem ADD AssetSaleItemRef INT NULL
END

GO

IF NOT EXISTS (select 1 from sys.columns where object_id=object_id('GNR.TaxPayerBillItem') and [name] = 'TaxPayerBillItemRef')
BEGIN
    ALTER TABLE GNR.TaxPayerBillItem ADD TaxPayerBillItemRef INT NULL
END

--<< ALTER COLUMNS >>--
GO

IF EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS
           WHERE TABLE_SCHEMA = 'GNR' 
             AND TABLE_NAME = 'TaxPayerBillItem'
             AND COLUMN_NAME = 'FeeFee'
             AND NUMERIC_SCALE = 4)
BEGIN
ALTER TABLE [GNR].[TaxPayerBillItem] ALTER COLUMN FeeFee decimal(23,8)
END

GO

--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS(SELECT 1 FROM sys.objects WHERE name = 'PK_TaxPayerBillItem')
ALTER TABLE [GNR].[TaxPayerBillItem] ADD CONSTRAINT [PK_TaxPayerBillItem] PRIMARY KEY CLUSTERED
    ([TaxPayerBillItemId] ASC)
ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM SYS.INDEXES WHERE name = 'IX_TaxPayerBillItem_TaxPayerBillRef')
CREATE INDEX [IX_TaxPayerBillItem_TaxPayerBillRef] ON [GNR].[TaxPayerBillItem]
(
	[TaxPayerBillRef] ASC
) ON [PRIMARY]
GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists(select 1 from sys.objects where name = 'FK_TaxPayerBillItem_TaxPayerBillRef')
ALTER TABLE [GNR].[TaxPayerBillItem] ADD CONSTRAINT [FK_TaxPayerBillItem_TaxPayerBillRef] FOREIGN KEY ([TaxPayerBillRef])
    REFERENCES [GNR].[TaxPayerBill] ([TaxPayerBillId])
    ON DELETE CASCADE
GO

IF EXISTS(SELECT 1 FROM sys.objects WHERE name = 'FK_TaxPayerBillItem_InvoiceItemRef')
ALTER TABLE [GNR].[TaxPayerBillItem] DROP CONSTRAINT [FK_TaxPayerBillItem_InvoiceItemRef]

GO

If not Exists(select 1 from sys.objects where name = 'FK_SetNull_TaxPayerBillItem_InvoiceItemRef')
ALTER TABLE [GNR].[TaxPayerBillItem] ADD CONSTRAINT [FK_SetNull_TaxPayerBillItem_InvoiceItemRef] FOREIGN KEY ([InvoiceItemRef])
    REFERENCES [SLS].[InvoiceItem] ([InvoiceItemID])
    ON DELETE SET NULL
GO

IF EXISTS(SELECT 1 FROM sys.objects WHERE name = 'FK_TaxPayerBillItem_StatusItemRef')
ALTER TABLE [GNR].[TaxPayerBillItem] DROP CONSTRAINT [FK_TaxPayerBillItem_StatusItemRef]

GO

IF NOT EXISTS(SELECT 1 FROM sys.objects WHERE name = 'FK_TaxPayerBillItem_StatusItemRef')
ALTER TABLE [GNR].[TaxPayerBillItem] ADD CONSTRAINT [FK_TaxPayerBillItem_StatusItemRef] FOREIGN KEY ([StatusItemRef])
    REFERENCES [CNT].[StatusItem] ([StatusItemID])
    ON DELETE SET NULL

GO

IF EXISTS(SELECT 1 FROM sys.objects WHERE name = 'FK_TaxPayerBillItem_CustomsDeclarationItemRef')
ALTER TABLE [GNR].[TaxPayerBillItem] DROP CONSTRAINT [FK_TaxPayerBillItem_CustomsDeclarationItemRef]

GO

IF NOT EXISTS(SELECT 1 FROM sys.objects WHERE name = 'FK_TaxPayerBillItem_CustomsDeclarationItemRef')
ALTER TABLE [GNR].[TaxPayerBillItem] ADD CONSTRAINT [FK_TaxPayerBillItem_CustomsDeclarationItemRef] FOREIGN KEY ([CustomsDeclarationItemRef])
    REFERENCES [SLS].[CustomsDeclarationItem] ([CustomsDeclarationItemId])
    ON DELETE SET NULL

GO

IF EXISTS(SELECT 1 FROM sys.objects WHERE name = 'FK_TaxPayerBillItem_ReturnedInvoiceItemRef')
ALTER TABLE [GNR].[TaxPayerBillItem] DROP CONSTRAINT [FK_TaxPayerBillItem_ReturnedInvoiceItemRef]

IF NOT EXISTS(SELECT 1 FROM sys.objects WHERE name = 'FK_SetNull_TaxPayerBillItem_ReturnedInvoiceItemRef')
ALTER TABLE [GNR].[TaxPayerBillItem] ADD CONSTRAINT [FK_SetNull_TaxPayerBillItem_ReturnedInvoiceItemRef] FOREIGN KEY ([ReturnedInvoiceItemRef])
    REFERENCES [SLS].[ReturnedInvoiceItem] ([ReturnedInvoiceItemId])
    ON DELETE SET NULL

GO

IF NOT EXISTS(SELECT 1 FROM sys.objects WHERE name = 'FK_TaxPayerBillItem_AssetSaleItemRef')
ALTER TABLE [GNR].[TaxPayerBillItem] ADD CONSTRAINT [FK_TaxPayerBillItem_AssetSaleItemRef] FOREIGN KEY ([AssetSaleItemRef])
    REFERENCES [AST].[SaleItem] ([SaleItemID])
    ON DELETE SET NULL

GO

--<< DROP OBJECTS >>--
