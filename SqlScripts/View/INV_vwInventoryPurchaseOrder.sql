If Object_ID('INV.vwInventoryPurchaseOrder') Is Not Null
	Drop View INV.vwInventoryPurchaseOrder
GO
--CREATE VIEW INV.vwInventoryPurchaseOrder
--AS
--SELECT     INV.InventoryPurchaseOrder.InventoryPurchaseOrderID, INV.InventoryPurchaseOrder.VendorDLRef, ACC.DL.Code AS DLCode, ACC.DL.Title AS DLTitle, 
--                      ACC.DL.Title_En AS DLTitle_En, INV.InventoryPurchaseOrder.Number, INV.InventoryPurchaseOrder.Date, INV.InventoryPurchaseOrder.FiscalYearRef, 
--                      INV.InventoryPurchaseOrder.Creator, INV.InventoryPurchaseOrder.CreationDate, INV.InventoryPurchaseOrder.LastModifier, 
--                      INV.InventoryPurchaseOrder.LastModificationDate, INV.InventoryPurchaseOrder.Version
--FROM         INV.InventoryPurchaseOrder INNER JOIN
--                      ACC.DL ON INV.InventoryPurchaseOrder.VendorDLRef = ACC.DL.DLId
--
