IF OBJECT_ID('MRP.vwRefundChequeVersion', 'V') IS NOT NULL
    DROP VIEW MRP.vwRefundChequeVersion
GO

CREATE VIEW MRP.vwRefundChequeVersion
AS
    SELECT RC.RefundChequeId AS [ID], RC.[Date], [Version]
    FROM RPA.RefundCheque RC
GO
