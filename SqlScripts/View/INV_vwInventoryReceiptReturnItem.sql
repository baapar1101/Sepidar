If Object_ID('INV.vwInventoryReceiptReturnItem') Is Not Null
	Drop View INV.vwInventoryReceiptReturnItem
GO
CREATE VIEW [INV].[vwInventoryReceiptReturnItem]
AS
SELECT     RItem.InventoryReceiptItemID, RItem.InventoryReceiptRef, RItem.IsReturn, RItem.RowNumber, RItem.ReturnBase, RItem.ItemRef, I.Code AS ItemCode, I.BarCode AS BarCode,
                      I.Title AS ItemTitle, I.Title_En AS ItemTitle_En, I.UnitRef, U1.Title AS UnitTitle, U1.Title_En AS UnitTitle_En, I.SecondaryUnitRef, 
                      U2.Title AS SecondaryUnitTitle, U2.Title_En AS SecondaryUnitTitle_En, I.IsUnitRatioConstant, I.UnitsRatio, I.TracingCategoryRef, RItem.TracingRef,
                      I.SerialTracking,
                      I.PropertyAmounts, 
                      T.Title AS TracingTitle, RItem.Quantity, RItem.SecondaryQuantity, RItem.Fee, RItem.CurrencyRef, C.Title AS CurrencyTitle, 
                      C.Title_En AS CurrencyTitle_En, RItem.CurrencyRate, RItem.CurrencyValue, RItem.Price, RItem.Tax, RItem.Duty,
                      RItem.TaxCurrencyValue,
                      RItem.DutyCurrencyValue,
                      RItem.TransportPrice, 
                      RItem.AllotmenedOtherCostInBaseCurrency,
                      RItem.NetPrice, RItem.Description, RItem.Description_En, RItem.Version, 
                      BR.Number AS BaseInventoryReceiptNumber, BR.Date AS BaseInventoryReceiptDate, 
                      BRI.TransportPrice AS BaseReceiptItemTransportPrice, 
                      BRI.AllotmenedOtherCostInBaseCurrency AS BaseAllotmenedOtherCostInBaseCurrency, 
                      BRI.Quantity AS BaseReceiptItemQuantity, BRI.Tax AS BaseReceiptItemTax, BRI.Duty AS BaseReceiptItemDuty, I.TaxExemptPurchase AS TaxExempt,
                      BRI.TaxCurrencyValue AS BaseReceiptItemTaxCurrencyValue, 
                      BRI.DutyCurrencyValue AS BaseReceiptItemDutyCurrencyValue,
                      GR.CalculationFormulaRef AS CalculationFormulaRef, I.TaxRate AS ItemTaxRate, I.DutyRate AS ItemDutyRate,
                      RItem.WeighingRef, W.Number AS WeighingNumber, W.Date AS WeighingDate, RItem.ReturnedFee, RItem.ReturnedPrice, RItem.ReturnedNetPrice
FROM         INV.InventoryReceiptItem AS BRI RIGHT OUTER JOIN
                      INV.InventoryReceipt AS BR ON BRI.InventoryReceiptRef = BR.InventoryReceiptID RIGHT OUTER JOIN
                      INV.InventoryReceiptItem AS RItem INNER JOIN
                      INV.vwItem AS I ON RItem.ItemRef = I.ItemID ON BRI.InventoryReceiptItemID = RItem.ReturnBase LEFT OUTER JOIN
                      GNR.Currency AS C ON RItem.CurrencyRef = C.CurrencyID LEFT OUTER JOIN
                      INV.Tracing AS T ON RItem.TracingRef = T.TracingID LEFT OUTER JOIN
                      INV.Unit AS U1 ON I.UnitRef = U1.UnitID LEFT OUTER JOIN
                      INV.Unit AS U2 ON I.SecondaryUnitRef = U2.UnitID                      
                      LEFT OUTER JOIN GNR.[Grouping] GR ON I.PurchaseGroupRef=GR.GroupingID                      
                      LEFT OUTER JOIN INV.InventoryWeighing W ON RItem.WeighingRef = W.InventoryWeighingID
WHERE     (RItem.IsReturn = 1)