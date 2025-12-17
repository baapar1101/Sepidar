If Object_ID('RPA.vwPaymentChequeBanking') Is Not Null
	Drop View RPA.vwPaymentChequeBanking
GO
CREATE VIEW RPA.vwPaymentChequeBanking
AS
SELECT     RPA.PaymentChequeBanking.PaymentChequeBankingId, RPA.PaymentChequeBanking.Date, RPA.PaymentChequeBanking.BankAccountRef, 
      RPA.PaymentChequeBanking.Number,
      BankAccount.BankAccountTitle AS BankAccountTitle,
      BankAccount.BankAccountTitle_En AS BankAccountTitle_En,
      RPA.PaymentChequeBanking.CreationDate, RPA.PaymentChequeBanking.Creator, RPA.PaymentChequeBanking.LastModificationDate, 
      RPA.PaymentChequeBanking.Version, RPA.PaymentChequeBanking.State, RPA.PaymentChequeBanking.FiscalYearRef, 
      RPA.PaymentChequeBanking.VoucherRef, ACC.Voucher.Number AS VoucherNumber, ACC.Voucher.Date AS VoucherDate, 
      RPA.PaymentChequeBanking.LastModifier, BankAccount.DlCode BankAccountDlCode
FROM         RPA.PaymentChequeBanking INNER JOIN
      RPA.vwBankAccount BankAccount ON RPA.PaymentChequeBanking.BankAccountRef = BankAccount.BankAccountId  LEFT OUTER JOIN
      ACC.Voucher ON RPA.PaymentChequeBanking.VoucherRef = ACC.Voucher.VoucherId

