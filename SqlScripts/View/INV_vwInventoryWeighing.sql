--drop view INV.vwInventoryWeighing
If Object_ID('INV.vwInventoryWeighing') Is Not Null
	Drop View INV.vwInventoryWeighing
GO
CREATE VIEW INV.vwInventoryWeighing
AS
SELECT IW.*,(ISNULL(IW.PureQuantity,0)-ISNULL(IW.UsedQuantity,0)) AS RemainingQuantity 
FROM (
SELECT W.InventoryWeighingID, W.WeighbridgeConfigurationRef, W.Number, W.Date, W.Type,  
  W.ItemRef, I.Code AS ItemCode, I.BarCode AS BarCode, I.Title AS ItemTitle, I.Title_En AS ItemTitle_En, I.UnitRef, U1.Title AS UnitTitle,   
        U1.Title_En AS UnitTitle_En, I.SecondaryUnitRef, U2.Title AS SecondaryUnitTitle, U2.Title_En AS SecondaryUnitTitle_En,   
        I.IsUnitRatioConstant, I.UnitsRatio, I.TracingCategoryRef,W.TransportPrice,W.TransportTax,W.TransportDuty, W.InputTime, W.OutputTime, W.InputQuantity,
  W.OutputQuantity, W.WastePercent,w.VendorDLRef AS VendorDLRef,d.Code AS VendorDLCode,d.Title AS VendorTitle, d.[Type] AS VendorDLType,
  d.Title_En AS VendorTitle_En, W.Driver, W.DrivingLicenseNumber, W.VehicleType,   
  W.VehicleNumber, W.WayBillNumber, W.Description, W.Description_En, W.State, W.IsManual, W.FiscalYearRef,     
  W.UnitRefConf UnitRefConf, UConf.Title AS UnitTitleConf, UConf.Title_En AS UnitTitleConf_En,    
  CAST(ABS(W.InputQuantity - W.OutputQuantity)AS DECIMAL(19, 4)) AS WeighingQuantity,   
  CAST(((ABS(W.InputQuantity - W.OutputQuantity) * W.WastePercent)/ 100) AS DECIMAL(19, 4)) AS WasteQuantity,  
  
  CAST(ABS((ABS(W.InputQuantity - W.OutputQuantity)) - ((ABS(W.InputQuantity - W.OutputQuantity) * W.WastePercent)/ 100))AS DECIMAL(19, 4)) PureQuantity,   
  W.IsPrimaryUnit, W.Creator, W.CreationDate,   
  W.LastModifier, W.LastModificationDate, W.Version  ,

  CASE WHEN W.Type=1 AND W.IsPrimaryUnit=1 THEN ISNULL((SELECT SUM(IRI.Quantity) FROM INV.InventoryReceiptItem AS IRI
  INNER JOIN INV.InventoryReceipt AS IR ON IR.InventoryReceiptID=IRI.InventoryReceiptRef 
  WHERE WeighingRef=W.InventoryWeighingID AND IR.IsReturn=0),0)
  +ISNULL((SELECT SUM(IDI.Quantity) FROM INV.InventoryDeliveryItem AS IDI
   INNER JOIN INV.InventoryDelivery AS ID ON ID.InventoryDeliveryID=IDI.InventoryDeliveryRef
   WHERE WeighingRef=W.InventoryWeighingID AND ID.IsReturn=1),0)

   WHEN W.Type=1 AND W.IsPrimaryUnit=0 THEN ISNULL((SELECT SUM(IRI.SecondaryQuantity) FROM INV.InventoryReceiptItem AS IRI
  INNER JOIN INV.InventoryReceipt AS IR ON IR.InventoryReceiptID=IRI.InventoryReceiptRef 
  WHERE WeighingRef=W.InventoryWeighingID AND IR.IsReturn=0),0)
  +ISNULL((SELECT SUM(IDI.SecondaryQuantity) FROM INV.InventoryDeliveryItem AS IDI
   INNER JOIN INV.InventoryDelivery AS ID ON ID.InventoryDeliveryID=IDI.InventoryDeliveryRef
   WHERE WeighingRef=W.InventoryWeighingID AND ID.IsReturn=1),0)

   WHEN W.Type=2 AND W.IsPrimaryUnit=1 THEN ISNULL((SELECT SUM(IDI.Quantity) FROM INV.InventoryDeliveryItem AS IDI
   INNER JOIN INV.InventoryDelivery AS ID ON ID.InventoryDeliveryID=IDI.InventoryDeliveryRef
   WHERE WeighingRef=W.InventoryWeighingID AND ID.IsReturn=0),0)
   +ISNULL((SELECT SUM(IRI.Quantity) FROM INV.InventoryReceiptItem AS IRI
   INNER JOIN INV.InventoryReceipt AS IR ON IR.InventoryReceiptID=IRI.InventoryReceiptRef 
   WHERE WeighingRef=W.InventoryWeighingID AND IR.IsReturn=1),0)

   WHEN W.Type=2 AND W.IsPrimaryUnit=0 THEN ISNULL((SELECT SUM(IDI.SecondaryQuantity) FROM INV.InventoryDeliveryItem AS IDI
   INNER JOIN INV.InventoryDelivery AS ID ON ID.InventoryDeliveryID=IDI.InventoryDeliveryRef
   WHERE WeighingRef=W.InventoryWeighingID AND ID.IsReturn=0),0)
   +ISNULL((SELECT SUM(IRI.SecondaryQuantity) FROM INV.InventoryReceiptItem AS IRI
   INNER JOIN INV.InventoryReceipt AS IR ON IR.InventoryReceiptID=IRI.InventoryReceiptRef 
   WHERE WeighingRef=W.InventoryWeighingID AND IR.IsReturn=1),0)

   END AS UsedQuantity,
   W.City
FROM INV.InventoryWeighing AS W
  LEFT JOIN ACC.DL d ON d.DLId = w.VendorDLRef
  INNER JOIN INV.Item AS I ON W.ItemRef = I.ItemID  
  INNER JOIN INV.InventoryWeighbridgeConfiguration AS WCNF ON W.WeighbridgeConfigurationRef = WCNF.InventoryWeighbridgeConfigurationID  
  LEFT OUTER JOIN INV.Unit AS U1 ON I.UnitRef = U1.UnitID  
        LEFT OUTER JOIN INV.Unit AS U2 ON I.SecondaryUnitRef = U2.UnitID  
        LEFT OUTER JOIN INV.Unit AS UConf ON W.UnitRefConf = UConf.UnitID  
		) AS IW


