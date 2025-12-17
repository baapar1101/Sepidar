
UPDATE INV.InventoryBalancingItem
SET SecondaryQuantity = (IB.Quantity / I.UnitsRatio)
FROM INV.InventoryBalancingItem IB
	INNER JOIN INV.Item I ON IB.ItemRef = I.ItemID
WHERE I.Type = 1 AND I.UnitsRatio IS NOT NULL AND I.SecondaryUnitRef IS NOT NULL AND IB.SecondaryQuantity IS NULL

GO