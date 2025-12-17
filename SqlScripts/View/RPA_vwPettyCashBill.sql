IF OBJECT_ID('RPA.vwPettyCashBill') IS NOT NULL
    DROP VIEW RPA.vwPettyCashBill
GO
CREATE VIEW RPA.vwPettyCashBill
AS
SELECT PCB.[PettyCashBillId]
     , PCB.[Number]
     , PCB.[Date]
     , PCB.[State]
     , PCB.[TotalAmount]
     , PCB.[TotalAmountInBaseCurrency]
     , PCB.[Description]
     , PCB.[Description_En]
     , PCB.[PettyCashRef]
     , PCB.[VoucherRef]
     , PCB.[FiscalYearRef]
     , PCB.[Version]
     , PCB.[Creator]
     , PCB.[CreationDate]
     , PCB.[LastModifier]
     , PCB.[LastModificationDate]
     , PC.Title      PettyCashTitle
     , PC.Title_En   PettyCashTitle_En
     , PC.DlCode     PartyDlCode
     , PC.DlRef      PartyDlRef
     , PC.DlTitle    PartyDlTitle
     , PC.DlTitle_En PartyDlTitle_En
     , PC.CurrencyRef
     , PC.CurrencyTitle
     , PC.CurrencyTitle_En
     , V.Number AS   VoucherNumber
     , V.Date   AS   VoucherDate

FROM RPA.PettyCashBill PCB
         JOIN RPA.vwPettyCash PC on PC.PettyCashId = PCB.PettyCashRef
         LEFT OUTER JOIN ACC.Voucher AS V ON PCB.VoucherRef = V.VoucherId
