

-- Update ReceiverDLRef
UPDATE INV.InventoryDelivery SET ReceiverDLRef = NULL
WHERE [Type] = 4 /*InventoryDeliveryType.Transfer*/ AND ReceiverDLRef IS NOT NULL

-- Update DestinationStockRef
UPDATE INV.InventoryDelivery SET DestinationStockRef = NULL
WHERE [Type] <> 4 /*InventoryDeliveryType.Transfer*/ AND DestinationStockRef IS NOT NULL