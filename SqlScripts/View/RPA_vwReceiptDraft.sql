If Object_ID('RPA.vwReceiptDraft') Is Not Null
	Drop View RPA.vwReceiptDraft
GO
CREATE VIEW RPA.vwReceiptDraft
AS
SELECT     ReceiptDraft.ReceiptDraftId, ReceiptDraft.Number, ReceiptDraft.Date, ReceiptDraft.Amount, ReceiptDraft.BankAccountRef, ReceiptDraft.Description, 
          ReceiptDraft.Description_En, ReceiptDraft.Version, ReceiptDraft.ReceiptHeaderRef, ReceiptDraft.HeaderNumber, ReceiptDraft.HeaderDate, 
          ReceiptDraft.CurrencyRef, ReceiptDraft.Rate, GNR.Currency.Title AS CurrencyTitle, GNR.Currency.Title_En AS CurrencyTitle_En, 
          BankAccount.BankAccountTitle AS BankAccountTitle,
          ReceiptDraft.AmountInBaseCurrency, BankAccount.DlCode BankAccountDlCode,
          BankAccount.BankAccountTitle_En AS BankAccountTitle_En
FROM         
	  RPA.ReceiptDraft AS ReceiptDraft INNER JOIN
      RPA.vwBankAccount AS BankAccount ON ReceiptDraft.BankAccountRef = BankAccount.BankAccountId INNER JOIN
      GNR.Currency ON ReceiptDraft.CurrencyRef = GNR.Currency.CurrencyID 

