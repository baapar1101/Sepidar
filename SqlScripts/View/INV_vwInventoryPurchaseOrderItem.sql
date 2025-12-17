If Object_ID('INV.vwInventoryPurchaseOrderItem') Is Not Null
	Drop View INV.vwInventoryPurchaseOrderItem
GO
--CREATE VIEW INV.vwInventoryPurchaseOrderItem
--AS
--SELECT     IPI.InventoryPurchaseOrderItemID, IPI.InventoryPurchaseOrderRef, IPI.RowNumber, IPI.ItemRef, It.Code AS ItemCode, It.Title AS ItemTitle, 
--                      It.Title_En AS ItemTitle_En, It.UnitRef, It.SecondaryUnitRef, It.IsUnitRatioConstant, It.UnitsRatio, IPI.Quantity, IPI.SecondaryQuantity, 
--                      IPI.RemainingQuantity, IPI.RemainingSecondaryQuantity, IPI.Fee, IPI.CurrencyRef, IPI.CurrencyRate, IPI.CurrencyValue, IPI.Price, IPI.Tax, IPI.Duty, 
--                      IPI.NetPrice, IPI.Description, IPI.Description_En, IPI.Version, IP.Number AS InventoryPurchaseOrderNumber, 
--                      IP.Date AS InventoryPurchaseOrderDate
--FROM         INV.Item AS It INNER JOIN
--                      INV.InventoryPurchaseOrderItem AS IPI ON It.ItemID = IPI.ItemRef INNER JOIN
--                      INV.InventoryPurchaseOrder AS IP ON IPI.InventoryPurchaseOrderRef = IP.InventoryPurchaseOrderID
--
