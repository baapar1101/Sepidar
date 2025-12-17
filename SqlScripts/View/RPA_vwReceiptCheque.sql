If Object_ID('RPA.vwReceiptCheque') Is Not Null
	Drop View RPA.vwReceiptCheque
GO
CREATE VIEW RPA.vwReceiptCheque
AS
SELECT     ReceiptChq.Number
         , ReceiptChq.SecondNumber
		 , ReceiptChq.SayadCode
		 , ReceiptChq.AccountNo
		 , ReceiptChq.Amount
		 , ReceiptChq.Date
		 , ReceiptChq.Description
		 , ReceiptChq.Description_En
		 , ReceiptChq.Version
		 , ReceiptChq.State
		 , ReceiptChq.CashRef
		 , Cash.DlTitle AS CashTitle
		 , ReceiptChq.ReceiptHeaderRef
		 , ReceiptChq.BankRef
		 , ReceiptChq.BranchCode
		 , ReceiptChq.BranchTitle
		 , ReceiptChq.LocationRef
		 , GNR.Location.Title AS LocationTitle
		 , RPA.Bank.Title AS BankTitle
		 , GNR.Location.Title_En AS LocationTitle_En
		 , Cash.DlTitle_En AS CashTitle_En
		 , RPA.Bank.Title_En AS BankTitle_En
		 , ReceiptChq.IsGuarantee
		 , ReceiptChq.HeaderNumber
		 , ReceiptChq.HeaderDate
		 , ReceiptChq.CurrencyRef
		 , ReceiptChq.Rate
		 , GNR.Currency.Title AS CurrencyTitle
		 , GNR.Currency.Title_En AS CurrencyTitle_En
		 , Isnull(ReceiptChq.BranchTitle, '') + ' ' + ISNULL(GNR.Location.Title, '') AS BranchCityTitle
		 , ISNULL(ReceiptChq.BranchTitle, '') + ' ' + ISNULL(GNR.Location.Title, '') AS BankBranchCityTitle
		 , ReceiptChq.ReceiptChequeId
		 , ReceiptChq.AmountInBaseCurrency
		 , ReceiptChq.BankBranchRef
		 , ReceiptChq.DlRef
		 , ACC.DL.Title AS DlTitle
		 , ACC.DL.Code AS DlCode
		 , ACC.DL.Title_En AS DlTitle_En
		 , Submit.BankAccountRef AS SubmitBankAccountRef
		 , Submit.HeaderBankAccountTitle AS SubmitBankAccountTitle
		 , Submit.HeaderNumber AS SubmitNumber
		 , Submit.HeaderDate AS SubmitDate
		 , ReceiptChq.InitState
		 , RPA.Bank.Title + ' ' + Isnull(ReceiptChq.BranchTitle, '')+ ' ' + Isnull(GNR.Location.Title, '') + ' ' + ReceiptChq.AccountNo AS BankAccountTitle
		 , RPA.Bank.Title_En + ' ' + ISNULL(Convert(varchar, ReceiptChq.BranchCode), '') + ' ' + Isnull(GNR.Location.Title_En, '') + ' ' + ReceiptChq.AccountNo AS BankAccountTitle_En
		 , Submit.ReceiptChequeBankingRef
		 , ReceiptChq.Type
		 , ReceiptChq.ChequeOwner

FROM  RPA.ReceiptCheque AS ReceiptChq LEFT OUTER JOIN
      RPA.vwCash AS Cash ON ReceiptChq.CashRef = Cash.CashId INNER JOIN
      GNR.Currency ON ReceiptChq.CurrencyRef = GNR.Currency.CurrencyID  INNER JOIN
      RPA.Bank ON ReceiptChq.BankRef = RPA.Bank.BankId Left Outer JOIN
      GNR.Location ON ReceiptChq.LocationRef = GNR.Location.LocationId INNER JOIN
      ACC.DL ON ReceiptChq.DlRef = ACC.DL.DLId LEFT OUTER JOIN
      RPA.vwReceiptChequeBankingItem AS Submit ON Submit.ReceiptChequeRef = ReceiptChq.ReceiptChequeId AND Submit.HeaderState = 4