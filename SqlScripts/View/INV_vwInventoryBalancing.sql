If Object_ID('INV.vwInventoryBalancing') Is Not Null
	Drop View INV.vwInventoryBalancing
GO
CREATE VIEW [INV].[vwInventoryBalancing]
AS
SELECT		IB.InventoryBalancingId, IB.Number, IB.StockRef, S.Code AS StockCode, S.Title AS StockTitle, S.Title_En AS StockTitle_En,
					IB.OperatorDLRef, OPDL.Code AS OperatorDLCode, OPDL.Title AS OperatorDLTitle, OPDL.Title_En AS OperatorDLTitle_En,
					IB.RedundancySLRef, RSL.Code AS RedundancySLCode, RSL.Title AS RedundancySLTitle, RSL.Title_En AS RedundancySLTitle_En,
					IB.RedundancyDLRef, RDL.Code AS RedundancyDLCode, RDL.Title AS RedundancyDLTitle, RDL.Title_En AS RedundancyDLTitle_En,
					IB.ShortageSLRef, [SSL].Code AS ShortageSLCode, [SSL].Title AS ShortageSLTitle, [SSL].Title_En AS ShortageSLTitle_En, 
					IB.ShortageDLRef, SDL.Code AS ShortageDLCode, SDL.Title AS ShortageDLTitle, SDL.Title_En AS ShortageDLTitle_En,
					IB.[Date], IB.FiscalYearRef, IB.ItemMinQuantity, [SSL].HasDL AS ShortageSLHasDL, RSL.HasDL AS RedundancySLHasDL,
					IB.[Description], IB.Description_En, IB.InventoryReceiptRef, IB.InventoryDeliveryRef, IB.[State],
					IB.[Version], IB.Creator, IB.CreationDate, IB.LastModifier, IB.LastModificationDate,
					IR.Number AS InventoryReceiptNumber, ID.Number AS InventoryDeliveryNumber
FROM INV.InventoryBalancing IB
	JOIN INV.Stock S ON IB.StockRef = S.StockId
	JOIN ACC.DL OPDL ON OPDL.DLId = IB.OperatorDLRef
	LEFT JOIN ACC.vwAccount RSL ON RSL.AccountId = IB.RedundancySLRef
	LEFT JOIN ACC.DL RDL ON RDL.DLId = IB.RedundancyDLRef
	LEFT JOIN ACC.vwAccount [SSL] ON [SSL].AccountId = IB.RedundancyDLRef
	LEFT JOIN ACC.DL SDL ON SDL.DLId = IB.ShortageDLRef
	LEFT JOIN INV.InventoryDelivery ID ON ID.InventoryDeliveryId = IB.InventoryDeliveryRef
	LEFT JOIN INV.InventoryReceipt IR ON IR.InventoryReceiptId = IB.InventoryReceiptRef