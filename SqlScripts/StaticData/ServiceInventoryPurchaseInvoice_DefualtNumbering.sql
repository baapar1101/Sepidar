/* SD.DefineDefaultUser */ /* this line is for dependancey order of scripts*/
if not exists(select * from FMK.NumberedEntity where EntityFullName = 'SG.Inventory.InventoryCommon.Common.ServiceInventoryPurchaseInvoiceRow')
begin
	UPDATE FMK.NumberedEntity
	SET EntityFullName = 'SG.Inventory.InventoryCommon.Common.ServiceInventoryPurchaseInvoiceRow'
	WHERE EntityFullName = 'SG.Inventory.InventoryOperations.Common.ServiceInventoryPurchaseInvoiceRow'
end

Exec FMK.spCreateNumbering 'SG.Inventory.InventoryCommon.Common.ServiceInventoryPurchaseInvoiceRow', 2, 1, null, 1, 0, 0, 0
GO
Exec FMK.spCreateNumbering 'SG.Inventory.InventoryCommon.Common.AssetPurchaseInvoiceRow', 2, 1, null, 1, 0, 0, 0