UPDATE IRI SET Base = IP.Number
FROM INV.InventoryReceiptItem IRI 
	INNER JOIN INV.InventoryPurchaseInvoiceItem IPI ON IRI.BasePurchaseInvoiceItemRef = IPI.InventoryPurchaseInvoiceItemID
	INNER JOIN INV.InventoryPurchaseInvoice IP ON IP.InventoryPurchaseInvoiceID = IPI.InventoryPurchaseInvoiceRef
WHERE IP.[Type] = 1 /*InventoryPurchaseInvoiceType.Normal*/	
