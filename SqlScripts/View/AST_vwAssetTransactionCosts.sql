IF EXISTS(select * FROM sys.views where name = 'vwAssetTransactionCosts' AND TYPE = 'v')
BEGIN
    DROP view [AST].[vwAssetTransactionCosts]
END

GO

CREATE VIEW [AST].[vwAssetTransactionCosts]
As
SELECT Trans.AssetTransactionID, trans.AssetRef , trans.costcenterdlRef, trans.ActivityDate ,  trans.OperationDate, trans.TransactionType , 
	   [InputTotalCost] = 
		   case trans.TransactionType
			   when 1   then + CostPartTrans.TotalCost                     --'AcquisitionReceipt'
			   when 2   then + CostPartTrans.TotalCost                     --'Initial'
			   when 10  then + CostPartTrans.TotalCost                     --'Repair'
			   else 0
		   end,
		 [AccumulatedDepreciation] = 
		   case trans.TransactionType
			   when 1   then Asset.AccumulatedDepreciation                     --'AcquisitionReceipt'
			   when 2   then Asset.AccumulatedDepreciation                   --'Initial'			  
			   else 0
		   end,   
		[SalvageValue] =
				   case 
					   when trans.TransactionType = 2 and trans.assetstate  = 4   then Asset.SalvageValue--'Salvage'			   
					    when trans.TransactionType = 6   then Asset.SalvageValue--'Salvage'	
					   else 0
		   end
		   ,
	   [OutputTotalCost] = 
		   case trans.TransactionType
			   when 5   then  Asset.TotalCost --'Sale'
			   when 4  then  Asset.TotalCost --'Elimination'
			   else 0
		   end,
	   [DepreciationValue] = 
		   case trans.TransactionType
			   when 99  then DepreciationValue 		   
			   else 0
		   end,

	   [TransactionTypeTitle]= CASE trans.TransactionType
								   when 1   then 'تحصيل'
								   when 2   then 'استقرار'
								   when 10  then 'افزايش قيمت - گسترش الحاق'
								   when 6   then 'اسقاط'
								   when 5   then case when prevTrans.TransactionType = 6 then 'فروش اسقاط شده'  else 'فروش' end
								   when 4  then case when prevTrans.TransactionType = 6 then 'حذف اسقاط شده'   else 'حذف'  end
							   END 
FROM       Ast.vwAssetTransaction trans
Left Join  Ast.vwAssetTransaction prevTrans ON trans.AssetTransactionRef = prevTrans.AssetTransactionID
Left Join (      Select AssetTransactionRef , 
						TotalCost    = Sum(TotalCost   ), 
						SalvageValue = Sum(SalvageValue)  ,
						DepreciationValue = Sum(isnull(DepreciationValue,0)	)				
                 FROM Ast.CostPartTransaction
				 Group By AssetTransactionRef
	       ) CostPartTrans ON trans.AssetTransactionID = CostPartTrans.AssetTransactionRef
Left Join (       
				Select AssetRef , 
				TotalCost    = Sum(TotalCost   ), 
				SalvageValue = Sum(SalvageValue),
				AccumulatedDepreciation = sum(EstablishmentAccumulatedDepreciation)
				From AST.CostPart
				Group By AssetRef
		   )Asset on trans.AssetRef = Asset.AssetRef
Where trans.TransactionType in (1 , 2 , 10 , 4 , 5 , 6, 99)
