If Object_ID('INV.vwInventoryReceiptReturnItemSerial') Is Not Null
	Drop View INV.vwInventoryReceiptReturnItemSerial
GO
CREATE VIEW INV.vwInventoryReceiptReturnItemSerial
AS
SELECT    A.VoucherItemTrackingID  
		 ,A.Serial
		 ,A.InventoryReceiptItemRef
		 ,A.ItemRef 
FROM      INV.vwVoucherItemTracking    A
WHERE A.InventoryReceiptItemRef IS NOT NULL 
AND   IsReturn = 1
GO
