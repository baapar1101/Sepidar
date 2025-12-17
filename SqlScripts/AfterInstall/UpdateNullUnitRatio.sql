UPDATE INV.Item
SET UnitsRatio = 1
WHERE SecondaryUnitRef IS NOT NULL AND (UnitsRatio IS NULL OR UnitsRatio = 0)