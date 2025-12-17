-- BaseReturnedInvoiceItem is mandatory if the type is 'Sale'.
-- For old vouchers, if the type is 'Sale' and all of the items has no base returned invoice, set the type to 'Other'.

UPDATE ID SET ID.Type=3
--SELECT *
FROM INV.InventoryDelivery ID
WHERE
	IsReturn = 1 AND
	ID.Type = 1 AND
	NOT EXISTS
	(
		SELECT 1
		FROM INV.InventoryDeliveryItem IDI
		WHERE IDI.InventoryDeliveryRef=ID.InventoryDeliveryID AND BaseReturnedInvoiceItem IS NOT NULL
	)