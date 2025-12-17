If Object_ID('RPA.vwPaymentCheque') Is Not Null
	Drop View RPA.vwPaymentCheque
GO
CREATE VIEW RPA.vwPaymentCheque
AS
SELECT     RPA.PaymentCheque.PaymentChequeId, RPA.PaymentCheque.Number, RPA.PaymentCheque.SecondNumber, RPA.PaymentCheque.SayadCode, RPA.PaymentCheque.IsGuarantee, 
          RPA.PaymentCheque.Amount, RPA.PaymentCheque.Date, RPA.PaymentCheque.Description, RPA.PaymentCheque.Description_En, 
          RPA.PaymentCheque.Version, RPA.PaymentCheque.State, RPA.PaymentCheque.PaymentHeaderRef, RPA.PaymentCheque.BankAccountRef, 
          RPA.PaymentCheque.HeaderNumber, RPA.PaymentCheque.HeaderDate, RPA.PaymentCheque.CurrencyRef, RPA.PaymentCheque.Rate, 
          -- RPA.Bank.Title + ' ' + RPA.BankBranch.Title + ' ' + BankAccount.AccountNo AS BankAccountTitle,
          BankAccount.BankAccountTitle AS BankAccountTitle,
          -- RPA.Bank.Title_En + ' ' + RPA.BankBranch.Title_En + ' ' + BankAccount.AccountNo AS BankAccountTitle_En,
          BankAccount.BankAccountTitle_En AS BankAccountTitle_En,
		  RPA.PaymentCheque.AmountInBaseCurrency, BankAccount.DlCode BankAccountDlCode,
          BankAccount.DlRef AS BankAccountDlRef, RPA.PaymentCheque.DurationType, RPA.PaymentCheque.DlRef, ACC.DL.Title AS DlTitle, ACC.DL.Code AS DlCode,
		ACC.DL.Title_En AS DlTitle_En, BankAccount.CurrencyTitle, BankAccount.CurrencyTitle_En,  RPA.PaymentCheque.Type
		
FROM         RPA.PaymentCheque INNER JOIN
          RPA.vwBankAccount AS  BankAccount ON RPA.PaymentCheque.BankAccountRef = BankAccount.BankAccountId INNER JOIN
          RPA.BankBranch ON BankAccount.BankBranchRef = RPA.BankBranch.BankBranchId INNER JOIN
          RPA.Bank ON RPA.BankBranch.BankRef = RPA.Bank.BankId INNER JOIN
          ACC.DL ON RPA.PaymentCheque.DlRef = ACC.DL.DLId

