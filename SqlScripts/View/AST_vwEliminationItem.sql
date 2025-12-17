IF EXISTS(select * FROM sys.views where name = 'vwEliminationItem' AND TYPE = 'v')
BEGIN
    DROP view [AST].[vwEliminationItem]
END

GO

CREATE VIEW [AST].[vwEliminationItem]
As
SELECT  si.EliminationItemID
       ,si.AssetRef
       ,EliminationRef
       ,si.[Description]
       ,ac.Title AS AssetClassTitle
       ,ag.AssetClassRef
       ,si.[Description_En]
       ,si.AssetTransactionRef
       ,a.PlaqueNumber
       ,a.Title As AssetTitle
       ,a.Title_En AS AssetTitle_En
       ,a.CostCenterDlRef       
       ,d.Title AS CostCenterTitle
       ,a.EmplacementRef
       ,e.Title AS EmplacementTitle 
       ,a.AssetGroupRef
       ,ag.Title AS AssetGroupTitle            
       ,ISNULL(cst.TotalCost, 0) AS TotalCost
       ,
        CASE WHEN  s.VoucherRef IS Not NUll  THEN
				   CASE WHEN Exists(select 1 From ast.assettransaction t
									 Where  T.assettransactionid = TR.AssetTransactionRef
										And T.AssetState = 4)THEN
						- ISNULL(SumSalvageValue, 0) 
					ELSE 
						-(ISNULL(cst.TotalCost, 0) - AST.fnGetAccumulatedDepreciation(si.AssetRef , s.[Date]) 
																			-  ISNULL(AccumulatedDepreciation,0)	) 
					END
			ELSE null
		END LossAmount  
				      
FROM   AST.EliminationItem si
       INNER JOIN AST.Elimination s  ON  si.EliminationRef = s.EliminationID
		inner join ast.assettransaction tr On si.AssetTransactionRef = tr.assettransactionid       
       LEFT JOIN AST.Asset a ON a.AssetId = si.AssetRef 
       LEFT JOIN FMK.FiscalYear fy ON fy.FiscalYearId = s.FiscalYearRef
       LEFT JOIN AST.Emplacement e ON e.EmplacementId = a.EmplacementRef
       LEFT JOIN AST.AssetGroup ag ON ag.AssetGroupID = a.AssetGroupRef  
       LEFT JOIN AST.AssetClass ac ON ac.AssetClassID = ag.AssetClassRef
       LEFT JOIN AST.vwAstCostCenter CC ON cc.DLRef = a.CostCenterDlRef   
       LEFT JOIN ACC.DL d ON d.DLId = cc.DLRef         
              LEFT JOIN (
       	          SELECT AssetRef , TotalCost = SUM(TotalCost),
       							SumSalvageValue = Sum(ISNULL(SalvageValue, 0)) ,
									AccumulatedDepreciation = SUM(ISNULL(EstablishmentAccumulatedDepreciation,0))
       	          FROM ASt.CostPart cp
       	          Group By AssetRef  ) cst ON si.AssetRef = cst.AssetRef
         


