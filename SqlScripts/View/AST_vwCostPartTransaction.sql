If Object_ID('AST.vwCostPartTransaction') Is Not Null
	Drop View AST.vwCostPartTransaction
GO
CREATE VIEW [AST].[vwCostPartTransaction] AS 
SELECT	
	 CPT.[CostPartTransactionID]     
	,CPT.[AssetTransactionRef] 		
	,CPT.[CostPartRef]            	
	,CPT.[TotalCost]          		
	,CPT.[DepreciationMethodType]   
	,CPT.[UsefulLife]       			
	,CPT.[DepreciationRate]      	
	,CPT.[EffectiveDate]    			
	,CPT.[AccumulatedDepreciation]
	,CPT.[MaxDepreciableBookValue]   
	,CPT.[DepreciationValue]			
	,CPT.[CreationDate]        		
	,CPT.[Duration]      			
	,CPT.[CalculationDate]			
	,CPT.[DepreciationState]			
	,CPT.[SalvageValue]
	,(CPT.[UsefulLife] - CPT.[AcquisingElapsedLife])  [AssetRemainingUseFulLife]				
	,CPT.[AcquisingElapsedLife]	
	,CPT.[AssetElapsedLife] 
	,CPT.[RemainingRoundingDepreciation]		
FROM AST.CostPartTransaction CPT

GO


