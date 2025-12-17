If Object_ID('INV.vwInventoryReceiptItemSerial') Is Not Null
	Drop View INV.vwInventoryReceiptItemSerial
GO
CREATE VIEW INV.vwInventoryReceiptItemSerial
AS
SELECT    A.VoucherItemTrackingID  
		 ,A.Serial
		 ,A.InventoryReceiptItemRef
		 ,A.ItemRef 
FROM      INV.vwVoucherItemTracking    A
WHERE A.InventoryReceiptItemRef IS NOT NULL 
AND   IsReturn = 0
GO
