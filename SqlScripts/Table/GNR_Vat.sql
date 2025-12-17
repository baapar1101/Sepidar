--<<FileName:GNR_Vat.sql>>--
--<< TABLE DEFINITION >>--

If Object_ID('GNR.Vat') Is Null
CREATE TABLE [GNR].[Vat](
	[VatID] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[FromDate] [datetime] NOT NULL,
	[ToDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL,
	[Creator] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifier] [int] NOT NULL,
	[LastModificationDate] [datetime] NOT NULL,
	[FiscalYearRef] int NOT NULL,
	NonDiminutionTaxAndDuty decimal(19, 4) NOT NULL,
	NonDiminutionDuty decimal(19, 4) NOT NULL,
	
	DomesticSaleNonTaxExemptItems decimal(19, 4) NOT NULL,
	DomesticSaleNonTaxExemptServices decimal(19, 4) NOT NULL,
	DomesticSaleTaxExemptItems decimal(19, 4) NOT NULL,
	DomesticSaleTaxExemptServices decimal(19, 4) NOT NULL,

	ExportSaleItems decimal(19, 4) NOT NULL,
	ExportSaleServices decimal(19, 4) NOT NULL,

	ReceiptTaxDomesticSaleNonTaxExemptItems decimal(19, 4) NOT NULL,
	ReceiptTaxDomesticSaleNonTaxExemptServices decimal(19, 4) NOT NULL,
	ReceiptTaxDomesticSaleTaxExemptItems decimal(19, 4) NOT NULL,
	ReceiptTaxDomesticSaleTaxExemptServices decimal(19, 4) NOT NULL,

	ReceiptTaxExportSaleItems decimal(19, 4) NOT NULL,
	ReceiptTaxExportSaleServices decimal(19, 4) NOT NULL,

	DomesticPurchaseNonTaxExemptItems decimal(19, 4) NOT NULL,
	DomesticPurchaseNonTaxExemptServices decimal(19, 4) NOT NULL,
	DomesticPurchaseTaxExemptItems decimal(19, 4) NOT NULL,
	DomesticPurchaseTaxExemptServices decimal(19, 4) NOT NULL,

	ImportPurchaseNonTaxExemptItems decimal(19, 4) NOT NULL,
	ImportPurchaseNonTaxExemptServices decimal(19, 4) NOT NULL,
	ImportPurchaseTaxExemptItems decimal(19, 4) NOT NULL,
	ImportPurchaseTaxExemptServices decimal(19, 4) NOT NULL,

	PayedTaxDomesticPurchaseNonTaxExemptItems decimal(19, 4) NOT NULL,
	PayedTaxDomesticPurchaseNonTaxExemptServices decimal(19, 4) NOT NULL,
	PayedTaxDomesticPurchaseTaxExemptItems decimal(19, 4) NOT NULL,
	PayedTaxDomesticPurchaseTaxExemptServices decimal(19, 4) NOT NULL,

	PayedTaxImportPurchaseNonTaxExemptItems decimal(19, 4) NOT NULL,
	PayedTaxImportPurchaseNonTaxExemptServices decimal(19, 4) NOT NULL,
	PayedTaxImportPurchaseTaxExemptItems decimal(19, 4) NOT NULL,
	PayedTaxImportPurchaseTaxExemptServices decimal(19, 4) NOT NULL
) ON [PRIMARY]


--TEXTIMAGE_ON [SGBlob_Data]
--When a table has text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml or large user defined type columns uncomment above code
GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*if not exists (select 1 from sys.columns where object_id=object_id('GNR.Vat') and
				[name] = 'ColumnName')
begin
    Alter table GNR.Vat Add ColumnName DataType Nullable
end

GO*/

if not exists (select 1 from sys.columns where object_id=object_id('GNR.Vat') and
				[name] = 'NonDiminutionDuty')
begin
    Alter table GNR.Vat Add NonDiminutionDuty decimal(19, 4) NOT NULL DEFAULT 0
end

GO
--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If not Exists (select 1 from sys.objects where name = 'PK_Vat')
ALTER TABLE [GNR].[Vat] ADD  CONSTRAINT [PK_Vat] PRIMARY KEY CLUSTERED 
(
	[VatID] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

--<< FOREIGNKEYS DEFINITION >>--

GO

--<< DROP OBJECTS >>--
