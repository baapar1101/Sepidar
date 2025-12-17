If Object_ID('INV.vwInventoryDeliveryReturn') Is Not Null
	Drop View INV.vwInventoryDeliveryReturn
GO
CREATE VIEW [INV].[vwInventoryDeliveryReturn]
AS
SELECT     ID.InventoryDeliveryID, ID.IsReturn, ID.Type, ID.StockRef, S.Code AS StockCode, S.Title AS StockTitle, S.Title_En AS StockTitle_En, ID.ReceiverDLRef, 
                      ACC.DL.Code AS DLCode, ACC.DL.Title AS DLTitle, ACC.DL.Title_En AS DLTitle_En, ID.Number, ID.Date, ID.AccountingVoucherRef, 
                      ACC.Voucher.Number AS AccountingVoucherNumber, ACC.Voucher.Date AS AccountingVoucherDate, ID.TotalPrice, ID.[Description], ID.FiscalYearRef, ID.Creator, 
                      ID.CreationDate, ID.LastModifier, ID.LastModificationDate, ID.Version,
                      U.Name AS CreatorName, U.Name_En AS CreatorName_En
					  ,[HDIDI].[HotDistributionNumber]
FROM         INV.InventoryDelivery AS ID INNER JOIN
                      INV.Stock AS S ON ID.StockRef = S.StockID INNER JOIN
                      ACC.DL ON ID.ReceiverDLRef = ACC.DL.DLId AND ID.ReceiverDLRef = ACC.DL.DLId LEFT OUTER JOIN
                      ACC.Voucher ON ID.AccountingVoucherRef = ACC.Voucher.VoucherId LEFT JOIN
                      FMK.[User] AS U ON (ID.Creator = U.UserID)
			LEFT JOIN [DST].[vwHotDistributionInventoryDeliveryIds] AS [HDIDI] 
				ON [ID].[InventoryDeliveryID] =  [HDIDI].[InventoryDeliveryRef]
WHERE     (ID.IsReturn = 1)

GO