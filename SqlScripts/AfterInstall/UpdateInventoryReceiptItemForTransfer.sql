WITH Delivery_CTE (InventoryDeliveryId,InventoryDeliveryItemId,ItemRef,TracingRef,Quantity, RowId)
AS
(
	SELECT	IDI.InventoryDeliveryRef, 
			IDI.InventoryDeliveryItemId,
			IDI.ItemRef,
			IDI.TracingRef,
			IDI.Quantity,
			ROW_NUMBER() OVER (PARTITION BY IDI.InventoryDeliveryRef,IDI.ItemRef,IDI.TracingRef,IDI.Quantity ORDER BY IDI.InventoryDeliveryRef) AS RowID
	FROM INV.InventoryDeliveryItem IDI
		JOIN INV.InventoryDelivery ID ON IDI.InventoryDeliveryRef = ID.InventoryDeliveryID
	WHERE ID.Type = 4 AND ID.IsReturn = 0		
)
, Receipt_CTE (InventoryReceiptID,InventoryReceiptItemID,InventoryDeliveryRef,ItemRef,TracingRef,Quantity, RowID)
AS
(
	SELECT IRI.InventoryReceiptRef,
		   IRI.InventoryReceiptItemID,
		   IR.BaseInventoryDeliveryRef,
		   IRI.ItemRef,
		   IRI.TracingRef,
		   IRI.Quantity,
		   ROW_NUMBER() OVER(PARTITION BY IRI.InventoryReceiptRef,IRI.ItemRef,IRI.TracingRef,IRI.Quantity ORDER BY IRI.InventoryReceiptRef) 
	FROM INV.InventoryReceiptItem IRI
		JOIN INV.InventoryReceipt IR ON IRI.InventoryReceiptRef = IR.InventoryReceiptID
	WHERE IR.IsReturn = 0		
)


UPDATE IRI
SET IRI.InventoryDeliveryItemRef = D.InventoryDeliveryItemId
FROM Delivery_CTE D
	JOIN Receipt_CTE R ON D.InventoryDeliveryId = R.InventoryDeliveryRef 
							AND D.ItemRef = R.ItemRef
							AND ((D.TracingRef = R.TracingRef) OR (D.TracingRef IS NULL AND R.TracingRef IS NULL))
							AND D.Quantity = R.Quantity
							AND D.RowId = R.RowID	
	JOIN INV.InventoryReceiptItem IRI ON R.InventoryReceiptItemID = IRI.InventoryReceiptItemID
							
