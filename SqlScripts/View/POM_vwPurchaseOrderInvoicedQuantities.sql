IF OBJECT_ID('POM.vwPurchaseOrderInvoicedQuantities') IS NOT NULL
	DROP VIEW POM.vwPurchaseOrderInvoicedQuantities
GO
Create View POM.vwPurchaseOrderInvoicedQuantities
AS
SELECT
     PurchaseOrderItemID = ISNULL(POM_PII.PurchaseOrderItemRef, INV_PII.PurchaseOrderItemRef)
     ,UsedQuantity = ISNULL(POM_PII.Quantity, INV_PII.Quantity)
     ,UsedSecondaryQuantity = ISNULL(POM_PII.SecondaryQuantity, INV_PII.SecondaryQuantity)
FROM (
        SELECT PII.PurchaseOrderItemRef, SUM(Quantity) AS Quantity, SUM(ISNULL(SecondaryQuantity,0)) AS SecondaryQuantity
        FROM POM.PurchaseInvoice PI
        JOIN POM.PurchaseInvoiceItem PII ON PI.PurchaseInvoiceID = PII.PurchaseInvoiceRef
        WHERE PI.IsInitial = 0
        GROUP BY PII.PurchaseOrderItemRef
    ) POM_PII
    FULL JOIN
    (
        SELECT PII.PurchaseOrderItemRef, SUM(Quantity) AS Quantity, SUM(ISNULL(SecondaryQuantity,0)) AS SecondaryQuantity
        FROM INV.InventoryPurchaseInvoiceItem PII
        WHERE PII.PurchaseOrderItemRef IS NOT NULL
        GROUP BY PII.PurchaseOrderItemRef
    ) INV_PII
    ON INV_PII.PurchaseOrderItemRef = POM_PII.PurchaseOrderItemRef
GO

