
IF OBJECT_ID('AST.fnAssetReview') IS NOT NULL
	DROP FUNCTION AST.fnAssetReview
GO
CREATE FUNCTION Ast.fnAssetReview (@FromDate DateTime , @ToDate DateTime)  
RETURNS TABLE  
AS  
RETURN   
( 
		SELECT 	
		A.AssetId, 
		AG.AssetClassRef,
		Ac.Code AssetClassCode,
		AC.Title AssetClassTitle,
		AC.Title_En AssetClassTitle_En, 
		AC.AssetSLRef,
		Ac.DepreciationSLRef,
		AccumulatedDepreciationSLRef,
		A.AssetGroupRef,
		AG.Code AssetGroupCode,
		Ag.Title AssetGroupTitle,
		Ag.Title_En AssetGroupTitle_En,
		A.PlaqueNumber, 
		A.OldPlaqueNumber,
		A.Title,
		A.Title_En,
		CP.EffectiveDate,
	AccumulatedDepreciation = 
		CASE  WHEN (ISNULL(PREVAT.AssetState ,0)  IN (3,5) ) AND (lastAT.assetState IS NULL )  THEN  0 --salvage
		ELSE ISNULL(ATC.AccumulatedDepreciation,0) 
		END,
	OpeningTotalCost = 
		CASE  WHEN (ISNULL(PREVAT.AssetState ,0)  IN (3,5) ) AND (lastAT.assetState IS NULL )  THEN  0 --salvage
		ELSE ISNULL(ATC.OpeningTotalCost,0) 
		END, 
		InDurationAdditionalTotalCost,
		ISNULL(InDurationDecreaseTotalCost,0) a,	
	InDurationDecreaseTotalCost =  
		CASE WHEN lastAT.assetState IN(3,5) THEN --delete & sale
		InDurationDecreaseTotalCost 
		ELSE 0 END,
		PREVAT.AssetState ,
		ATC.SalvageValue,
	OpeningDepreciation =
		CASE  WHEN (ISNULL(PREVAT.AssetState ,0)  = 4 ) AND (lastAT.assetState IS NULL )  THEN --salvage
			  (OpeningTotalCost - (ATC.SalvageValue  + ISNULL(ATC.AccumulatedDepreciation,0) ))
			 WHEN (ISNULL(PREVAT.AssetState ,0)  IN (3, 5) ) AND (lastAT.assetState IS NULL ) THEN 0			    	
			 ELSE ISNULL(ATC.OpeningDepreciation,0) 
			 END , 
		InDurationAdditionalDepreciation, 
		ATC.HasSalvaged ,
		(OpeningTotalCost + InDurationAdditionalTotalCost ) cost,
	InDurationSalvageDepreciation = 
		CASE WHEN ( ISNULL(lastAT.AssetState ,0)  = 4 ) OR(ATC.HasSalvaged = 1)THEN--salvage
				   ISNULL(SalvagedValue, 0) 
			ELSE 0 END,
								
	InDurationDecreaseDepreciation =
		CASE WHEN lastAT.assetState IN(3,5) THEN --delete & sale
			 InDurationAdditionalDepreciation + ISNULL(ATC.OpeningDepreciation,0) + ISNULL(ATC.AccumulatedDepreciation,0) 
			 ELSE 0
			END,
		EmplacementTitle = E.Title,
		EmplacementTitle_En = E.Title_En,
		ReceiverPartyName = RP.LastName + '  ' + RP.Name,	
		ISNULL(lastAT.assetState , PREVAT.AssetState) AS [State],
		StateTitle = '',
		ClassTitle = AC.Title,
		ClassTitle_En = AC.Title_En,
		GroupTitle = AG.Title,
		GroupTitle_En = AG.Title_En,
		CP.DepreciationMethodType,
		DepreciationMethodTypeTitle = '',
		CP.DepreciationRate,
		CP.UsefulLife,
		ATC.CostCenterDlRef, CC.[Type]  CostCenterType, '' CostCenterTypeTitle,
		CostCenterDLTitle = DL.Title,  CostCenterDLTitle_En = DL.Title_En, 	
		CostCenterState = DL.IsActive, CostCenterCode = DL.Code 					 
	
		FROM AST.vwAsset A
		WITH(NOLOCK)
		LEFT JOIN 
		(
		SELECT ATS.* ,
		CASE 
		WHEN AST.AssetTransactionID IS NULL THEN 0
		ELSE 1
		END AS HasSalvaged
		FROM 
		(
		SELECT 	AT.AssetRef,
				AT.costcenterdlRef,
				OpeningTotalCost =	
					ISNULL(SUM(CASE WHEN (AT.TransactionType = 2) THEN AT.[InputTotalCost]
						WHEN AT.TransactionType <> 2 AND 
						AT.OperationDate < @FromDate  THEN AT.[InputTotalCost] ELSE 0 END), 0),
																	
				InDurationAdditionalTotalCost =	
					ISNULL(SUM(CASE -- WHEN AT.TransactionType = 2 and AT.OperationDate > @FromDate AND AT.OperationDate <= @ToDate  THEN AT.[InputTotalCost]
								WHEN AT.TransactionType <> 2 and AT.OperationDate >= @FromDate AND AT.OperationDate <= @ToDate THEN AT.[InputTotalCost] ELSE 0 END), 0),
																	
				InDurationDecreaseTotalCost =	ISNULL(SUM(CASE WHEN AT.OperationDate >= @FromDate AND AT.OperationDate <= @ToDate THEN AT.[outputTotalCost] ELSE 0 END), 0),						
				OpeningDepreciation =           ISNULL(SUM(CASE WHEN AT.OperationDate < @FromDate THEN AT.DepreciationValue END),0),
				InDurationAdditionalDepreciation =	ISNULL(SUM(CASE WHEN AT.OperationDate >= @FromDate AND AT.OperationDate <= @ToDate THEN AT.DepreciationValue END),0),
				SalvageValue = ISNULL(SUM(SalvageValue),0) ,
				AccumulatedDepreciation = ISNULL(SUM(AccumulatedDepreciation),0) 
				FROM [AST].[vwAssetTransactionCosts] AT
				GROUP BY AT.AssetRef , AT.CostCenterDlRef )
				AS ATS
				LEFT JOIN 
				(
					SELECT DISTINCT *
					FROM Ast.vwAssetTransaction ast 
					WHERE ast.OperationDate >= @FromDate AND ast.OperationDate <= @ToDate
					AND ast.TransactionType = 6
				) AS AST
				ON AST.assetref = ATS.AssetRef
				) ATC
				ON ATC.AssetRef =  A.AssetId
		LEFT JOIN 
		(
			SELECT  ats.assetref , ats.assetState
			FROM [AST].vwAssetTransaction ats
			INNER JOIN
			(
				SELECT assetref ,
				MAX(OperationDate) OperationDate,
				MAX(AssetTransactionId) AssetTransactionId
				FROM [AST].vwAssetTransaction ass
				WHERE ass.OperationDate >= @FromDate AND ass.OperationDate <= @ToDate
				GROUP BY assetref 
			) AT ON  ats.AssetRef = at.assetref AND
			ats.OperationDate = at.OperationDate
			GROUP BY ats.assetref , ats.assetState
		 ) LastAT on lastAt.Assetref = a.assetid			
		INNER JOIN AST.AssetGroup AG 
			ON AG.AssetGroupID = A.AssetGroupRef
		INNER JOIN AST.AssetClass AC 
			ON AC.AssetClassID = AG.AssetClassRef
		LEFT JOIN AST.CostPart CP 
			ON A.AssetId = CP.AssetRef AND CP.CostPartType = 1
		LEFT JOIN (
					SELECT Assetref, 
					ISNULL(SUM(CASE WHEN (cprt.EffectiveDate >= @FromDate AND cprt.EffectiveDate <= @ToDate) THEN 
							cprt.[EstablishmentAccumulatedDepreciation] 
					WHEN cprt.IsInitial =1 THEN 
							cprt.[EstablishmentAccumulatedDepreciation] 
					 ELSE 0 END), 0)AccumulatedDepreciation						
					FROM AST.vwCostPart  cprt
					GROUP BY assetref
				  ) CPR
					ON A.AssetId = CPR.AssetRef
		LEFT JOIN AST.vwAstCostCenter CC 
			ON CC.DLRef = ATC.costcenterdlRef
		LEFT JOIN ACC.DL DL 
			ON DL.DLId = CC.DLRef
		LEFT JOIN AST.Emplacement E 
			ON E.EmplacementId = A.EmplacementRef
		LEFT JOIN GNR.Party RP 
			ON RP.PartyId = A.ReceiverPartyRef
		LEFT JOIN (
					SELECT  asp.assetref , asp.assetState
					FROM [AST].vwAssetTransaction asp
					INNER JOIN(
					SELECT assetref , 
					MAX(OperationDate) OperationDate,
					MAX(AssetTransactionId) AssetTransactionId
					FROM [AST].vwAssetTransaction pss
					WHERE pss.OperationDate <= @FromDate 
					GROUP BY assetref 
					) pat 
						ON  asp.AssetRef = pat.assetref AND
						asp.OperationDate = pat.OperationDate				
					GROUP BY asp.assetref , asp.assetState
					) PREVAT 
						ON PREVAT.Assetref = a.assetid		
			LEFT JOIN ( 
			SELECT 	
			atfs.Assetref, 
			ISNULL(SUM(atfs.[InputTotalCost]),0)-
			(ISNULL(SUM(atfs.DepreciationValue ),0) +
			ISNULL(SUM(atfs.AccumulatedDepreciation),0) +
			ISNULL(SUM(atfs.SalvageValue),0) )SalvagedValue
			FROM [AST].[vwAssetTransactionCosts] atfs
			WHERE  atfs.OperationDate <= @ToDate
			GROUP BY atfs.Assetref) Salvage
				ON Salvage.Assetref = a.assetid	
		)





