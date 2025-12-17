IF OBJECT_ID('INV.vwServicePurchaseInvoiceItemOtherCostedQuantities') IS NOT NULL
	DROP VIEW INV.vwServicePurchaseInvoiceItemOtherCostedQuantities
GO
Create View INV.vwServicePurchaseInvoiceItemOtherCostedQuantities
AS
	SELECT SI.InventoryPurchaseInvoiceItemID
		,SI.InventoryPurchaseInvoiceRef
		,MIN((ISNULL(SI.PriceInBaseCurrency, 0) + ISNULL(SI.AdditionInBaseCurrency, 0) - ISNULL(SI.DiscountInBaseCurrentcy, 0))) AS AmountInBaseCurrency
		,ISNULL(SUM(ISNULL(POCI.EffectiveAmountInBaseCurrency,0) + ISNULL(ROCI.EffectiveAmountInBaseCurrency,0)), 0) AS UsedAmountInBaseCurrency	
		,MAX(CASE WHEN POCI.PurchaseOtherCostItemID IS NULL THEN 0 ELSE 1 END) AS HasPurchaseOtherCostItem
		,MAX(CASE WHEN ROCI.InventoryReceiptOtherCostItemID IS NULL THEN 0 ELSE 1 END) AS HasReceiptOtherCostItem
		,S.Date ServiceDate
	FROM INV.InventoryPurchaseInvoiceItem AS SI
		INNER JOIN INV.InventoryPurchaseInvoice AS S ON SI.InventoryPurchaseInvoiceRef = S.InventoryPurchaseInvoiceID
		LEFT JOIN POM.PurchaseOtherCostItem AS POCI ON SI.InventoryPurchaseInvoiceItemID = POCI.ServiceInventoryPurchaseInvoiceItemRef
		LEFT JOIN INV.InventoryReceiptOtherCostItem AS ROCI ON SI.InventoryPurchaseInvoiceItemID = ROCI.ServiceInventoryPurchaseInvoiceItemRef
	GROUP BY SI.InventoryPurchaseInvoiceItemID , SI.InventoryPurchaseInvoiceRef, S.Date

GO
