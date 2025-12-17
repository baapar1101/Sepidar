If Object_ID('PAY.vwTaxTableItem') Is Not Null
	Drop View PAY.vwTaxTableItem
GO
CREATE VIEW PAY.vwTaxTableItem
AS
SELECT     TaxTableItemId, FromAmount, ToAmount, Rate, TaxTableRef, PartialAmount, InLineAmount
FROM         PAY.TaxTableItem

