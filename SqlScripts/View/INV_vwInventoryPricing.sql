If Object_ID('INV.vwInventoryPricing') Is Not Null
	Drop View INV.vwInventoryPricing
GO
CREATE VIEW INV.vwInventoryPricing
AS
SELECT     TOP (100) PERCENT INV.InventoryPricing.StockRef, INV.Stock.Title AS StockTitle, INV.Stock.Title_En AS StockTitle_En, INV.Stock.Code AS StockCode,
                      INV.InventoryPricing.InventoryPricingID, INV.InventoryPricing.StartDate, INV.InventoryPricing.EndDate, INV.InventoryPricing.Inputs, 
                      INV.InventoryPricing.Outputs, INV.InventoryPricing.FiscalYearRef,
                      INV.InventoryPricing.Creator, INV.InventoryPricing.CreationDate, INV.InventoryPricing.LastModifier, 
                      INV.InventoryPricing.LastModificationDate, INV.InventoryPricing.Version
FROM         INV.InventoryPricing INNER JOIN
                      INV.Stock ON INV.InventoryPricing.StockRef = INV.Stock.StockID
ORDER BY INV.InventoryPricing.StartDate

