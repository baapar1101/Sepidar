IF OBJECT_ID('AST.vwDepreciation') IS NOT NULL
	DROP VIEW AST.vwDepreciation
GO
CREATE VIEW AST.vwDepreciation
AS
	SELECT
		   A.DepreciationID
		  ,A.Date
		  ,A.AssetRef
		  ,A.AssetTransactionRef
		  ,A.LastAssetTransactionRef
		  ,A.VoucherRef
		  ,A.FiscalYearRef
		  ,A.Creator
		  ,A.CreationDate
		  ,A.LastModifier
		  ,A.LastModificationDate
		  ,A.Version

		  ,C.DLRef      AS CostCenterDLRef
		  ,C.DLTitle    AS CostCenterTitle
		  ,C.DLTitle_En AS CostCenterTitle_En
		  ,D.AssetClassRef
		  ,D.ClassTitle
		  ,D.AccumulatedDepreciationSLRef
		  ,ISNULL(D1.HasDL, 0)            AS AccumulatedDepreciationSLRefHasDL
		  ,D.DepreciationSLRef
		  ,ISNULL(D2.HasDL, 0)            AS DepreciationSLRefHasDL
		  ,ISNULL(E.DepreciationValue ,0) AS DepreciationValue
		  ,VoucherNumber = VCH.Number
		  ,u.Name AS CreatorName
		  ,u.Name_En AS CreatorName_En
	FROM      AST.Depreciation       A
	LEFT JOIN AST.vwAssetTransaction B  ON A.AssetTransactionRef          = B.AssetTransactionID
	LEFT JOIN AST.vwAstCostCenter  C    ON C.DLRef                 = B.CostCenterDlRef 
	LEFT JOIN AST.vwAssetGroup       D  ON B.AssetGroupRef                = D.AssetGroupID
	LEFT JOIN ACC.Account            D1 ON D.AccumulatedDepreciationSLRef = D1.AccountId
	LEFT JOIN ACC.Account            D2 ON D.DepreciationSLRef            = D2.AccountId
	LEFT JOIN (
	           SELECT AssetTransactionRef, 
	                  DepreciationValue = Sum(DepreciationValue) 
			   FROM AST.CostPartTransaction
			   GROUP BY AssetTransactionRef
			  )E ON A.AssetTransactionRef = E.AssetTransactionRef
    LEFT JOIN ACC.Voucher            VCH ON A.VoucherRef = VCH.VoucherID
    LEFT JOIN FMK.[User] u ON u.UserID = A.Creator
GO
