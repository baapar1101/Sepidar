UPDATE INV.InventoryReceipt 
SET BasePurchaseInvoiceRef = null, TransportBrokerSLAccountRef = null, TransporterDLRef = null
WHERE [TYPE] = 4

UPDATE IRI SET IRI.TransportDuty = 0, IRI.TransportTax = 0, IRI.TransportPrice = 0
FROM INV.InventoryReceipt IR
	JOIN INV.InventoryReceiptItem IRI on IR.InventoryReceiptId = IRI.InventoryReceiptRef
WHERE IR.[Type] = 4