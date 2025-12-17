UPDATE H SET TotalPriceInBaseCurrency = ISNULL(I.TotalPriceInBaseCurrency, 0)
FROM INV.InventoryPurchaseInvoice H
LEFT JOIN (
           Select InventoryPurchaseInvoiceRef , 
                  TotalPriceInBaseCurrency = SUM([PriceInBaseCurrency]) 
           From INV.InventoryPurchaseInvoiceItem 
           Group by InventoryPurchaseInvoiceRef
          )I ON H.InventoryPurchaseInvoiceID = I.InventoryPurchaseInvoiceRef
WHERE ISNULL(H.TotalPriceInBaseCurrency, 0) <>  ISNULL(I.TotalPriceInBaseCurrency, 0)
