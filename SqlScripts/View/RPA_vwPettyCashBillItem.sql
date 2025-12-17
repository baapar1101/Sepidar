IF OBJECT_ID('RPA.vwPettyCashBillItem') IS NOT NULL
    DROP VIEW RPA.vwPettyCashBillItem
GO
CREATE VIEW RPA.vwPettyCashBillItem
AS
SELECT PCBI.[PettyCashBillItemId]
     , PCBI.[RowNumber]
     , PCBI.[Date]
     , PCBI.[Rate]
     , PCBI.[Amount]
     , PCBI.[AmountInBaseCurrency]
     , PCBI.[RelatedPeople]
     , PCBI.[RelatedNumbers]
     , PCBI.[Description]
     , PCBI.[Description_En]
     , PCBI.[PettyCashBillRef]
     , PCBI.[DebitCreditNoteItemRef]
     , PCBI.[SLRef]
     , PCBI.[DLRef]
     , PCBI.[VendorDLRef]
     , DCN.Number        AS DebitCreditNoteNumber
     , SL.FullCode       AS SLCode
     , SL.Title          AS SLTitle
     , SL.Title_En       AS SLTitle_En
     , SL.HasDL          AS SLHasDl
     , SL.HasCurrency    AS SLHasCurrency
     , DL.Code           AS DLCode
     , DL.Title          AS DLTitle
     , DL.Title_En       AS DLTitle_En
     , P.DLCode          AS VendorDLCode
     , P.DLTitle         AS VendorDLTitle
     , P.DLTitle_En      AS VendorDLTitle_En

FROM RPA.PettyCashBillItem PCBI
         LEFT JOIN GNR.DebitCreditNoteItem DCNI on PCBI.DebitCreditNoteItemRef = DCNI.DebitCreditNoteItemId
         LEFT JOIN GNR.DebitCreditNote DCN on DCNI.DebitCreditNoteRef = DCN.DebitCreditNoteID
         LEFT JOIN ACC.vwAccount AS SL ON PCBI.SLRef = SL.AccountId
         LEFT JOIN ACC.DL AS DL ON PCBI.DLRef = DL.DLId
         LEFT JOIN GNR.vwParty AS P ON PCBI.VendorDLRef=P.DLRef