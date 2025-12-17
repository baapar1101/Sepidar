IF EXISTS(select * FROM sys.views where name = 'vwAssetExitFinacial' AND TYPE = 'v')
BEGIN
    DROP view [AST].[vwAssetExitFinacial]
END

GO

CREATE VIEW [AST].[vwAssetExitFinacial]
As 
Select A.*, LK.Title AssetTransactionTypeTitle   
FROM (	select 5 AssetTransactionType,S.SaleId, S.[Date] OperationDate, S.Number, SI.AssetRef,
				(ISNULL(SI.SalePriceInBaseCurrency,0)) SalePriceInBaseCurrency, 
				ISNULL(SI.TotalCost,0) TotalCost,  
				isnull(AccumulatedDepreciation, 0) + isnull(Depreciationvalue ,0) AccumulateDepreciationvalue,
				ISNULL(SaleIncome,0) CostAndProfit
		
		FROM ast.Sale S
			INNER JOIN AST.vwSaleItem SI On S.SaleID = SI.SaleRef			
			INNER JOIN (select assetRef , TotalCost = sum(TotalCost) ,sum(isnull(EstablishmentAccumulatedDepreciation,0)) AccumulatedDepreciation 
				from AST.CostPart 
				group by assetRef ) CP ON CP.assetRef = SI.assetRef
			LEFT JOIN (	select assetref ,sum(isnull(cpt.Depreciationvalue,0)) Depreciationvalue
						from ast.CostPartTransaction cpt 
							inner join  AST.CostPart cp On cpt.CostPartRef = cp.costpartid
						group by assetref )DP ON DP.assetRef = SI.assetRef
		UNION ALL

		select 4 AssetTransactionType, S.EliminationId, S.[Date] OperationDate, S.Number, SI.AssetRef,
				0 SalePriceInBaseCurrency, 
				(ISNULL(CP.TotalCost,0)) TotalCost,
				isnull(AccumulatedDepreciation, 0) + isnull(Depreciationvalue ,0) AccumulateDepreciationvalue,
				ISNULL(SI.LossAmount,0) CostAndProfit
		FROM ast.Elimination S
			INNER JOIN AST.vwEliminationItem SI On S.EliminationID = SI.EliminationRef
			INNER JOIN (select assetRef , TotalCost = sum(TotalCost) ,sum(isnull(EstablishmentAccumulatedDepreciation,0)) AccumulatedDepreciation 
							from AST.CostPart 
							group by assetRef ) CP ON CP.assetRef = SI.assetRef
			LEFT JOIN (	select assetref ,sum(isnull(cpt.Depreciationvalue,0)) Depreciationvalue
						from ast.CostPartTransaction cpt 
							inner join  AST.CostPart cp On cpt.CostPartRef = cp.costpartid
						group by assetref )DP ON DP.assetRef = SI.assetRef							

		UNION ALL
		select 6 AssetTransactionType, S.SalvageId, S.[Date] OperationDate, S.Number, SI.AssetRef,
				0 SalePriceInBaseCurrency, 
				(ISNULL(SI.TotalCost,0)) TotalCost,
				isnull(AccumulatedDepreciation, 0) + isnull(Depreciationvalue ,0) AccumulateDepreciationvalue,
				ISNULL(SI.LossAmount ,0) CostAndProfit
		FROM ast.Salvage S
			INNER JOIN AST.vwSalvageItem SI On S.SalvageID = SI.SalvageRef
			INNER JOIN (select assetRef , TotalCost = sum(TotalCost), sum(isnull(EstablishmentAccumulatedDepreciation,0)) AccumulatedDepreciation 
							from AST.CostPart 
							group by assetRef ) CP ON CP.assetRef = SI.assetRef
			LEFT JOIN (	select assetref ,sum(isnull(cpt.Depreciationvalue,0)) Depreciationvalue
						from ast.CostPartTransaction cpt 
							inner join  AST.CostPart cp On cpt.CostPartRef = cp.costpartid
						group by assetref )DP ON DP.assetRef = SI.assetRef							
)A
left outer join [fmk].[lookup] LK
	ON LK.[system]= 'AST'
	AND LK.[Type] = 'AssetTransactionType'
	AND LK.Code = A.AssetTransactionType