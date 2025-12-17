IF OBJECT_ID('GNR.vwFormulaElement') IS NOT NULL
	DROP VIEW GNR.vwFormulaElement
GO

CREATE VIEW GNR.vwFormulaElement
AS
	SELECT
		FE.FormulaElementID, FE.CalculationFormulaRef, FE.CalculationElementRef,
		CE.Symbol AS ElementSymbol, CE.Title AS ElementTitle, CE.Title_En AS ElementTitle_En
	FROM
		GNR.FormulaElement FE
		INNER JOIN GNR.CalculationElement CE ON FE.CalculationElementRef=CE.CalculationElementID