UPDATE POI
SET POI.BasePerformaItemRef = NULL
FROM POM.PurchaseOrderItem POI
JOIN POM.PerformaItem PI ON PI.PerformaItemID = POI.BasePerformaItemRef
WHERE PI.ItemRef <> POI.ItemRef