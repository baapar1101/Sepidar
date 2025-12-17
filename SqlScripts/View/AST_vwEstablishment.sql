IF EXISTS (
		SELECT OBJECT_ID FROM sys.objects O WHERE   O.name LIKE 'vwEstablishment' 
												  AND O.schema_id = (
																	SELECT schema_id FROM sys.schemas sch WHERE sch.name LIKE 'AST'))
DROP VIEW AST.vwEstablishment
GO

CREATE VIEW AST.vwEstablishment 
AS
	SELECT   
		  A.[AssetId]				
		, A.[PlaqueNumber]			
		, A.[OldPlaqueNumber]		
		, A.[PlaqueSerial]			
		, A.[Title]					
		, A.[Title_En]				
		, T.[AssetState] AS [State]				
		, T.[AssetGroupRef]			
		, AG.FullCode As AssetGroupFullCode
		, AG.Title AS AssetGroupTitle
		, AG.Title_En AS AssetGroupTitle_En
		, AG.AssetClassRef 
		, AC.Code AS AssetClassCode
		, AC.Title AS AssetClassTitle
		, AC.Title_En AS AssetClassTitle_En
		, CC.[DLRef] AS CostCenterDlRef
		, CC.[DLCode] AS CostCenterDLCode
		, CC.[DLTitle] AS CostCenterDLTitle
		, CC.[DLTitle_En] AS CostCenterDLTitle_En
		, CC.[DLType] AS CostCenterDLType
		, CC.[IsActive] AS CostCenterIsActive
		, T.[EmplacementRef]
		, E.[Code] AS EmplacementCode
		, E.[Title] AS EmplacementTitle
		, E.[Title_En] AS EmplacementTitle_En
		, E.[ParentRef] AS EmplacementParentRef
		, T.[ReceiverPartyRef]
		, P.[FullName] AS ReceiverPartyFullName
		, P.[Name] AS ReceiverPartyName
		, P.[Name_En] AS  ReceiverPartyName_En
		, P.[DLCode] As ReceiverPartyDLCode
		, AQCP.[DepreciationMethodType]	
		, AQCP.[DepreciationRate]			
		, AQCP.[UsefulLife]
		, AQCP.[MaxDepreciableBookValue]
		, AQCP.[SalvageValue]
		, (AQCP.[TotalCost] - AQCP.[AccumulatedDepreciation]) AS DepreciableBookValue
		, AQCP.[AccumulatedDepreciation]	
		, AQCP.[EstablishmentAccumulatedDepreciation]
		, AQCP.[EffectiveDate]
		, AQCP.[AssetRemainingUseFulLife] 
		, AQCP.[AcquisingElapsedLife]	
		, AQCP.[DepreciationState]
		, ISNULL(AQCP.TotalCost,  0) AS TotalCost
		, T.AssetTransactionId AS AssetTransactionRef
		, A.[Description]
		, A.[Details]
		, A.[Version]				
		, A.[Creator]				
		, A.[CreationDate]			
		, A.[LastModifier]			
		, A.[LastModificationDate]	
		
		,u.Name AS CreatorName
		,u.Name_En AS CreatorName_En

	FROM AST.Asset A
		INNER JOIN AST.AssetTransaction T ON T.AssetRef = A.AssetId And  T.Transactiontype = 2 
		LEFT JOIN FMK.[User] u ON u.UserID = A.Creator
		OUTER APPLY(
						SELECT  TOP 1
							  CPT.[DepreciationRate]			
							, CPT.[DepreciationMethodType]	
							, CPT.[UsefulLife]
							, CPT.[MaxDepreciableBookValue]
							, CPT.[SalvageValue]
							, CP.[TotalCost]
							, (CP.[TotalCost] - CP.[AccumulatedDepreciation]) DepreciableBookValue
							, CP.[AccumulatedDepreciation]	
							, CP.[EffectiveDate]
							, (CPT.[UsefulLife] - CPT.[AcquisingElapsedLife])  [AssetRemainingUseFulLife] 
							, CPT.[AcquisingElapsedLife]	
							, CPT.[DepreciationState]
							, CP.[EstablishmentAccumulatedDepreciation]
						FROM AST.CostPartTransaction CPT
							 INNER JOIN AST.CostPart CP on CP.CostPartId = CPT.CostPartRef AND CPT.AssetTransactionRef = T.AssetTransactionID AND CP.AssetRef = A.AssetId
						WHERE  CP.CostPartType = 1 /*Aquisition*/
					)AQCP
		LEFT JOIN AST.vwAstCostCenter CC ON CC.DLRef = T.CostCenterDlRef 
		LEFT JOIN ACC.DL D ON D.DLId = CC.DLRef
		LEFT JOIN AST.vwEmplacement E ON E.EmplacementId = T.EmplacementRef	
		LEFT JOIN AST.vwAssetGroup AG ON AG.AssetGroupID = T.AssetGroupRef
		LEFT JOIN AST.vwAssetClass AC ON Ac.AssetClassID = AG.AssetClassRef				
		LEFT JOIN GNR.vwParty P	ON P.[PartyID] = T.[ReceiverPartyRef]	
			
	WHERE A.IsInitial = 1
GO
