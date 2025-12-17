If Object_ID('AST.vwAssetTransaction') Is Not Null
	Drop View AST.vwAssetTransaction
GO
CREATE VIEW [AST].[vwAssetTransaction] AS 
SELECT	AssetTransactionID
		,TransactionType
        ,AT.AssetTransactionRef
        ,AT.AssetRef
        ,AssetPlaque = A.PlaqueNumber
		,AssetTitle = A.Title
		,AssetTitle_En = A.Title_En
        ,AssetState
        ,AT.CostCenterDlRef
        ,AT.AssetGroupRef
        ,AT.EmplacementRef
        ,AT.ReceiverPartyRef
        ,FiscalYearRef
        ,ActivityDate
        ,ActivityNumber
        ,ActivityRef
		,[OperationDate] = 
			CASE AT.TransactionType
				WHEN 1  THEN AcqusitionReceipt.[Date] --AcqusitionReceipt
				WHEN 10 THEN Repair.[Date] --Repair 
				ELSE AT.ActivityDate
			END
	   ,UsedPreviousDeprecitions = CASE 
	                                    WHEN TransactionType = 99 /*Deprecition*/              THEN 1
	                                    WHEN TransactionType =  9 /*ChangeDepreciationMethod*/ THEN 1
	                                    WHEN Sale        .UsedPreviousDeprecitions IS NOT NULL THEN Sale        .UsedPreviousDeprecitions
	                                    WHEN Elimination .UsedPreviousDeprecitions IS NOT NULL THEN Elimination .UsedPreviousDeprecitions
	                                    WHEN Salvage     .UsedPreviousDeprecitions IS NOT NULL THEN Salvage     .UsedPreviousDeprecitions
										ELSE 0
								   END
FROM AST.AssetTransaction AT
	JOIN AST.Asset A ON AT.AssetRef = A.AssetId
LEFT JOIN (
            SELECT A.AssetTransactionRef, B.[Date]
            FROM      AST.AcquisitionReceiptItem A 
            LEFT JOIN AST.AcquisitionReceipt     B ON A.AcquisitionReceiptRef = B.AcquisitionReceiptID
           )AcqusitionReceipt ON AT.AssetTransactionID = AcqusitionReceipt.AssetTransactionRef
LEFT JOIN (
            SELECT A.AssetTransactionRef, B.[Date]
            FROM      AST.RepairItem A 
            LEFT JOIN AST.Repair     B ON A.RepairRef = B.RepairID
           )Repair ON AT.AssetTransactionID = Repair.AssetTransactionRef
LEFT JOIN (
            SELECT    A.AssetTransactionRef, 
			          UsedPreviousDeprecitions = SIGN(ISNULL(B.VoucherRef,0))
            FROM      AST.SaleItem A 
            LEFT JOIN AST.Sale     B ON A.SaleRef = B.SaleID
           )Sale ON AT.AssetTransactionID = Sale.AssetTransactionRef
LEFT JOIN (
            SELECT    A.AssetTransactionRef, 
			          UsedPreviousDeprecitions = SIGN(ISNULL(B.VoucherRef,0))
            FROM      AST.EliminationItem A 
            LEFT JOIN AST.Elimination     B ON A.EliminationRef = B.EliminationID
           )Elimination ON AT.AssetTransactionID = Elimination.AssetTransactionRef
LEFT JOIN (
            SELECT    A.AssetTransactionRef, 
			          UsedPreviousDeprecitions = SIGN(ISNULL(B.VoucherRef,0))
            FROM      AST.SalvageItem     A 
            LEFT JOIN AST.Salvage         B ON A.SalvageRef = B.SalvageID
           )Salvage ON AT.AssetTransactionID = Salvage.AssetTransactionRef
GO

