If Object_ID('GNR.vwDebitCreditNote') Is Not Null
	Drop View GNR.vwDebitCreditNote
GO
CREATE VIEW GNR.vwDebitCreditNote
AS
SELECT    DC.DebitCreditNoteID, DC.Date, DC.CurrencyRef, DC.Rate, DC.Version, DC.Creator, DC.CreationDate, DC.LastModificationDate, DC.LastModifier, 
          C.Title AS CurrencyTitle, C.Title_En AS CurrencyTitle_En, C.PrecisionCount AS CurrencyPrecisionCount, DC.Number, DC.VoucherRef,
		  (CASE WHEN V.Number IS NOT NULL THEN V.Number WHEN PB.VoucherRef IS NOT NULL THEN VPettyCashBill.Number END) AS VoucherNumber,
          (CASE WHEN V.Date IS NOT NULL THEN V.Date WHEN PB.VoucherRef IS NOT NULL THEN VPettyCashBill.Date END) AS VoucherDate,
		  DC.FiscalYearRef, DC.SumAmount, DC.SumAmountInBaseCurrency,
          DCI.CreditSLCode,DCI.CreditDLCode,DCI.DebitSLCode,DCI.DebitDLCode,DCI.CreditType,DCI.DebitType,
          DCI.CreditSLTitle,DCI.CreditDLTitle,DCI.DebitSLTitle,DCI.DebitDLTitle,DC.PettyCashBillRef,PB.Number AS PettyCashBillNumber, DC.[Description], DC.[Description_En]
FROM      GNR.DebitCreditNote AS DC
		  INNER JOIN GNR.Currency AS C ON DC.CurrencyRef = C.CurrencyID 
		  LEFT OUTER JOIN ACC.Voucher AS V ON DC.VoucherRef = V.VoucherId
		  LEFT OUTER JOIN RPA.PettyCashBill AS PB ON DC.PettyCashBillRef = PB.PettyCashBillId
		  LEFT OUTER JOIN ACC.Voucher AS VPettyCashBill ON PB.VoucherRef = VPettyCashBill.VoucherId
		  OUTER APPLY
		  (SELECT TOP 1 * FROM GNR.vwDebitCreditNoteItem D
		   WHERE D.DebitCreditNoteRef = DC.DebitCreditNoteID ORDER BY d.DebitCreditNoteRef) AS DCI