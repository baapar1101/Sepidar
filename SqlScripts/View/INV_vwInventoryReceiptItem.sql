If Object_ID('INV.vwInventoryReceiptItem') Is Not Null
	Drop View INV.vwInventoryReceiptItem
GO

CREATE VIEW [INV].[vwInventoryReceiptItem]  
AS  
SELECT     RItm.InventoryReceiptItemID, RItm.InventoryReceiptRef, RItm.RowNumber, 
	isnuLl(PRC.Number, RItm.Base) Base, RItm.ItemRef, I.Code AS ItemCode, I.BarCode AS BarCode,  
                      I.Title AS ItemTitle, I.Title_En AS ItemTitle_En, I.UnitRef, U1.Title AS UnitTitle, U1.Title_En AS UnitTitle_En, I.SecondaryUnitRef, U2.Title AS SecondaryUnitTitle,   
                      U2.Title_En AS SecondaryUnitTitle_En, I.IsUnitRatioConstant, I.UnitsRatio, I.TracingCategoryRef, RItm.TracingRef, T.Title AS TracingTitle,  
                      I.SerialTracking,  
                      I.PropertyAmounts,   
                      RItm.Quantity, RItm.SecondaryQuantity, RItm.Fee, RItm.ImportOrderFinalFee,PRCI.PurchaseOrderItemRef AS BasePurchaseOrderItemRef, RItm.CurrencyRef,   
                      RItm.AllotmenedOtherCostInBaseCurrency,
                      C.Title AS CurrencyTitle, C.Title_En AS CurrencyTitle_En, RItm.CurrencyRate, RItm.CurrencyValue, RItm.Price, RItm.Tax, RItm.Duty,  
                      RItm.TaxCurrencyValue,  
                      RItm.DutyCurrencyValue,  
                      RItm.TransportPrice, RItm.TransportTax, RItm.TransportDuty, RItm.TransportDescription, RItm.NetPrice, RItm.Description, RItm.Description_En, RItm.Version,   
                      R.StockRef AS InventoryReceiptStockRef, R.DelivererDLRef AS InventoryReceiptDelivererDLRef, R.Number AS InventoryReceiptNumber,  
                      R.Date AS InventoryReceiptDate, R.Type AS InventoryReceiptType, R.PurchaseType AS InventoryPurchaseType, RItm.BasePurchaseInvoiceItemRef,RItm.BaseImportPurchaseInvoiceItemRef, I.TaxExemptPurchase AS TaxExempt,  
                      GR.CalculationFormulaRef AS CalculationFormulaRef, R.BaseInventoryDeliveryRef AS InventoryReceiptBaseDeliveryRef,  
       RItm.ParityCheck,RItm.ProductOrderRef, null as ParityCheckHash,RItm.InventoryDeliveryItemRef,  
       RItm.WeighingRef, W.Number AS WeighingNumber, W.Date AS WeighingDate,pii.PurchaseInvoiceDLRef AS BaseDLRef
FROM         INV.InventoryReceiptItem AS RItm INNER JOIN  
                      INV.vwItem AS I ON RItm.ItemRef = I.ItemID INNER JOIN  
                      INV.InventoryReceipt AS R ON RItm.InventoryReceiptRef = R.InventoryReceiptID LEFT OUTER JOIN  
                      GNR.Currency AS C ON RItm.CurrencyRef = C.CurrencyID LEFT OUTER JOIN  
                      INV.Tracing AS T ON RItm.TracingRef = T.TracingID LEFT OUTER JOIN  
                      INV.Unit AS U1 ON I.UnitRef = U1.UnitID LEFT OUTER JOIN  
                      INV.Unit AS U2 ON I.SecondaryUnitRef = U2.UnitID  
                      LEFT OUTER JOIN GNR.[Grouping] GR ON I.PurchaseGroupRef=GR.GroupingID  
                      LEFT OUTER JOIN INV.vwInventoryWeighing W ON RItm.WeighingRef = W.InventoryWeighingID
            LEFT OUTER JOIN POM.vwPurchaseInvoiceItem pii ON pii.PurchaseInvoiceItemID = RItm.BaseImportPurchaseInvoiceItemRef
					  LEFT OUTER JOIN INV.InventoryPurchaseInvoiceItem  PRCI ON  Ritm.BasePurchaseInvoiceItemRef = PRCI.InventoryPurchaseInvoiceItemID
					  LEFT OUTER JOIN INV.InventoryPurchaseInvoice  PRC ON  PRCI.InventoryPurchaseInvoiceRef= PRC.InventoryPurchaseInvoiceID
WHERE     (RItm.IsReturn = 0)