IF OBJECT_ID('INV.vwInventoryPurchaseInvoiceReceivedQuantities') IS NOT NULL
	DROP VIEW INV.vwInventoryPurchaseInvoiceReceivedQuantities
GO
Create View INV.vwInventoryPurchaseInvoiceReceivedQuantities
AS
	SELECT
		IPI.InventoryPurchaseInvoiceItemID,
		IPI.InventoryPurchaseInvoiceRef,
		MIN(IPI.Quantity)          AS Quantity,
		MIN(IPI.SecondaryQuantity) AS SecondaryQuantity ,
		SUM(IRI.Quantity)          AS ReceivedQuantity,
		SUM(IRI.SecondaryQuantity) AS ReceivedSecondaryQuantity,		
		MAX(case when IRI.InventoryReceiptItemId is null then 0 else 1 end) AS HasInventoryReceiptItem
	FROM      INV.InventoryPurchaseInvoiceItem AS IPI
	LEFT JOIN INV.InventoryReceiptItem         AS IRI ON IRI.BasePurchaseInvoiceItemRef = IPI.InventoryPurchaseInvoiceItemID
	GROUP BY IPI.InventoryPurchaseInvoiceItemID , IPI.InventoryPurchaseInvoiceRef
GO
