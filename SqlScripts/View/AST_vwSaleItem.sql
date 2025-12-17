IF EXISTS(select * FROM sys.views where name = 'vwSaleItem' AND TYPE = 'v')
BEGIN
    DROP view [AST].[vwSaleItem]
END

GO

CREATE VIEW [AST].[vwSaleItem]
As
SELECT  SaleItemID
       ,si.AssetRef       
       ,SaleRef
       ,SalePrice
       ,si.SalePriceInBaseCurrency
       ,si.Tax
       ,si.TaxInBaseCurrency
       ,si.Duty
       ,si.DutyInBaseCurrency	   
       ,si.[Description]
       ,si.[Description_En]
       ,si.AssetTransactionRef
       ,a.PlaqueNumber
       ,a.Title As AssetTitle
       ,a.Title_En AS AssetTitle_En  
       ,cc.DLRef AS CostCenterDLRef
       ,d.Title AS CostCenterTitle
       ,a.EmplacementRef
       ,e.Title AS EmplacementTitle 
       ,a.AssetGroupRef
       ,ag.Title AS AssetGroupTitle    
       ,ag.AssetClassRef
       ,ISNULL(cst.TotalCost, 0) AS TotalCost
       ,CASE WHEN  s.VoucherRef IS Not NUll  THEN
				   CASE WHEN Exists(select 1 From ast.assettransaction t
									 Where  T.assettransactionid = TR.AssetTransactionRef
										And T.AssetState = 4)THEN
						si.SalePriceInBaseCurrency - ISNULL(SumSalvageValue, 0) 
					ELSE 
						si.SalePriceInBaseCurrency - (ISNULL(cst.TotalCost, 0) - AST.fnGetAccumulatedDepreciation(si.AssetRef , s.[Date]) 
																			-  ISNULL(AccumulatedDepreciation,0)	) 
					END
			ELSE null
		END  SaleIncome,
        si.TaxPayerAssetSaleItemMapperRef,
        TM.Serial AS TaxPayerSerial,
        TM.SerialTitle AS TaxPayerSerialTitle,
        TM.TaxRate AS TaxPayerTaxRate
       
  
FROM   AST.SaleItem si
       INNER JOIN AST.Sale s  ON  si.SaleRef = s.SaleID
       inner join ast.assettransaction tr On si.AssetTransactionRef = tr.assettransactionid
       LEFT JOIN AST.Asset a ON a.AssetId = si.AssetRef 
       LEFT JOIN FMK.FiscalYear fy ON fy.FiscalYearId = s.FiscalYearRef
       LEFT JOIN AST.Emplacement e ON e.EmplacementId = a.EmplacementRef
       LEFT JOIN AST.AssetGroup ag ON ag.AssetGroupID = a.AssetGroupRef  
       LEFT JOIN AST.vwAstCostCenter CC ON cc.DLRef = a.CostCenterDlRef   
       LEFT JOIN ACC.DL d ON d.DLId = cc.DLRef  
       LEFT JOIN (
       	          SELECT AssetRef , TotalCost = SUM(ISNULL(TotalCost, 0) ), 
									SumSalvageValue = Sum(ISNULL(SalvageValue, 0)) ,
									AccumulatedDepreciation = SUM(ISNULL(EstablishmentAccumulatedDepreciation,0))
       	          FROM ASt.CostPart cp
       	          Group By AssetRef 
				 ) cst ON si.AssetRef = cst.AssetRef
        LEFT JOIN GNR.TaxPayerAssetSaleItemMapper TM ON si.TaxPayerAssetSaleItemMapperRef = TM.TaxPayerAssetSaleItemMapperID

GO