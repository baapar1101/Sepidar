If Object_ID('SLS.vwSaleType') Is Not Null
	Drop View SLS.vwSaleType
GO
CREATE view SLS.vwSaleType as  
SELECT     S.SaleTypeId, S.Number, S.Title, S.Title_En, S.Version, S.Creator, S.CreationDate, S.LastModifier, S.LastModificationDate, S.SaleTypeMarket, S.PartSalesSLRef,   
                      Acc1.FullCode AS PartSalesSLCode, Acc1.Title AS PartSalesSLTitle, S.ServiceSalesSLRef, Acc2.FullCode AS ServiceSalesSLCode,   
                      Acc2.Title AS ServiceSalesSLTitle, S.PartSalesReturnSLRef, Acc3.FullCode AS PartSalesReturnSLCode, Acc3.Title AS PartSalesReturnSLTitle,   
                      S.ServiceSalesReturnSLRef, Acc4.FullCode AS ServiceSalesReturnSLCode, Acc4.Title AS ServiceSalesReturnSLTitle, S.PartSalesDiscountSLRef,   
                      Acc5.FullCode AS PartSalesDiscountSLCode, Acc5.Title AS PartSalesDiscountSLTitle, S.ServiceSalesDiscountSLRef,   
                      Acc6.FullCode AS ServiceSalesDiscountSLCode, Acc6.Title AS ServiceSalesDiscountSLTitle, S.SalesAdditionSLRef, Acc7.FullCode AS SalesAdditionSLCode,   
                      Acc7.Title AS SalesAdditionSLTitle  
FROM         SLS.SaleType AS S LEFT OUTER JOIN  
                      ACC.vwAccount AS Acc1 ON S.PartSalesSLRef = Acc1.AccountId LEFT OUTER JOIN  
                      ACC.vwAccount AS Acc2 ON S.ServiceSalesSLRef = Acc2.AccountId LEFT OUTER JOIN  
                      ACC.vwAccount AS Acc3 ON S.PartSalesReturnSLRef = Acc3.AccountId LEFT OUTER JOIN  
                      ACC.vwAccount AS Acc4 ON S.ServiceSalesReturnSLRef = Acc4.AccountId LEFT OUTER JOIN  
                      ACC.vwAccount AS Acc5 ON S.PartSalesDiscountSLRef = Acc5.AccountId LEFT OUTER JOIN  
                      ACC.vwAccount AS Acc6 ON S.ServiceSalesDiscountSLRef = Acc6.AccountId LEFT OUTER JOIN  
                      ACC.vwAccount AS Acc7 ON S.SalesAdditionSLRef = Acc7.AccountId


