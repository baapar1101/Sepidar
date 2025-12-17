If Object_ID('INV.vwInventoryDeliveryReturnItemSerial') Is Not Null
	DROP VIEW INV.vwInventoryDeliveryReturnItemSerial
GO
CREATE VIEW INV.vwInventoryDeliveryReturnItemSerial
AS
SELECT    A.VoucherItemTrackingID  
		 ,A.Serial
		 ,A.InventoryDeliveryItemRef
		 ,A.ItemRef 
FROM      INV.vwVoucherItemTracking    A
WHERE A.InventoryDeliveryItemRef IS NOT NULL 
AND   IsReturn = 1
GO
