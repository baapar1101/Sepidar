IF OBJECT_ID('MRP.vwReceiptHeaderVersion', 'V') IS NOT NULL
    DROP VIEW MRP.vwReceiptHeaderVersion
GO

CREATE VIEW MRP.vwReceiptHeaderVersion
AS
    SELECT RC.ReceiptHeaderId AS [ID], RC.[Date], [Version]
    FROM RPA.ReceiptHeader RC
GO
