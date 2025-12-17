IF EXISTS (
		SELECT OBJECT_ID FROM sys.objects O WHERE   O.name LIKE 'vwUnuseableItem' 
												  AND O.schema_id = (
																	SELECT schema_id FROM sys.schemas sch WHERE sch.name LIKE 'AST'))
DROP VIEW AST.vwUnuseableItem
GO

CREATE VIEW AST.vwUnuseableItem
AS(
	SELECT  
		 I.[UnuseableItemId]
		,I.[AssetRef]
		,I.[UnuseableRef]
		,A.[PlaqueNumber]
		,A.[Title] As AssetTitle
		,A.[Title_En] As AssetTitle_En
		,A.[AssetGroupRef]
		,AG.[Title] As AssetGroupTitle
		,AG.[Title_En]	As AssetGroupTitle_En
		,A.[CostCenterDlRef] 
		,D.Title AS CostCenterTitle
		,D.Title_En AS CostCenterTitle_En
		,A.[EmplacementRef]		
		,E.Title AS EmplacementTitle
		,E.Title_EN AS EmplacementTitle_En
		,I.[RowNumber]
		,I.[AssetTransactionRef]
		,AG.AssetClassRef
		
	FROM AST.Asset A
		 LEFT JOIN AST.vwAstCostCenter CC ON CC.dlref = A.CostCenterdlRef 
		 LEFT JOIN ACC.DL D ON D.DLId = CC.DLRef
		 LEFT JOIN AST.Emplacement e ON E.EmplacementId = A.EmplacementRef	
		 INNER JOIN AST.AssetGroup AG ON AG.AssetGroupID = A.AssetGroupRef
		 INNER JOIN AST.UnuseableItem I ON I.AssetRef = a.AssetId	 
)