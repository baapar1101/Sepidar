If Object_ID('RPA.vwPaymentDraft') Is Not Null
	Drop View RPA.vwPaymentDraft
GO
CREATE VIEW RPA.vwPaymentDraft
AS
SELECT     
	  RPA.PaymentDraft.PaymentDraftId, RPA.PaymentDraft.Number, RPA.PaymentDraft.Date, RPA.PaymentDraft.Amount, 
      RPA.PaymentDraft.BankAccountRef, RPA.PaymentDraft.Description_En, RPA.PaymentDraft.Description, RPA.PaymentDraft.Version, 
      RPA.PaymentDraft.PaymentHeaderRef, RPA.PaymentDraft.HeaderNumber, RPA.PaymentDraft.HeaderDate, RPA.PaymentDraft.Rate, 
      RPA.PaymentDraft.CurrencyRef,
      -- RPA.Bank.Title + ' ' + RPA.BankBranch.Title + ' ' + BankAccount.AccountNo AS BankAccountTitle, 
      -- Bank.Title_En + ' ' + BankBranch.Title_En + ' ' + BankAccount.AccountNo AS BankAccountTitle_En,
      BankAccount.DlTitle AS BankAccountTitle, 
      BankAccount.DlTitle_En AS BankAccountTitle_En, 
      RPA.PaymentDraft.AmountInBaseCurrency, BankAccount.DlRef AS BankAccountDlRef, BankAccount.DlCode BankAccountDlCode
	  , RPA.PaymentDraft.BankFeeAmount
	  , RPA.PaymentDraft.BankFeeAmountInBaseCurrency
	  , RPA.PaymentDraft.BankFeeAmountRate
      , BankAccount.ShowBankFeeSeparately ShowBankFeeSeparately
FROM         
	  RPA.PaymentDraft INNER JOIN
      RPA.vwBankAccount BankAccount ON RPA.PaymentDraft.BankAccountRef = BankAccount.BankAccountId INNER JOIN
      RPA.BankBranch ON BankAccount.BankBranchRef = RPA.BankBranch.BankBranchId INNER JOIN
      RPA.Bank ON RPA.BankBranch.BankRef = RPA.Bank.BankId

