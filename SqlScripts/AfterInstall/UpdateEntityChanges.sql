UPDATE FMK.ExtraColumnDescription
SET EntityTypeName = 'SG.Inventory.InventoryCommon.Common.DsServiceInventoryPurchaseInvoice'
WHERE EntityTypeName = 'SG.Inventory.InventoryOperations.Common.DsServiceInventoryPurchaseInvoice'


UPDATE FMK.StandardDescription
SET EntityTypeName = substring(EntityTypeName, 0, LEN(EntityTypeName) - CHARINDEX(',', REVERSE(EntityTypeName)) + 1)
	+ ',SG.Inventory.InventoryCommon.Common.dll'
WHERE EntityTypeName LIKE 'ServiceInventoryPurchaseInvoiceDataTable%'

UPDATE MSG.Template
SET MessageParameterInfoFullName = 'Inventory.InventoryCommon.ServiceInventoryPurchaseInvoice'
WHERE MessageParameterInfoFullName = 'Inventory.InventoryOperations.ServiceInventoryPurchaseInvoice'

UPDATE MSG.Template
SET MessageParameterInfoFullName = 'Inventory.InventoryCommon.ServiceInventoryPurchaseInvoiceItem'
WHERE MessageParameterInfoFullName = 'Inventory.InventoryOperations.ServiceInventoryPurchaseInvoiceItem'
