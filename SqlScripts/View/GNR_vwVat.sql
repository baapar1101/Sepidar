If Object_ID('GNR.vwVat') Is Not Null
	Drop View GNR.vwVat
GO
CREATE VIEW [GNR].[vwVat]
AS
SELECT 	[VatID] ,
	[Number] ,
	[FromDate] ,
	[ToDate] ,
	[Version] ,
	[Creator] , 
	[CreationDate]  ,
	[LastModifier]  ,
	[LastModificationDate] ,
	[FiscalYearRef] ,
	(SELECT TOP 1 ToDate FROM [GNR].[Vat] lv 
	 WHERE v.ToDate <> lv.ToDate ORDER BY ToDate DESC)  LastVatDate,
	NonDiminutionTaxAndDuty ,
	NonDiminutionDuty ,
	
	DomesticSaleNonTaxExemptItems ,
	DomesticSaleNonTaxExemptServices ,
	DomesticSaleTaxExemptItems ,
	DomesticSaleTaxExemptServices ,

	ExportSaleItems ,
	ExportSaleServices ,

	ReceiptTaxDomesticSaleNonTaxExemptItems ,
	ReceiptTaxDomesticSaleNonTaxExemptServices ,
	ReceiptTaxDomesticSaleTaxExemptItems ,
	ReceiptTaxDomesticSaleTaxExemptServices ,

	ReceiptTaxExportSaleItems ,
	ReceiptTaxExportSaleServices ,

	DomesticPurchaseNonTaxExemptItems ,
	DomesticPurchaseNonTaxExemptServices ,
	DomesticPurchaseTaxExemptItems ,
	DomesticPurchaseTaxExemptServices ,

	ImportPurchaseNonTaxExemptItems ,
	ImportPurchaseNonTaxExemptServices ,
	ImportPurchaseTaxExemptItems ,
	ImportPurchaseTaxExemptServices ,

	PayedTaxDomesticPurchaseNonTaxExemptItems ,
	PayedTaxDomesticPurchaseNonTaxExemptServices ,
	PayedTaxDomesticPurchaseTaxExemptItems ,
	PayedTaxDomesticPurchaseTaxExemptServices ,

	PayedTaxImportPurchaseNonTaxExemptItems ,
	PayedTaxImportPurchaseNonTaxExemptServices ,
	PayedTaxImportPurchaseTaxExemptItems ,
	PayedTaxImportPurchaseTaxExemptServices
 FROM  [GNR].[Vat] v

