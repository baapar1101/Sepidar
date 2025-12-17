If Object_ID('INV.vwStock') Is Not Null
	Drop View INV.vwStock
GO
CREATE VIEW INV.vwStock
AS
SELECT     INV.Stock.StockID, INV.Stock.Code, INV.Stock.Title, INV.Stock.Title_En, INV.Stock.StockClerk, INV.Stock.Phone, INV.Stock.Address, 
                      INV.Stock.Address_En, INV.Stock.AccountSLRef, INV.Stock.Creator, INV.Stock.CreationDate, INV.Stock.LastModifier, INV.Stock.LastModificationDate, 
                      INV.Stock.Version, ACC.Title AS AccountSLTitle, ACC.Title_En AS AccountSLTitle_En, ACC.FullCode AS AccountSLCode, INV.Stock.IsActive
FROM         ACC.vwAccount AS ACC RIGHT OUTER JOIN
                      INV.Stock ON ACC.AccountId = INV.Stock.AccountSLRef
