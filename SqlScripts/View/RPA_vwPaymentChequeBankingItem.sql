If Object_ID('RPA.vwPaymentChequeBankingItem') Is Not Null
	Drop View RPA.vwPaymentChequeBankingItem
GO
CREATE VIEW RPA.vwPaymentChequeBankingItem
AS
SELECT     RPA.PaymentChequeBankingItem.PaymentChequeBankingItemId, RPA.PaymentChequeBankingItem.PaymentChequeBankingRef, 
      RPA.PaymentChequeBankingItem.PaymentChequeRef, RPA.PaymentChequeBankingItem.HeaderDate, 
      RPA.PaymentChequeBankingItem.HeaderNumber, RPA.PaymentChequeBankingItem.BankAccountRef, RPA.PaymentCheque.Number, 
      RPA.PaymentCheque.SecondNumber, RPA.PaymentCheque.SayadCode, RPA.PaymentCheque.Amount, RPA.PaymentCheque.Date, RPA.PaymentCheque.Description, 
      RPA.PaymentCheque.Description_En, RPA.PaymentCheque.HeaderDate AS ChequeHeaderDate, 
      RPA.PaymentCheque.HeaderNumber AS ChequeHeaerNumber, RPA.PaymentCheque.DurationType, RPA.PaymentCheque.CurrencyRef, 
      RPA.PaymentCheque.Rate, RPA.PaymentCheque.AmountInBaseCurrency, RPA.PaymentCheque.DlRef
FROM         RPA.PaymentChequeBankingItem INNER JOIN
	RPA.PaymentCheque ON RPA.PaymentChequeBankingItem.PaymentChequeRef = RPA.PaymentCheque.PaymentChequeId

