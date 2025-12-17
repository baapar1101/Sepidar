If Object_ID('INV.vwInventoryDeliveryReturnItem') Is Not Null
	Drop View INV.vwInventoryDeliveryReturnItem
GO
CREATE VIEW [INV].[vwInventoryDeliveryReturnItem]
AS
SELECT     IDI.InventoryDeliveryItemID, IDI.InventoryDeliveryRef, IDI.IsReturn, IDI.RowNumber, IDI.BaseInventoryDeliveryItem, IDI.BaseReturnedInvoiceItem, 
                      IDI.ItemRef, IT.Code AS ItemCode, IT.BarCode AS BarCode, IT.Title AS ItemTitle, IT.Title_En AS ItemTitle_En, IT.UnitRef, U1.Title AS UnitTitle, U1.Title_En AS UnitTitle_En, 
                      IT.SecondaryUnitRef, U2.Title AS SecondaryUnitTitle, U2.Title_En AS SecondaryUnitTitle_En, IT.IsUnitRatioConstant, IT.UnitsRatio,
                      IT.SerialTracking,
                      IT.PropertyAmounts, 
                      IT.TracingCategoryRef, IDI.TracingRef, INV.Tracing.Title AS TracingTitle, IDI.Quantity, IDI.SecondaryQuantity, IDI.RemainingQuantity, 
                      IDI.RemainingSecondaryQuantity, IDI.SLAccountRef, AC.FullCode AS SLAccountCode, AC.Title AS SLAccountTitle, AC.Title_En AS SLAccountTitle_En, 
                      IDI.Fee, IDI.Price, IDI.Description, IDI.Description_En, IDI.Version, ReturnD.Number AS BaseInventoryDeliveryNumber, 
                      ReturnD.Date AS BaseInventoryDeliveryDate, SLS.ReturnedInvoice.Number AS BaseReturnedInvoiceNumber, 
                      SLS.ReturnedInvoice.Date AS BaseReturnedInvoiceDate, ReturnDI.Fee AS BaseInventoryDeliveryItemFee, IT.TaxExemptPurchase AS TaxExempt,
                      GR.CalculationFormulaRef AS CalculationFormulaRef,
                      IDI.WeighingRef, W.Number AS WeighingNumber, W.Date AS WeighingDate
FROM         INV.Tracing RIGHT OUTER JOIN
                      INV.InventoryDeliveryItem AS IDI INNER JOIN
                      INV.vwItem AS IT ON IDI.ItemRef = IT.ItemID LEFT OUTER JOIN
                      INV.InventoryDelivery AS ReturnD INNER JOIN
                      INV.InventoryDeliveryItem AS ReturnDI ON ReturnD.InventoryDeliveryID = ReturnDI.InventoryDeliveryRef ON 
                      IDI.BaseInventoryDeliveryItem = ReturnDI.InventoryDeliveryItemID LEFT OUTER JOIN
                      ACC.vwAccount AS AC ON IDI.SLAccountRef = AC.AccountId ON INV.Tracing.TracingID = IDI.TracingRef LEFT OUTER JOIN
                      SLS.ReturnedInvoiceItem INNER JOIN
                      SLS.ReturnedInvoice ON SLS.ReturnedInvoiceItem.ReturnedInvoiceRef = SLS.ReturnedInvoice.ReturnedInvoiceId ON 
                      IDI.BaseReturnedInvoiceItem = SLS.ReturnedInvoiceItem.ReturnedInvoiceItemID LEFT OUTER JOIN
                      INV.Unit AS U1 ON IT.UnitRef = U1.UnitID LEFT OUTER JOIN
                      INV.Unit AS U2 ON IT.SecondaryUnitRef = U2.UnitID
                      LEFT OUTER JOIN GNR.[Grouping] GR ON IT.PurchaseGroupRef=GR.GroupingID
                      LEFT OUTER JOIN INV.vwInventoryWeighing W ON IDI.WeighingRef = W.InventoryWeighingID
WHERE     (IDI.IsReturn = 1)