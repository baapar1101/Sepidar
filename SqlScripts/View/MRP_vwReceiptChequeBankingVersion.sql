IF OBJECT_ID('MRP.vwReceiptChequeBankingVersion', 'V') IS NOT NULL
    DROP VIEW MRP.vwReceiptChequeBankingVersion
GO

CREATE VIEW MRP.vwReceiptChequeBankingVersion
AS
    SELECT RCBI.ReceiptChequeBankingItemId AS [ID], RCB.[Version], RC.[Date]
    FROM RPA.ReceiptChequeBankingItem RCBI
    INNER JOIN RPA.ReceiptCheque RC ON RCBI.ReceiptChequeRef = RC.ReceiptChequeId
    INNER JOIN RPA.ReceiptChequeBanking RCB ON RCBI.ReceiptChequeBankingRef = RCB.ReceiptChequeBankingId
GO