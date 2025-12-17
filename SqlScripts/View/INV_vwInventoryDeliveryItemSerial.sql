If Object_ID('INV.vwInventoryDeliveryItemSerial') Is Not Null
	DROP VIEW INV.vwInventoryDeliveryItemSerial
GO
CREATE VIEW INV.vwInventoryDeliveryItemSerial
AS
SELECT    A.VoucherItemTrackingID  
		 ,A.Serial
		 ,A.InventoryDeliveryItemRef
		 ,A.ItemRef 
FROM      INV.vwVoucherItemTracking    A
WHERE A.InventoryDeliveryItemRef IS NOT NULL 
AND   IsReturn = 0
GO
