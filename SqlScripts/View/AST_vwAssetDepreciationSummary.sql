IF EXISTS (
		SELECT OBJECT_ID FROM sys.objects O WHERE   O.name LIKE 'vwAssetDepreciationSummary' 
												  AND O.schema_id = (
																	SELECT schema_id FROM sys.schemas sch WHERE sch.name LIKE 'AST'))
DROP VIEW AST.vwAssetDepreciationSummary
GO

CREATE VIEW AST.vwAssetDepreciationSummary
AS(
	SELECT  
		 A.[AssetId]				
		,A.[PlaqueNumber]			
		,A.[OldPlaqueNumber]		
		,A.[Title]					
		,A.[Title_En]				
		,A.[State]
		,A.[IsInitial]
		,A.[Description]
		,A.[Details]
		,CASE WHEN A.[IsInitial] = 1 THEN 4
				ELSE Ar.[Type]
			END AS AcquisitionReceiptType 
		,CP.DepreciationMethodType
		,CP.UsefulLife
		,CP.DepreciationRate	
		,CalDate.LastCalculationDate	
		,CASE WHEN A.[State] = 4  THEN 1
			   WHEN (NOT EXISTS(SELECT depreciationState
								FROM AST.CostPart cpd
								WHERE     cpd.AssetRef = a.AssetId	
									  AND cpd.depreciationState <> 1 )) 
			   THEN 1	
			   WHEN (Exists(SELECT TransactionType
							FROM ast.AssetTransaction TT
							WHERE     TT.AssetRef = a.AssetId	
								  AND TT.assetstate = 4)) 
			   THEN 1													
			   ELSE 2
		  END AS  DepreciationState
		,A.[AssetGroupRef]			
		,AG.Title AS AssetGroupTitle
		,AG.Title_En AS assetGroupTitle_En
		,AG.AssetClassRef, AC.Title AS AssetClassTitle , AC.Title_En AS AssetClassTitle_En		
		,D2.Code AS CostCenterDLCode	
		,A.CostCenterDlRef  AS CostCenterDLRef
		,D.Title AS CostCenterTitle
		,D.Title_En AS CostCenterTitle_En
		,A.[EmplacementRef]		
		,E.Title AS EmplacementTitle
		,E.Title_EN AS EmplacementTitle_En
		,A.[ReceiverPartyRef]
		,P.Name + ' ' + ISNULL(P.LastName, '')  ReceiverPartyName
		,dl2.Code AS ReceiverPartyCode  
	FROM AST.Asset A
		LEFT JOIN ACC.DL D 
			ON D.DLId =  A.CostCenterDlRef 
		LEFT JOIN AST.Emplacement e 
			ON E.EmplacementId = A.EmplacementRef	
		LEFT JOIN AST.AssetGroup ag 
			ON AG.AssetGroupID = A.AssetGroupRef
		LEFT JOIN AST.AssetClass ac 
			ON Ac.AssetClassID = Ag.AssetClassRef				
		LEFT JOIN GNR.Party p		
			ON P.[PartyID] = A.[ReceiverPartyRef]	
		LEFT JOIN AST.AcquisitionReceiptItem ARI 
		  ON ARI.AssetRef = A.AssetID
		LEFT JOIN AST.AcquisitionReceipt AR 
		  ON AR.AcquisitionReceiptID = ARI.AcquisitionReceiptRef
		LEFT JOIN ACC.DL dl2 
		  ON p.DLRef = dl2.DLId	
		LEFT JOIN (SELECT cp1.CostPartId, DepreciationMethodType, DepreciationRate, cp1.AssetRef, cp1.UsefulLife
		           FROM AST.CostPart cp1 
		           WHERE cp1.CostPartType = 1 ) AS cp 
		  ON cp.AssetRef = a.AssetId
        LEFT JOIN (SELECT assetRef, Max(ActivityDate) LastCalculationDate
				   FROM ast.AssetTransaction t 
				   WHERE t.TransactionType = 99
				   GROUP BY assetref) AS CalDate  ON CalDate.assetref = a.AssetId
	    LEFT JOIN ACC.DL d2  ON d2.DLId = A.CostCenterDlRef       
	    --LEFT JOIN FMK.[User] u ON u.UserID = A.Creator           				
					
		
)
