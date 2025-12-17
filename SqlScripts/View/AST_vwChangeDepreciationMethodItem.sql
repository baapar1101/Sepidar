IF EXISTS (
		SELECT OBJECT_ID FROM sys.objects O WHERE   O.name LIKE 'vwChangeDepreciationMethodItem' 
												  AND O.schema_id = (
																	SELECT schema_id FROM sys.schemas sch WHERE sch.name LIKE 'AST'))
DROP VIEW AST.vwChangeDepreciationMethodItem
GO

CREATE VIEW AST.vwChangeDepreciationMethodItem
AS(
	SELECT  
		 CDMI.[ChangeDepreciationMethodItemId]
		,C.[CostPartType]
		,C.[EffectiveDate]
		,C.[TotalCost]
		,CDMI.[CostPartRef]
		,CDMI.[CostPartTransactionRef]
		,CDMI.[ChangeDepreciationMethodRef]
		,CT.[DepreciationMethodType] AS PreviousDepreciationMethodType 
		,CT.[DepreciationRate] AS PreviousDepreciationRate 
		,CT.[UsefulLife] AS PreviousUsefulLife 
		,CT.[MaxDepreciableBookValue] AS PreviousMaxDepreciableBookValue
		,CDMI.[DepreciationMethodType]
		,CDMI.[DepreciationRate]
		,CDMI.[UsefulLife]
		,CDMI.[MaxDepreciableBookValue]
		,CDMI.[AssetElapsedLife]
		,CDMI.UsefulLife - CDMI.AssetElapsedLife AS  AssetRemainingUsefulLife
		,CDMI.[AccumulatedDepreciation]
		,CDMI.[DepreciableBookValue]
		,CDM.[Date] HeaderDate
	
	FROM AST.CostPartTransaction CT
		 inner join AST.CostPart C on C.CostPartId = CT.CostPartRef
		 inner join  AST.ChangeDepreciationMethodItem CDMI on CT.CostPartTransactionId = CDMI.CostPartTransactionRef
		 inner join  AST.ChangeDepreciationMethod CDM on CDM.ChangeDepreciationMethodId = CDMI.ChangeDepreciationMethodRef
		 
  )
  
  
 

 