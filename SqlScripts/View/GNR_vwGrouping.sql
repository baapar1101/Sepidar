IF object_id('GNR.vwGrouping') IS NOT NULL
	DROP VIEW GNR.vwGrouping

GO

CREATE VIEW GNR.vwGrouping
AS
SELECT
	G.GroupingID, G.EntityType, G.Code, G.FullCode , G.Title, G.Title_En, G.Version,
	G.Creator, G.CreationDate, G.LastModifier, G.LastModificationDate,
	G.[MaximumQuantityCredit],G.[HasQuantityCredit],G.[QuantityCreditCheckingType],
	G.CalculationFormulaRef, F.Code AS FormulaCode, F.Text AS FormulaText,
	G.ParentGroupRef AS ParentGroupRef, G2.Code AS ParentGroupCode,G2.FullCode AS ParentGroupFullCode, G2.Title AS ParentGroupTitle, G2.Title_En AS ParentGroupTitle_En,
	0 AS GroupImageIndex, G.MaximumCredit, G.HasCredit, G.CreditCheckingType
FROM
	GNR.Grouping AS G LEFT OUTER JOIN
	GNR.CalculationFormula AS F ON G.CalculationFormulaRef = F.CalculationFormulaID LEFT OUTER JOIN
	GNR.Grouping AS G2 ON G.ParentGroupRef = G2.GroupingID