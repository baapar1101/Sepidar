IF OBJECT_ID('POM.vwPurchaseOrderCostedQuantities') IS NOT NULL
	DROP VIEW POM.vwPurchaseOrderCostedQuantities
GO
Create View POM.vwPurchaseOrderCostedQuantities
AS
	SELECT POI.PurchaseOrderItemID
		,POI.PurchaseOrderRef
		,MIN(POI.Quantity) AS Quantity
		,MIN(POI.SecondaryQuantity) AS SecondaryQuantity
		,ISNULL(SUM(U.Quantity), 0) AS UsedQuantity
		,ISNULL(SUM(U.SecondaryQuantity), 0) AS UsedSecondaryQuantity
		,MAX(CASE WHEN U.PurchaseCostItemID IS NULL THEN 0 ELSE 1 END) AS HasPurchaseCostItem
FROM POM.PurchaseOrder AS PO 
	INNER JOIN POM.PurchaseOrderItem AS POI ON PO.PurchaseOrderID = POI.PurchaseOrderRef
	LEFT JOIN (SELECT PCI.* 
		FROM POM.vwPurchaseCostItem AS PCI 
			INNER JOIN POM.PurchaseCost AS PC ON PCI.PurchaseCostRef = PC.PurchaseCostID
		WHERE PC.State = 1 /*Calculated*/ ) AS U ON POI.PurchaseOrderItemID = U.PurchaseOrderItemRef
GROUP BY POI.PurchaseOrderItemID, POI.PurchaseOrderRef

GO
