If Object_ID('PAY.vwTaxTable') Is Not Null
	Drop View PAY.vwTaxTable
GO
CREATE VIEW PAY.vwTaxTable
AS
SELECT     
	PAY.TaxTable.TaxTableId,
	PAY.TaxTable.Title,
	PAY.TaxTable.Title_En,
	PAY.TaxTable.TaxGroupRef,
	PAY.TaxTable.Date,
	PAY.TaxTable.TaxType,
	PAY.TaxTable.Version, 
	PAY.TaxTable.Creator,
	PAY.TaxTable.CreationDate,
	PAY.TaxTable.LastModifier,
	PAY.TaxTable.LastModificationDate, 
	PAY.TaxGroup.Title AS TaxGroupTitle,
	PAY.TaxGroup.Title_En AS TaxGroupTitle_En
FROM  PAY.TaxTable 
INNER JOIN PAY.TaxGroup 
	ON PAY.TaxTable.TaxGroupRef = PAY.TaxGroup.TaxGroupId

