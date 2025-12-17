IF OBJECT_ID('POM.vwVoucheredInventoryReceiptPurchaseInvoicesQuantities') IS NOT NULL
	DROP VIEW POM.vwVoucheredInventoryReceiptPurchaseInvoicesQuantities
GO
Create View POM.vwVoucheredInventoryReceiptPurchaseInvoicesQuantities
AS
	SELECT PII.PurchaseInvoiceItemID
		,PII.PurchaseInvoiceRef
		,MIN(PII.Quantity) AS Quantity
		,MIN(PII.SecondaryQuantity) AS SecondaryQuantity
		,ISNULL(SUM(U.Quantity), 0) AS UsedQuantity
		,ISNULL(SUM(U.SecondaryQuantity), 0) AS UsedSecondaryQuantity
		,MAX(CASE WHEN U.InventoryReceiptItemID IS NULL THEN 0 ELSE 1 END) AS HasInventoryReceiptItem
	FROM POM.PurchaseInvoiceItem AS PII
		LEFT JOIN (SELECT IRI.InventoryReceiptItemID, IRI.BaseImportPurchaseInvoiceItemRef, IRI.Quantity, IRI.SecondaryQuantity
			FROM INV.InventoryReceiptItem AS IRI 
				INNER JOIN INV.InventoryReceipt AS IR ON IRI.InventoryReceiptRef = IR.InventoryReceiptID
			WHERE IR.AccountingVoucherRef IS NOT NULL) U ON PII.PurchaseInvoiceItemID = U.BaseImportPurchaseInvoiceItemRef
	GROUP BY PII.PurchaseInvoiceItemID , PII.PurchaseInvoiceRef

GO
