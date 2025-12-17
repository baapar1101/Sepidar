IF EXISTS(select * FROM sys.views where name = 'vwSalvageItem' AND TYPE = 'v')
BEGIN
    DROP view [AST].[vwSalvageItem]
END

GO

CREATE VIEW [AST].[vwSalvageItem]
As
SELECT  si.SalvageItemID
       ,si.AssetRef
       ,SalvageRef
       ,si.[Description]
       ,si.[Description_En]
       ,si.AssetTransactionRef
       ,a.PlaqueNumber
       ,a.Title As AssetTitle
       ,a.Title_En AS AssetTitle_En 
       ,cc.DLRef AS CostCenterDlRef
       ,d.Title AS CostCenterTitle
       ,a.EmplacementRef
       ,e.Title AS EmplacementTitle 
       ,a.AssetGroupRef
       ,ag.Title AS AssetGroupTitle    
       ,ag.AssetClassRef  
       ,ISNULL(cst.TotalCost, 0) AS TotalCost
       , CASE WHEN   S.VoucherRef IS NOT NULL THEN
					(  AST.fnGetAccumulatedDepreciation(si.AssetRef, s.[Date]) 
					 + ISNULL(SumSalvageValue, 0)  + ISNULL(AccumulatedDepreciation,0)
					 - ISNULL(cst.TotalCost, 0)  ) 
			 ELSE 0
		 END LossAmount  
            
FROM   AST.SalvageItem si
       INNER JOIN AST.Salvage s  ON  si.SalvageRef = s.SalvageID
       LEFT JOIN AST.Asset a ON a.AssetId = si.AssetRef 
       LEFT JOIN FMK.FiscalYear fy ON fy.FiscalYearId = s.FiscalYearRef
       LEFT JOIN AST.Emplacement e ON e.EmplacementId = a.EmplacementRef
       LEFT JOIN AST.AssetGroup ag ON ag.AssetGroupID = a.AssetGroupRef  
       LEFT JOIN AST.vwAstCostCenter CC ON cc.DLRef = a.CostCenterDlRef   
       LEFT JOIN ACC.DL d ON d.DLId = cc.DLRef         
       LEFT JOIN (SELECT AssetRef ,TotalCost = SUM(ISNULL(TotalCost, 0) ), 
									SumSalvageValue = Sum(ISNULL(SalvageValue, 0))  ,
									AccumulatedDepreciation = SUM(ISNULL(EstablishmentAccumulatedDepreciation,0))
       	          FROM ASt.CostPart cp
       	          Group By AssetRef  ) cst ON si.AssetRef = cst.AssetRef 
   


       
       


GO


