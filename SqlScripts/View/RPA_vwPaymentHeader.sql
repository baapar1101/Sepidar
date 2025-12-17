If Object_ID('RPA.vwPaymentHeader') Is Not Null
	Drop View RPA.vwPaymentHeader
GO
CREATE VIEW RPA.vwPaymentHeader
AS
SELECT     
	  ph.PaymentHeaderId,ph.Type, ph.AccountSlRef, ph.DlRef, 
      ph.Number, ph.Date, ph.CurrencyRef, ph.Description, 
      ph.Description_En, ph.Discount, ph.PaymentAmount, ph.TotalAmount, 
      ph.CreatorForm, ph.State, ph.ItemType, ph.Creator, UC.Name AS CreatorName, UC.Name_En AS CreatorName_En,
      ph.Version, ph.Rate, ph.CashRef, ph.Amount, Cash.DlTitle AS CashTitle, 
      GNR.Currency.Title AS CurrencyTitle, ACC.DL.Code AS DlCode, ACC.DL.Title AS DlTitle, Account.FullCode AS AccountCode, 
      Account.Title AS AccountTitle, Account.Title_En AS AccountTitle_En, GNR.Currency.Title_En AS CurrencyTitle_En, 
      Cash.DlTitle_En AS CashTitle_En, ACC.DL.Title_En AS DLTitle_En, ph.AmountInBaseCurrency, 
      ph.ReceiptHeaderRef, Cash.DlRef AS CashDlRef, ph.LastModifier, ULM.Name AS LastModifierName, ULM.Name_En AS LastModifierName_En,
	  ph.LastModificationDate, ph.CreationDate, ph.FiscalYearRef, ph.VoucherRef, ACC.Voucher.Number AS VoucherNumber, 
      ACC.Voucher.Date AS VoucherDate, Receipt.Number ReceiptNumber, Receipt.Date ReceiptDate, ph.TotalAmountInBaseCurrency,
	  ph.DiscountRate, ph.DiscountInBaseCurrency, Cash.DlCode AS CashDlCode, CASE ph.State WHEN 4 THEN 1 ELSE 0 END IsInitial
	  , ph.BankFeeSlRef		
	  , a.Title				AS BankFeeSlTitle
	  , a.Title_En			AS BankFeeSlTitle_En
	  , a.FullCode				AS BankFeeSlCode
FROM  
       RPA.PaymentHeader ph INNER JOIN
      ACC.DL ON ph.DlRef = ACC.DL.DLId INNER JOIN	  
      GNR.Currency ON ph.CurrencyRef = GNR.Currency.CurrencyID LEFT OUTER JOIN
	  FMK.[User] AS UC ON ph.Creator = UC.UserID LEFT OUTER JOIN
	  FMK.[User] AS ULM ON ph.LastModifier = ULM.UserID LEFT OUTER JOIN
      ACC.Voucher ON ph.VoucherRef = ACC.Voucher.VoucherId LEFT OUTER JOIN
      ACC.vwAccount AS Account ON ph.AccountSlRef = Account.AccountId LEFT OUTER JOIN
      RPA.vwCash  Cash ON ph.CashRef = Cash.CashId LEFT OUTER JOIN
	  RPA.ReceiptHeader Receipt ON Receipt.ReceiptHeaderId = ph.ReceiptHeaderRef
	  LEFT JOIN ACC.vwAccount a ON a.AccountId = ph.BankFeeSlRef