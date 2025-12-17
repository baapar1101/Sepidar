
UPDATE InvPurchaseInvoice SET InvPurchaseInvoice.TotalNetPriceInBaseCurrency = InvPurchaseInBaseCurrency.TotalNetPriceInBaseCurrency ,InvPurchaseInvoice.TotalPriceInBaseCurrency = InvPurchaseInBaseCurrency.TotalPriceInBaseCurrency
FROM INV.InventoryPurchaseInvoice InvPurchaseInvoice
	INNER JOIN 
		(SELECT InvPurchaseInvoice.InventoryPurchaseInvoiceId, (SUM(ISNULL(InvPurchaseInvoiceItem.PriceInBaseCurrency,0)) + SUM(ISNULL(InvPurchaseInvoiceItem.TaxInBaseCurrency,0)) + SUM(ISNULL(InvPurchaseInvoiceItem.DutyInBaseCurrency,0)) - SUM(ISNULL(InvPurchaseInvoiceItem.DiscountInBaseCurrentcy,0)) + /*SUM(InvPurchaseInvoiceItem.TransInBaseCurrency) +*/ SUM(ISNULL(InvPurchaseInvoiceItem.AdditionInBaseCurrency,0)) - SUM(ISNULL(InvPurchaseInvoiceItem.WithHoldingTaxAmountInBaseCurrency,0)) - SUM(ISNULL(InvPurchaseInvoiceItem.InsuranceAmountInBaseCurrency,0))) TotalNetPriceInBaseCurrency,
			   SUM(ISNULL(InvPurchaseInvoiceItem.PriceInBaseCurrency,0)) TotalPriceInBaseCurrency
		 FROM INV.InventoryPurchaseInvoice InvPurchaseInvoice
			INNER JOIN INV.InventoryPurchaseInvoiceItem InvPurchaseInvoiceItem ON InvPurchaseInvoiceItem.InventoryPurchaseInvoiceRef = InvPurchaseInvoice.InventoryPurchaseInvoiceID
		 GROUP BY InvPurchaseInvoice.InventoryPurchaseInvoiceID) InvPurchaseInBaseCurrency ON InvPurchaseInBaseCurrency.InventoryPurchaseInvoiceId = InvPurchaseInvoice.InventoryPurchaseInvoiceID
WHERE InvPurchaseInvoice.TotalNetPriceInBaseCurrency IS NULL OR InvPurchaseInvoice.TotalPriceInBaseCurrency IS NULL