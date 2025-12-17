UPDATE INV.InventoryReceiptItem SET CurrencyRef = NULL, CurrencyRate = NULL, CurrencyValue = NULL
WHERE InventoryReceiptItemID IN
(SELECT InventoryReceiptItemID FROM INV.InventoryReceiptItem
	WHERE (CurrencyRef IS NOT NULL AND (CurrencyRate = 0 OR CurrencyRate IS NULL))
		OR (CurrencyRef IS NULL AND (CurrencyRate IS NOT NULL))
)