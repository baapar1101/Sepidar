IF OBJECT_ID('MRP.vwDebitCreditNoteVersion', 'V') IS NOT NULL
    DROP VIEW MRP.vwDebitCreditNoteVersion
GO

CREATE VIEW MRP.vwDebitCreditNoteVersion
AS
    SELECT DebitCreditNoteId AS [ID], [Version], [Date]
    FROM GNR.DebitCreditNote
GO