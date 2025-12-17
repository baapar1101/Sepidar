IF EXISTS (
		SELECT OBJECT_ID FROM sys.objects O WHERE   O.name LIKE 'vwCostPart' 
												  AND O.schema_id = (
																	SELECT schema_id FROM sys.schemas sch WHERE sch.name LIKE 'AST'))
DROP VIEW AST.vwCostPart
GO

CREATE VIEW AST.vwCostPart
AS(
	SELECT  
		 CP.[CostPartId]				
		,CP.[AssetRef]					
		,CP.[CostPartType]				
		,CP.[TotalCost]					
		,CP.[AccumulatedDepreciation]	
		,CP.[EstablishmentAccumulatedDepreciation]
		,CP.[EffectiveDate]				
		,CP.[DepreciationRate]			
		,CP.[DepreciationMethodType]	
		,CP.[UsefulLife]				
		,CP.[MaxDepreciableBookValue]	
		,CP.[SalvageValue]	
		,([UsefulLife] - [AcquisingElapsedLife])  [AssetRemainingUseFulLife] 
		,CP.[AcquisingElapsedLife]		
		,CP.[DepreciationState]
		,(CP.TotalCost - CP.EstablishmentAccumulatedDepreciation) DepreciableBookValue
		,CP.[IsInitial]
	FROM AST.CostPart CP

  )