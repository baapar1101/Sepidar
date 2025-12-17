IF OBJECT_ID('AST.vwDepreciationItem') IS NOT NULL 
	DROP VIEW AST.vwDepreciationItem
GO
CREATE VIEW AST.vwDepreciationItem
AS
	SELECT 
                 di.DepreciationItemID
                ,di.DepreciationRef
                ,di.CostPartRef
                ,di.CostPartTransactionRef
                ,di.LastCostPartTransactionRef
                ,di.DepreciationValue
                ,di.CalculationDate
                ,di.Duration
                ,di.AccumulatedDepreciation
                ,di.DepreciationState
                ,di.AssetElapsedLife
                ,di.RemainingRoundingDepreciation

                ,di.pDepreciationRate
                ,di.pUsefulLife
                ,di.pRemainingBookValue

                ,cp.TotalCost
                ,cp.EffectiveDate
                ,cp.SalvageValue
                ,cpt.DepreciationMethodType
                ,cpt.UsefulLife
                ,cpt.MaxDepreciableBookValue
                ,cpt.DepreciationRate
				                
	FROM		AST.DepreciationItem        di
	LEFT JOIN	AST.Depreciation            dp  ON di.DepreciationRef            = dp.DepreciationID
    LEFT JOIN	AST.CostPart                cp  ON di.CostPartRef                = cp.CostPartId
    LEFT JOIN	AST.CostPartTransaction     cpt ON di.LastCostPartTransactionRef = cpt.CostPartTransactionId
GO
