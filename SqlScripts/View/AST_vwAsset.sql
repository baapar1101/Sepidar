IF EXISTS (
		SELECT OBJECT_ID FROM sys.objects O WHERE   O.name LIKE 'vwAsset' 
												  AND O.schema_id = (
																	SELECT schema_id FROM sys.schemas sch WHERE sch.name LIKE 'AST'))
DROP VIEW AST.vwAsset
GO

CREATE VIEW AST.vwAsset
AS(
	SELECT  
		 A.[AssetId]				
		,A.[PlaqueNumber]			
		,A.[OldPlaqueNumber]		
		,A.[PlaqueSerial]			
		,A.[Title]					
		,A.[Title_En]				
		,A.[State]					
		,A.[AssetGroupRef]			
		,AG.Title AS AssetGroupTitle
		,AG.Title_En AS assetGroupTitle_En
		,AG.AssetClassRef, AC.Title AS AssetClassTitle , AC.Title_En AS AssetClassTitle_En
		
		,D2.Code AS CostCenterDLCode	
		,CC.DLRef AS CostCenterDLRef
		,D.Title AS CostCenterTitle
		,D.Title_En AS CostCenterTitle_En
		,A.[EmplacementRef]		
		,E.Title AS EmplacementTitle
		,E.Title_EN AS EmplacementTitle_En
		,A.[ReceiverPartyRef]
		,  P.Name + ' ' + ISNULL(P.LastName, '')  ReceiverPartyName
		,dl2.Code AS ReceiverPartyCode
		,A.[IsInitial]
		,A.[Version]				
		,A.[Creator]				
		,A.[CreationDate]			
		,A.[LastModifier]			
		,A.[LastModificationDate]	
		,A.[Description]
		,A.[Details]
		,case when A.[IsInitial] = 1 THEN 4
				ELSE Ar.[Type]
			END AS AcquisitionReceiptType 
		,CP.DepreciationMethodType
		,cp.UsefulLife
		,LK.Title AS DepreciationMethodTypeTitle
		,CP.DepreciationRate	
		,CalDate.LastCalculationDate	
		, Case WHEN A.[State] = 4  THEN 1
			   WHEN (NOT Exists(Select depreciationState
									FROM AST.CostPart cpd
									WHERE cpd.AssetRef = a.AssetId	
									AND cpd.depreciationState <> 1 )) THEN 1	
			   WHEN (Exists(select TransactionType
							 from ast.AssetTransaction TT
							Where TT.AssetRef = a.AssetId	
								AND TT.assetstate = 4)) THEN 1													
				ELSE 2
			END AS  DepreciationState  
		, u.Name AS CreatorName
		, u.Name_En AS CreatorName_En
		, CASE WHEN EXISTS 
			(SELECT 1 
			 FROM AST.AssetRelatedPurchaseInvoice 
			 WHERE AcquisitionReceiptItemRef = ARI.AcquisitionReceiptItemId 
					AND PurchaseInvoiceItemRef IS NOT NULL )
			THEN 1
		 ELSE 0 END AS IsImportPurchase
		, ARI.TotalCost AS AcquisitionReceiptItemTotalCost
		
	FROM AST.Asset A
		LEFT JOIN AST.vwAstCostCenter CC 
			ON CC.DlRef = A.CostCenterDlRef 
		LEFT JOIN ACC.DL D 
			ON D.DLId = CC.DLRef
		LEFT JOIN AST.Emplacement e 
			ON E.EmplacementId = A.EmplacementRef	
		LEFT JOIN AST.AssetGroup ag 
			ON AG.AssetGroupID = A.AssetGroupRef
		LEFT JOIN AST.AssetClass ac 
			ON Ac.AssetClassID = Ag.AssetClassRef				
		LEFT JOIN GNR.Party p		
			ON P.[PartyID] = A.[ReceiverPartyRef]	
		LEFT JOIN AST.AcquisitionReceiptItem ARI ON ARI.AssetRef = A.AssetID		
		LEFT JOIN AST.AcquisitionReceipt AR ON AR.AcquisitionReceiptID = ARI.AcquisitionReceiptRef
		LEFT JOIN ACC.DL dl2 ON p.DLRef = dl2.DLId	
		LEFT JOIN (SELECT cp1.CostPartId, DepreciationMethodType, DepreciationRate, cp1.AssetRef, cp1.UsefulLife
		             FROM AST.CostPart cp1 WHERE cp1.CostPartType = 1 ) AS cp ON cp.AssetRef = a.AssetId
		LEFT JOIN (SELECT Title, Code 
		             FROM fmk.Lookup l 
		             WHERE l.[Type] = 'DepreciationMethod' 
						AND l.[System] = 'AST') AS LK ON cp.DepreciationMethodType = LK.Code
       LEFT JOIN (select assetRef, Max(ActivityDate) LastCalculationDate
						from ast.AssetTransaction t 
					Where t.TransactionType = 99
					Group by assetref) AS CalDate ON CalDate.assetref = a.AssetId
	   LEFT JOIN ACC.DL d2 ON d2.DLId = cc.DLRef        
	   LEFT JOIN FMK.[User] u ON u.UserID = A.Creator  				
		
)
