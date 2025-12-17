If Object_ID('INV.vwInventoryDeliveryItem') Is Not Null
	Drop View INV.vwInventoryDeliveryItem
GO
CREATE VIEW [INV].[vwInventoryDeliveryItem]
AS
SELECT     IDI.InventoryDeliveryItemID, IDI.InventoryDeliveryRef, IDI.IsReturn, IDI.RowNumber, IDI.BaseInvoiceItem, IDI.BaseInventoryDeliveryItem, IDI.ItemRequestItemRef, 
                      IDI.BaseReturnedInvoiceItem, IDI.ItemRef, I.Code AS ItemCode, IDI.ItemDescription, I.BarCode AS BarCode, I.Title AS ItemTitle, I.Title_En AS ItemTitle_En, I.UnitRef, U1.Title AS UnitTitle, 
                      U1.Title_En AS UnitTitle_En, I.SecondaryUnitRef, U2.Title AS SecondaryUnitTitle, U2.Title_En AS SecondaryUnitTitle_En, I.IsUnitRatioConstant, 
                      I.SerialTracking,
                      I.PropertyAmounts,
                      I.UnitsRatio, I.TracingCategoryRef, IDI.TracingRef, INV.Tracing.Title AS TracingTitle, IDI.Quantity, IDI.SecondaryQuantity,
                      IDI.SLAccountRef, AC.Title AS SLAccountTitle, AC.Title_En AS SLAccountTitle_En, IDI.Fee, IDI.Price, IDI.Description, 
                      IDI.Description_En, IDI.[Version],IDI.ProductOrderRef,PO.Number ProductOrderNumber, SLS.Invoice.Number AS BaseInvoiceNumber, SLS.Invoice.Date AS BaseInvoiceDate, POM.ItemRequest.Number AS ItemRequestNumber,
                      ID.StockRef AS InventoryDeliveryStockRef,S.Title InventoryDeliveryStockTitle,S.Code InventoryDeliveryStockCode,ID.ReceiverDLRef AS InventoryDeliveryReceiverDLRef, ID.Number AS InventoryDeliveryNumber, 
                      ID.Date AS InventoryDeliveryDate, AC.FullCode AS SLAccountCode, ID.Type AS InventoryDeliveryType, I.TaxExemptPurchase AS TaxExempt,
                      SLS.Invoice.BaseOnInventoryDelivery AS InvoiceIssuedBaseOnInventoryDelivery, GR.CalculationFormulaRef AS CalculationFormulaRef, 
                      IDI.ParityCheck,  null as ParityCheckHash, IDI.QuotationItemRef, BQI.QuotationNumber, BQI.QuotationDate, BQI.QuotationRef,
                      IDI.WeighingRef, W.Number AS WeighingNumber, W.Date AS WeighingDate
FROM         INV.InventoryDeliveryItem AS IDI
                      INNER JOIN INV.vwItem AS I ON IDI.ItemRef = I.ItemID
                      INNER JOIN INV.InventoryDelivery AS ID ON IDI.InventoryDeliveryRef = ID.InventoryDeliveryID
					  INNER JOIN INV.Stock S ON S.StockID = ID.StockRef
                      LEFT OUTER JOIN INV.Tracing ON IDI.TracingRef = INV.Tracing.TracingID
                      LEFT OUTER JOIN ACC.vwAccount AS AC ON IDI.SLAccountRef = AC.AccountId
                      LEFT OUTER JOIN SLS.Invoice
                      INNER JOIN SLS.InvoiceItem ON SLS.Invoice.InvoiceId = SLS.InvoiceItem.InvoiceRef ON IDI.BaseInvoiceItem = SLS.InvoiceItem.InvoiceItemID
                      LEFT OUTER JOIN POM.ItemRequest
                      INNER JOIN POM.ItemRequestItem ON POM.ItemRequest.ItemRequestId = POM.ItemRequestItem.ItemRequestRef ON IDI.ItemRequestItemRef = POM.ItemRequestItem.ItemRequestItemID
                      LEFT OUTER JOIN INV.Unit AS U1 ON I.UnitRef = U1.UnitID
                      LEFT OUTER JOIN INV.Unit AS U2 ON I.SecondaryUnitRef = U2.UnitID
                      LEFT OUTER JOIN GNR.[Grouping] GR ON I.PurchaseGroupRef=GR.GroupingID
					  LEFT OUTER JOIN WKO.ProductOrder PO ON PO.ProductOrderID = IDI.ProductOrderRef
					  LEFT OUTER JOIN (
						SELECT Q.Number QuotationNumber, Q.Date QuotationDate,
							QI.QuotationItemID, QI.QuotationRef
						FROM SLS.Quotation Q
							INNER JOIN SLS.QuotationItem QI ON Q.QuotationID = QI.QuotationRef) BQI ON IDI.QuotationItemRef = BQI.QuotationItemID
					LEFT OUTER JOIN INV.vwInventoryWeighing W ON IDI.WeighingRef = W.InventoryWeighingID
WHERE     (IDI.IsReturn = 0)