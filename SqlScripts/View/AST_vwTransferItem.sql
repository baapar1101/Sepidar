If Object_ID('AST.vwTransferItem') Is Not Null
	Drop View AST.vwTransferItem
GO
CREATE VIEW [AST].[vwTransferItem] AS
SELECT T.[TransferItemID]
      , T.[AssetRef]
      , AST.[PlaqueNumber], AST.[Title] AssetTitle, AST.[Title_EN] AssetTitle_En, AST.[State] 
      , T.[PreCostCenterDlRef] PreCostCenterDlRef, PDL.Title AS  PreCostCenterTitle, PDL.Title_En AS PreCostCenterTitle_En 
      , T.[PreEmplacementRef] PreEmplacementRef, PEMP.Title AS PreEmplacementTitle, PEMP.Title_EN AS PreEmplacementTitle_En
	  , T.[PreReceiverPartyRef], PPRT.FullName AS PreReceiverPartyFullName      
      , T.[TransferRef]     
      , T.[AssetTransactionRef], AT.[ActivityDate]
      , T.[CostCenterDlRef], 	DL.Title AS CostCenterTitle, DL.Title_En AS CostCenterTitle_En
      , T.[EmplacementRef], EMP.Title AS EmplacementTitle, EMP.Title_EN AS EmplacementTitle_En
      , T.[ReceiverPartyRef], PRT.FullName AS ReceiverPartyFullName
	  , AST.AssetGroupRef
	  , AST.AssetClassRef
  FROM [AST].[TransferItem] T
		INNER JOIN AST.vwAsset AST ON T.AssetRef = AST.AssetId
		inner join AST.AssetTransaction AT On T.AssetTransactionRef =  AT.AssetTransactionID
		LEFT JOIN AST.vwAstCostCenter PCC ON PCC.Dlref = T.PreCostCenterDlRef 
		LEFT JOIN ACC.DL PDL ON PDL.DLId = PCC.DLRef		
		LEFT JOIN AST.Emplacement PEMP ON PEMP.EmplacementId = T.PreEmplacementRef
		LEFT JOIN GNR.vwParty PPRT ON PPRT.PartyId = T.PreReceiverPartyRef
		
		LEFT JOIN AST.vwAstCostCenter CC ON CC.DLRef = T.CostCenterDlRef 
		LEFT JOIN ACC.DL DL ON DL.DLId = CC.DLRef		
		LEFT JOIN AST.Emplacement EMP ON EMP.EmplacementId = T.EmplacementRef
		LEFT JOIN GNR.vwParty PRT ON PRT.PartyId = T.ReceiverPartyRef
