IF OBJECT_ID('MRP.vwReceiptChequeVersion', 'V') IS NOT NULL
    DROP VIEW MRP.vwReceiptChequeVersion
GO

CREATE VIEW MRP.vwReceiptChequeVersion
AS
    SELECT RC.ReceiptChequeId AS [ID], RH.[Version] + RC.[Version] AS [Version], RC.[Date]
    FROM RPA.ReceiptCheque RC
    INNER JOIN RPA.ReceiptHeader RH ON RC.ReceiptHeaderRef = RH.ReceiptHeaderID
GO
