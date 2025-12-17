If Object_ID('INV.vwItemStockSummary') Is Not Null
	Drop View INV.vwItemStockSummary
GO
CREATE VIEW INV.vwItemStockSummary
AS
SELECT     ISS.ItemStockSummaryID, ISS.StockRef, S.Title StockTitle, ISS.ItemRef, INV.Item.Title AS ItemTitle,INV.Item.MinimumAmount AS ItemMinimumAmount ,INV.Item.MaximumAmount AS ItemMaximumAmount,
                      INV.Item.Code As ItemCode,
                      INV.Item.Title_En AS ItemTitle_En, ISS.TracingRef, INV.Tracing.Title AS TracingTitle, ISS.UnitRef, 
                      INV.Unit.Title AS UnitTitle, INV.Unit.Title_En AS UnitTitle_En, ISS.InputQuantity, ISS.OutputQuantity, 
                      ISS.Quantity, ISS.[Order], ISS.SaleQuantity, ISS.FiscalYearRef,
					  ISS.SaleWithReserveQuantity , ISS.FeedFromClosingOperation
FROM         INV.ItemStockSummary ISS INNER JOIN
                      INV.Item ON ISS.ItemRef = INV.Item.ItemID INNER JOIN
		      INV.Stock S ON ISS.StockRef = S.StockID INNER JOIN
                      INV.Unit ON ISS.UnitRef = INV.Unit.UnitID LEFT OUTER JOIN
                      INV.Tracing ON ISS.TracingRef = INV.Tracing.TracingID