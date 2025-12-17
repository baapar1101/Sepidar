UPDATE ID SET TotalPrice = ISNULL(sumprice,0)
FROM
	INV.InventoryDelivery ID INNER JOIN
	(
		SELECT InventoryDeliveryRef, SUM(Price) AS sumprice
		FROM INV.InventoryDeliveryItem IDI
		GROUP BY InventoryDeliveryRef
	) IDI ON ID.InventoryDeliveryID = IDI.InventoryDeliveryRef


-- Remove TransportTax and TransportDuty values from InventoryReceiptReturn
UPDATE IRI SET TransportTax=NULL, TransportDuty=NULL FROM
	INV.InventoryReceiptItem IRI WHERE IRI.IsReturn=1


UPDATE IR SET TotalPrice=ISNULL(sumprice,0),
	TotalTax = ISNULL(sumTax,0) + ISNULL(sumTransportTax, 0),
	TotalDuty = ISNULL(sumDuty,0) + ISNULL(sumTransportDuty, 0),
	TotalTransportPrice=ISNULL(sumTransportPrice,0),
	TotalNetPrice = ISNULL(sumNetPrice,0)
FROM
	INV.InventoryReceipt IR INNER JOIN
	(
		SELECT InventoryReceiptRef,
			SUM(Price) AS sumPrice, SUM(Tax) AS sumTax, SUM(Duty) AS sumDuty,
			SUM(TransportTax) AS sumTransportTax, SUM(TransportDuty) as sumTransportDuty,
			SUM(ISNULL(TransportPrice,0)) AS sumTransportPrice,-- +CASE WHEN IsReturn=1 THEN 0 ELSE ISNULL(TransportTax,0)+ISNULL(TransportDuty,0) END) AS sumTransportPrice,
			SUM(NetPrice) AS sumNetPrice
		FROM INV.InventoryReceiptItem IRI
		GROUP BY InventoryReceiptRef
	) IRI ON IR.InventoryReceiptID = IRI.InventoryReceiptRef

UPDATE IP SET	TotalPrice = ISNULL(sumprice,0), 
				TotalTax = ISNULL(sumTax,0), 
				TotalDuty = ISNULL(sumDuty,0), 
				TotalTransportPrice=ISNULL(sumTransportPrice,0), 
				TotalNetPrice = ISNULL(sumNetPrice,0)
FROM
	INV.InventoryPurchaseInvoice IP 
	INNER JOIN
		(
			SELECT InventoryPurchaseInvoiceRef,
				SUM(Price) AS sumPrice, SUM(Tax) AS sumTax, SUM(Duty) AS sumDuty,
				SUM(ISNULL(TransportPrice,0)+ISNULL(TransportTax,0)+ISNULL(TransportDuty,0)) AS sumTransportPrice,
				SUM(NetPrice) AS sumNetPrice
			FROM INV.InventoryPurchaseInvoiceItem IPI
			GROUP BY InventoryPurchaseInvoiceRef
		) IPI ON IP.InventoryPurchaseInvoiceID = IPI.InventoryPurchaseInvoiceRef
WHERE IP.[Type] = 1 /*InventoryPurchaseInvoiceType.Normal*/
