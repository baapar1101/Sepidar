IF EXISTS (
		SELECT OBJECT_ID FROM sys.objects O WHERE   O.name LIKE 'vwAcquisitionReceiptItem' 
												  AND O.schema_id = (
																	 SELECT schema_id FROM sys.schemas sch WHERE sch.name LIKE 'AST'))
DROP VIEW AST.vwAcquisitionReceiptItem
GO

CREATE VIEW AST.vwAcquisitionReceiptItem
AS(
	SELECT   ARI.[AcquisitionReceiptItemID]
			,ARI.[AcquisitionReceiptRef]
			,ARI.[PlaqueNumber]
			,ARI.[OldPlaqueNumber]
			,ARI.[Title]
			,ARI.[Title_En]
			,ARI.[AssetGroupRef] 
			,AG.[Code] AS AssetGroupCode
			,AG.[FullCode] AS AssetGroupFullCode
			,AG.[Title] AS AssetGroupTitle
			,AG.[Title_En] AS AssetGroupTitle_En
			,AC.[AssetClassID] AS AssetClassRef
			,AC.[Code] AS AssetClassCode
			,AC.[Title] AS AssetClassTitle
			,AC.[Title] AS AssetClassTitle_En
			,ARI.[AssetRef]			
			,CC.[DLRef] AS CostCenterDlRef
			,CC.[DLCode] AS CostCenterDLCode
			,CC.[DLTitle] AS CostCenterDLTitle
			,CC.[DLTitle_En] AS CostCenterDLTitle_En
			,CC.[DLType] AS CostCenterDLType
			,CC.[IsActive] AS CostCenterIsActive
			,ARI.[EmplacementRef]
			,E.[Code] AS EmplacementCode
			,E.[Title] AS EmplacementTitle
			,E.[Title_En] AS EmplacementTitle_En			
			,ARI.[UtilizationDate]
			,ARI.[AccumulatedDepreciation]
			,ARI.[ReceiverPartyRef]
			,P.[FullName] AS ReceiverPartyName
			,P.[Name_En] AS  ReceiverPartyName_En
			,P.[DLCode] As ReceiverPartyDLCode
			,ARI.[TotalCost]
			,ARI.[TotalCostInBasecurrency]
			,ARI.[DepreciationRate]
			,ARI.[DepreciationMethodType]
			,ARI.[UsefulLife]
			,ARI.[MaxDepreciableBookValue]
			,ARI.[SalvageValue]
			,ARI.[AssetTransactionRef]
			,ARI.[Description]
			,ARI.[Details]
			,A.Title AS AssetTitle
			,A.Title_En AS AssetTitle_En
			, CASE WHEN EXISTS 
				(SELECT 1 
				 FROM AST.AssetRelatedPurchaseInvoice 
				 WHERE AcquisitionReceiptItemRef = ARI.AcquisitionReceiptItemId 
						AND PurchaseInvoiceItemRef IS NOT NULL )
				THEN 1
		     ELSE 0 END AS IsImportPurchase
	FROM AST.AcquisitionReceiptItem ARI
		INNER JOIN AST.vwAssetGroup AG 
			ON AG.AssetGroupID = ARI.AssetGroupRef
		INNER JOIN AST.AssetClass AC
			ON AC.AssetClassID = AG.AssetClassRef
		INNER JOIN AST.Asset A
			ON A.AssetID = ARI.AssetRef
		INNER JOIN AST.vwAstCostCenter CC
			ON CC.Dlref = ARI.CostCenterDlRef
		LEFT JOIN AST.Emplacement E
			ON E.EmplacementID = ARI.EmplacementRef
		LEFT JOIN GNR.vwParty P
			ON P.PartyId = ARI.[ReceiverPartyRef]
  )