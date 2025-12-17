IF EXISTS (
		SELECT OBJECT_ID FROM sys.objects O WHERE   O.name LIKE 'vwUseableItem' 
												  AND O.schema_id = (
																	SELECT schema_id FROM sys.schemas sch WHERE sch.name LIKE 'AST'))
DROP VIEW AST.vwUseableItem
GO

CREATE VIEW AST.vwUseableItem
AS(
	SELECT  
		 I.[UseableItemId]
		,I.[AssetRef]
		,I.[UseableRef]
		,A.[PlaqueNumber]
		,A.[Title] As AssetTitle
		,A.[Title_En] As AssetTitle_En
		,A.[AssetGroupRef]
		,AG.[Title] As AssetGroupTitle
		,AG.[Title_En] As AssetGroupTitle_En
		,A.[CostCenterDlRef]
		,D.Title AS CostCenterTitle
		,D.Title_En AS CostCenterTitle_En
		,A.[EmplacementRef]		
		,E.Title AS EmplacementTitle
		,E.Title_EN AS EmplacementTitle_En
		,I.[RowNumber]	
		,I.[AssetTransactionRef]
		,AG.[AssetClassRef]
	 
	FROM AST.Asset A
		 LEFT JOIN AST.vwAstCostCenter CC ON CC.DLRef = A.CostCenterDlRef 
		 LEFT JOIN ACC.DL D ON D.DLId = CC.DLRef
		 LEFT JOIN AST.Emplacement e ON E.EmplacementId = A.EmplacementRef	
		 INNER JOIN AST.AssetGroup AG on AG.AssetGroupID = A.AssetGroupRef
		 INNER JOIN AST.UseableItem I on I.AssetRef = a.AssetId
)