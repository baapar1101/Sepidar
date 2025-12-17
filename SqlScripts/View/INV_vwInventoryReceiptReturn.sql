If Object_ID('INV.vwInventoryReceiptReturn') Is Not Null
	Drop View INV.vwInventoryReceiptReturn
GO
CREATE VIEW [INV].[vwInventoryReceiptReturn]
AS
SELECT     IR.InventoryReceiptID, IR.IsReturn, IR.Type, IR.PurchaseType, IR.StockRef, INV.Stock.Title AS StockTitle, INV.Stock.Title_En AS StockTitle_En, 
                      INV.Stock.Code AS StockCode, IR.DelivererDLRef, ACC.DL.Title AS DelivererTitle, ACC.DL.Title_En AS DelivererTitle_En, 
                      ACC.DL.Code AS DelivererCode, IR.SLAccountRef, AC.Title AS SLAccountTitle, AC.Title_En AS SLAccountTitle_En, 
                      AC.FullCode AS SLAccountCode, IR.Number, IR.Date, IR.AccountingVoucherRef, ACC.Voucher.Number AS AccountingVoucherNumber, 
                      ACC.Voucher.Date AS AccountingVoucherDate, 
					  IR.TotalPrice, IR.TotalDuty, IR.TotalTax, IR.TotalTransportPrice, IR.TotalNetPrice, 
					  IR.TotalReturnedPrice, IR.TotalReturnedNetPrice, 
					  IR.FiscalYearRef, IR.[Description],IR.TotalOtherCost,
                      IR.Creator, IR.CreationDate, IR.LastModifier, IR.LastModificationDate, IR.Version,
                      U.Name AS CreatorName, U.Name_En AS CreatorName_En
FROM         INV.InventoryReceipt AS IR INNER JOIN
                      INV.Stock ON IR.StockRef = INV.Stock.StockID LEFT OUTER JOIN					  
                      ACC.Voucher ON IR.AccountingVoucherRef = ACC.Voucher.VoucherId LEFT OUTER JOIN
                      ACC.vwAccount AS AC ON IR.SLAccountRef = AC.AccountId LEFT OUTER JOIN
                      ACC.DL ON IR.DelivererDLRef = ACC.DL.DLId LEFT JOIN
                      FMK.[User] AS U ON (IR.Creator = U.UserID)
WHERE     (IR.IsReturn = 1)

GO