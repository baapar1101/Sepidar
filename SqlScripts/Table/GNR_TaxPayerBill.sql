--<< TABLE DEFINITION >>--
IF Object_ID('GNR.TaxPayerBill') IS NULL
CREATE TABLE [GNR].[TaxPayerBill]
(
    [TaxPayerBillId]                     [int]            NOT NULL,

    [InvoiceRef]                         [int]            NULL,
    [ReturnedInvoiceRef]                 [int]            NULL,
    [StatusRef]                          [int]            NULL,
    [CustomsDeclarationRef]              [int]            NULL,
    [ExportServiceInvoiceRef]            [int]            NULL,
    [AssetSaleRef]                       [int]            NULL,

    [FiscalYearRef]                      [int]            NOT NULL,
    [BaseTaxPayerBillRef]                [int]            NULL,

    [SubmitType]                         [int]            NOT NULL,
    [State]                              [int]            NOT NULL,
    [StateInWorkBook]                    [int]            NOT NULL DEFAULT (0),
    [ReferenceNumber]                    [varchar](250)   NULL,
    [Uid]                                [varchar](250)   NULL,
    [BillNumber]                         [int]            NULL,
    [MotamedInno]                        [varchar](250)   NULL,
    [IsEdited]                           [bit]            NOT NULL DEFAULT (0),
    [EditDateTime]                       [datetime]       NULL,
    [IsFake]                             [bit]            NOT NULL DEFAULT (0),
    [IsUnknown]                          [bit]            NOT NULL DEFAULT (0),
    [MakingMethod]                       [INT]            NOT NULL DEFAULT (1),
    [PreviousState]                      [INT]            NULL,

    [BillNumberInno]                     [varchar](250)   NULL,
    [IssueDateIndatim]                   [datetime]       NULL,
    [CreationDateIndati2m]               [datetime]       NULL,
    [UniqueBillCodeTaxid]                [varchar](250)   NULL,
    [BaseUniqueBillCodeIrtaxid]          [varchar](250)   NULL,

    [ActionTypeIns]                      [int]            NOT NULL,
    [BillTypeInty]                       [int]            NOT NULL,
    [BillPatternInp]                     [int]            NOT NULL,

    [SellerEconomicCodeTins]             [nvarchar](250)  NULL,

    [CustomerPartyTypeTob]               [int]            NOT NULL,
    [CustomerNationalCodeBid]            [nvarchar](250)  NULL,
    [CustomerEconomicCodeTinb]           [nvarchar](250)  NULL,
    [CustomerZipCodeBpc]                 [nvarchar](250)  NULL,
    [CustomerBranchCodeBbc]              [nvarchar](250)  NULL,
    [CustomerPassportNumberBpn]          [nvarchar](250)  NULL,

    [CustomerContractUniqueCodeCrn]      [nvarchar](50)   NULL,

    [CottageNumberCdcn]                  [NVARCHAR](100)  NULL,
    [CottageDateCdcd]                    [DateTime]       NULL,
    [SellerCustomsDeclarationCodeScc]    [NVARCHAR](100)  NULL,
    [TotalExportPriceTocv]               [decimal](19, 4) NULL,
    [TotalExportPriceInBaseCurrencyTorv] [decimal](19, 4) NULL,
    [TotalNetWeightTonw]                 [decimal](19, 4) NULL,

    [TotalDiscountTdis]                  [decimal](19, 4) NULL,
    [TotalAmountBeforeDiscountTprdis]    [decimal](19, 4) NULL,
    [TotalAmountAfterDiscountTadis]      [decimal](19, 4) NULL,
    [TotalTaxTvam]                       [decimal](19, 4) NULL,
    [TotalOtherTaxesAndAmountsTodam]     [decimal](19, 4) NULL,
    [TotalNetPriceTbill]                 [decimal](19, 4) NULL,

    [SettlementTypeSetm]                 [int]            NOT NULL,
    [CashPaymentCap]                     [decimal](19, 4) NULL,
    [ChequePaymentInsp]                  [decimal](19, 4) NULL,

    [TotalVatShareTvop]                  [decimal](19, 4) NULL,

    [SepidarVersion]                     [NVARCHAR](10)   NULL,
    [Version]                            [int]            NOT NULL,
    [Creator]                            [int]            NOT NULL,
    [CreationDate]                       [datetime]       NOT NULL,
    [LastModifier]                       [int]            NOT NULL,
    [LastModificationDate]               [datetime]       NOT NULL,
    [IndependentBatchNumber]             [INT]            NULL,
    [RelatedVoucherType]                 [INT]            NOT NULL DEFAULT (0)
) ON [PRIMARY]

GO

--<< ADD CLOLUMNS >>--

IF NOT EXISTS (select 1 from sys.columns where object_id=object_id('GNR.TaxPayerBill') and
				[name] = 'ExportServiceInvoiceRef')
BEGIN
    ALTER TABLE GNR.TaxPayerBill ADD ExportServiceInvoiceRef INT NULL
END

GO

IF NOT EXISTS (select 1 from sys.columns where object_id=object_id('GNR.TaxPayerBill') and
				[name] = 'ReturnedInvoiceRef')
BEGIN
    ALTER TABLE GNR.TaxPayerBill ADD ReturnedInvoiceRef INT NULL
END

GO

IF NOT EXISTS (select 1 from sys.columns where object_id=object_id('GNR.TaxPayerBill') and
				[name] = 'StatusRef')
BEGIN
    ALTER TABLE GNR.TaxPayerBill ADD StatusRef INT NULL
END

GO

IF NOT EXISTS (select 1 from sys.columns where object_id=object_id('GNR.TaxPayerBill') and
				[name] = 'AssetSaleRef')
BEGIN
    ALTER TABLE GNR.TaxPayerBill ADD AssetSaleRef INT NULL
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBill') and [name] = 'BaseTaxPayerBillRef')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBill] Add [BaseTaxPayerBillRef] [int] NULL
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBill') and [name] = 'IsEdited')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBill] Add [IsEdited] [bit] NOT NULL  DEFAULT(0)
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBill') and [name] = 'CustomsDeclarationRef')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBill] Add [CustomsDeclarationRef] [int] NULL
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBill') and [name] = 'CottageNumberCdcn')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBill] Add [CottageNumberCdcn] [NVARCHAR](100) NULL
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBill') and [name] = 'CottageDateCdcd')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBill] Add [CottageDateCdcd] [DateTime] NULL
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBill') and [name] = 'TotalExportPriceTocv')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBill] Add [TotalExportPriceTocv] [decimal](19, 4) NULL
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBill') and [name] = 'TotalExportPriceInBaseCurrencyTorv')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBill] Add [TotalExportPriceInBaseCurrencyTorv] [decimal](19, 4) NULL
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBill') and [name] = 'TotalNetWeightTonw')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBill] Add [TotalNetWeightTonw] [decimal](19, 4)  NULL
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBill') and [name] = 'EditDateTime')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBill] Add [EditDateTime] [datetime] NULL
END

GO
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBill') and [name] = 'CustomerPassportNumberBpn')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBill] Add [CustomerPassportNumberBpn] [nvarchar](250) NULL
END

GO
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBill') and [name] = 'CustomerBranchCodeBbc')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBill] Add [CustomerBranchCodeBbc] [nvarchar](250) NULL
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBill') and [name] = 'StateInWorkBook')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBill] Add [StateInWorkBook] int NOT NULL DEFAULT(0)
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBill') and [name] = 'SepidarVersion')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBill] Add [SepidarVersion] [VARCHAR](10) NULL
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBill') and [name] = 'IsFake')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBill] Add [IsFake] [bit] NOT NULL  DEFAULT(0)
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBill') and [name] = 'IsUnknown')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBill] Add [IsUnknown] [bit] NOT NULL  DEFAULT(0)
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBill') and [name] = 'IndependentBatchNumber')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBill] Add [IndependentBatchNumber] [INT] NULL
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBill') and [name] = 'MakingMethod')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBill] Add [MakingMethod] [INT] NOT NULL DEFAULT (1)
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBill') and [name] = 'PreviousState')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBill] Add [PreviousState] [INT] NULL
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBill') and [name] = 'RelatedVoucherType')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBill] Add [RelatedVoucherType] [INT] NOT NULL DEFAULT (0)
END

GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerBill') and [name] = 'SellerCustomsDeclarationCodeScc')
BEGIN
    ALTER TABLE [GNR].[TaxPayerBill] Add [SellerCustomsDeclarationCodeScc] [NVARCHAR](100) NULL
END

GO
--<< ALTER COLUMNS >>--

IF EXISTS(SELECT * FROM sys.columns WHERE  object_id=object_id('GNR.TaxPayerBill') AND
	[Name] = 'CustomerContractUniqueCodeCrn')
BEGIN
 ALTER TABLE GNR.TaxPayerBill ALTER COLUMN CustomerContractUniqueCodeCrn NVARCHAR(50)
END


GO
--<< PRIMARYKEY DEFINITION >>--

IF NOT EXISTS(SELECT 1 FROM sys.objects WHERE name = 'PK_TaxPayerBill')
ALTER TABLE [GNR].[TaxPayerBill] ADD CONSTRAINT [PK_TaxPayerBill] PRIMARY KEY CLUSTERED
        ([TaxPayerBillId] ASC)
    ON [PRIMARY]

GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS (SELECT 1 FROM SYS.INDEXES WHERE name = 'IX_TaxPayerBill_InvoiceRef')
CREATE INDEX [IX_TaxPayerBill_InvoiceRef] ON [GNR].[TaxPayerBill]
(
	[InvoiceRef] ASC
) ON [PRIMARY]
GO

--<< FOREIGNKEYS DEFINITION >>--

If not Exists(select 1 from sys.objects where name = 'FK_TaxPayerBill_ReturnedInvoiceRef')
ALTER TABLE [GNR].[TaxPayerBill]
    ADD CONSTRAINT [FK_TaxPayerBill_ReturnedInvoiceRef] FOREIGN KEY ([ReturnedInvoiceRef])
        REFERENCES [SLS].[ReturnedInvoice] ([ReturnedInvoiceId])

GO

If not Exists(select 1 from sys.objects where name = 'FK_TaxPayerBill_InvoiceRef')
ALTER TABLE [GNR].[TaxPayerBill]
    ADD CONSTRAINT [FK_TaxPayerBill_InvoiceRef] FOREIGN KEY ([InvoiceRef])
        REFERENCES [SLS].[Invoice] ([InvoiceId])
GO

If not Exists(select 1 from sys.objects where name = 'FK_TaxPayerBill_BaseTaxPayerBillRef')
ALTER TABLE [GNR].[TaxPayerBill]
    ADD CONSTRAINT [FK_TaxPayerBill_BaseTaxPayerBillRef] FOREIGN KEY ([BaseTaxPayerBillRef])
        REFERENCES [GNR].[TaxPayerBill] ([TaxPayerBillId])
GO

IF NOT EXISTS(select 1 from sys.objects where name = 'FK_TaxPayerBill_StatusRef')
ALTER TABLE [GNR].[TaxPayerBill]
    ADD CONSTRAINT [FK_TaxPayerBill_StatusRef] FOREIGN KEY (StatusRef)
        REFERENCES [CNT].[Status] ([StatusID])
GO

If not Exists(select 1 from sys.objects where name = 'FK_TaxPayerBill_CustomsDeclarationRef')
ALTER TABLE [GNR].[TaxPayerBill]
    ADD CONSTRAINT [FK_TaxPayerBill_CustomsDeclarationRef] FOREIGN KEY ([CustomsDeclarationRef])
        REFERENCES [SLS].[CustomsDeclaration] ([CustomsDeclarationId])
GO

If not Exists(select 1 from sys.objects where name = 'FK_TaxPayerBill_ExportServiceInvoiceRef')
ALTER TABLE [GNR].[TaxPayerBill]
    ADD CONSTRAINT [FK_TaxPayerBill_ExportServiceInvoiceRef] FOREIGN KEY ([ExportServiceInvoiceRef])
        REFERENCES [SLS].[Invoice] ([InvoiceId])
GO

IF NOT EXISTS(select 1 from sys.objects where name = 'FK_TaxPayerBill_AssetSaleRef')
ALTER TABLE [GNR].[TaxPayerBill]
    ADD CONSTRAINT [FK_TaxPayerBill_AssetSaleRef] FOREIGN KEY (AssetSaleRef)
        REFERENCES [AST].[Sale] ([SaleID])
GO

--<< DROP OBJECTS >>--
