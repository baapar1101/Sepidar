IF OBJECT_ID('MRP.vwInventoryDeliveryVersion', 'V') IS NOT NULL
    DROP VIEW MRP.vwInventoryDeliveryVersion
GO

CREATE VIEW MRP.vwInventoryDeliveryVersion
AS
SELECT [InventoryDeliveryID] AS [ID], [Version], [Date]
FROM INV.InventoryDelivery
GO