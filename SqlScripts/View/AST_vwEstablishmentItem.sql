IF EXISTS (
		SELECT OBJECT_ID FROM sys.objects O WHERE   O.name LIKE 'vwEstablishmentItem' 
												  AND O.schema_id = (
																	SELECT schema_id FROM sys.schemas sch WHERE sch.name LIKE 'AST'))
DROP VIEW AST.vwEstablishmentItem
GO

CREATE VIEW AST.vwEstablishmentItem
AS
	SELECT  
		  CP.[CostPartId]				
		, CP.[AssetRef]					
		, CP.[CostPartType]				
		, CP.[TotalCost]					
		, CP.[AccumulatedDepreciation]	
		, CP.[EstablishmentAccumulatedDepreciation]   
		, CP.[EffectiveDate]				
		, CPT.[DepreciationRate]
		, CPT.[DepreciationMethodType]
		, CPT.[UseFulLife]
		, CPT.[MaxDepreciableBookValue]	
		, CPT.[SalvageValue]	
		, (CPT.[UseFulLife] - CPT.[AcquisingElapsedLife]) As AssetRemainingUseFulLife
		, CPT.[AcquisingElapsedLife]
		, CPT.[DepreciationState]
		, (CP.TotalCost - CP.AccumulatedDepreciation) DepreciableBookValue
		, CP.[IsInitial]
		
	FROM AST.CostPart CP
		INNER JOIN AST.CostPartTransaction CPT on CPT.CostPartRef = CP.CostPartId
		INNER JOIN AST.AssetTransaction AT ON AT.AssetTransactionID = CPT.AssetTransactionRef AND AT.TransactionType = 2 AND AT.AssetRef = CP.AssetRef
	
	WHERE CP.IsInitial = 1 AND CP.CostpartType <> 1
