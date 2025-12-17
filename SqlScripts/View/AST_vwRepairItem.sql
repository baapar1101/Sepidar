IF EXISTS (
		SELECT OBJECT_ID FROM sys.objects O WHERE   O.name LIKE 'vwRepairItem' 
												  AND O.schema_id = (
																	SELECT schema_id FROM sys.schemas sch WHERE sch.name LIKE 'AST'))
DROP VIEW AST.vwRepairItem
GO

CREATE VIEW AST.vwRepairItem
AS(
	SELECT  
		 RI.[RepairItemId]
		,RI.[RepairRef]
		,RI.[AssetRef]
		,RI.[CostPartRef]
		,A.[PlaqueNumber]
		,A.[Title] As AssetTitle
		,A.[Title_En] As AssetTitle_En
		,A.[AssetGroupRef] As AssetGroupRef
		,A.[AssetGroupTitle] 
		,A.[AssetGroupTitle_En] 
		,A.AssetClassRef
		,A.AcquisitionReceiptType
		,AC.Code As AssetClassCode
		,AC.Title As AssetClassTitle
		,AC.Title_En As AssetClassTitle_En
		,RI.[CostPartType]
		,RI.[AssetTransactionRef]
		,RI.[DepreciationMethodType]
		,RI.[DepreciationRate]
		,RI.[UsefulLife]
		,RI.[MaxDepreciableBookValue]
		,RI.[SalvageValue]
		,RI.[TotalCost]
		,RI.[EffectiveDate] 
		,A.IsImportPurchase
		,A.CostCenterDlRef
	FROM  AST.RepairItem RI
		 INNER JOIN AST.vwAsset A on A.AssetId = RI.AssetRef
		 INNER JOIN AST.AssetClass AC ON AC.AssetClassID = A.AssetClassRef
		   
  )
  