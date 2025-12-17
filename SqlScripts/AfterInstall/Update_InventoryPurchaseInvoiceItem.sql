
UPDATE  PurchaseInvoiceItem 
SET RemainingQuantity = (SELECT  ISNULL(PII.Quantity,0)
                                FROM INV.InventoryPurchaseInvoiceItem AS PII
                                WHERE PII.InventoryPurchaseInvoiceItemID = PurchaseInvoiceItem.InventoryPurchaseInvoiceItemID ) -
                                         (SELECT ISNULL(SUM(RI.Quantity),0) from INV.InventoryReceiptItem AS RI
                                                WHERE RI.BasePurchaseInvoiceItemRef = PurchaseInvoiceItem.InventoryPurchaseInvoiceItemID 
                                                )
FROM INV.InventoryPurchaseInvoiceItem PurchaseInvoiceItem
       INNER JOIN INV.InventoryPurchaseInvoice PurchaseInvoice ON PurchaseInvoice.InventoryPurchaseInvoiceID =      PurchaseInvoiceItem.InventoryPurchaseInvoiceRef
WHERE PurchaseInvoice.[Type] = 1
