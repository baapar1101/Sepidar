If Object_ID('RPA.vwRefundCheque') Is Not Null
	Drop View RPA.vwRefundCheque
GO
CREATE VIEW RPA.vwRefundCheque
AS
SELECT     RPA.RefundCheque.RefundChequeId, RPA.RefundCheque.DlRef, RPA.RefundCheque.Date, RPA.RefundCheque.Type, RPA.RefundCheque.Number, 
      RPA.RefundCheque.Version, RPA.RefundCheque.ReceiptHeaderRef, RPA.RefundCheque.PaymentHeaderRef, ACC.DL.Code AS DlCode, 
      ACC.DL.Title AS DlTitle, ACC.DL.Title_En AS DlTitle_En, RPA.RefundCheque.CurrencyRef, GNR.Currency.Title AS CurrencyTitle, 
      RPA.RefundCheque.Creator, RPA.RefundCheque.CreationDate, RPA.RefundCheque.LastModifier, RPA.RefundCheque.LastModificationDate, 
      RPA.RefundCheque.State, RPA.RefundCheque.FiscalYearRef, RPA.RefundCheque.VoucherRef, ACC.Voucher.Number AS VoucherNumber, 
      ACC.Voucher.Date AS VoucherDate, GNR.Currency.Title_En AS CurrencyTitle_En,
	  CASE WHEN (RPA.RefundCheque.ReceiptHeaderRef IS NOT NULL) THEN Receipt.Number
				ELSE Payment.Number END ReceiptPaymentNumber, 

	  CASE WHEN (RPA.RefundCheque.ReceiptHeaderRef IS NOT NULL) THEN Receipt.Date
				ELSE Payment.Date END ReceiptPaymentDate ,
	  0 AS TotalAmount, RPA.RefundCheque.[Description], RPA.RefundCheque.[Description_En]

FROM         RPA.RefundCheque INNER JOIN
      ACC.DL ON RPA.RefundCheque.DlRef = ACC.DL.DLId INNER JOIN
      GNR.Currency ON RPA.RefundCheque.CurrencyRef = GNR.Currency.CurrencyID LEFT OUTER JOIN
      ACC.Voucher ON RPA.RefundCheque.VoucherRef = ACC.Voucher.VoucherId LEFT OUTER JOIN       
      Rpa.ReceiptHeader Receipt ON Receipt.ReceiptHeaderId = RPA.RefundCheque.ReceiptHeaderRef LEFT OUTER JOIN 
	  Rpa.PaymentHeader Payment ON Payment.PaymentHeaderId = RPA.RefundCheque.PaymentHeaderRef 

