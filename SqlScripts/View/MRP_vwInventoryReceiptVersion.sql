IF OBJECT_ID('MRP.vwInventoryReceiptVersion', 'V') IS NOT NULL
    DROP VIEW MRP.vwInventoryReceiptVersion
GO

CREATE VIEW MRP.vwInventoryReceiptVersion
AS
SELECT [InventoryReceiptID] AS [ID], [Version], [Date]
FROM INV.InventoryReceipt
GO