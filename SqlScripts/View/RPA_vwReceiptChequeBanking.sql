If Object_ID('RPA.vwReceiptChequeBanking') Is Not Null
	Drop View RPA.vwReceiptChequeBanking
GO
CREATE VIEW RPA.vwReceiptChequeBanking
AS
SELECT     RPA.ReceiptChequeBanking.ReceiptChequeBankingId, RPA.ReceiptChequeBanking.RelationNo, RPA.ReceiptChequeBanking.BankAccountRef, 
                      BankAccount.BankAccountTitle AS BankAccountTitle,
                      BankAccount.BankAccountTitle_En AS BankAccountTitle_En,
                      RPA.ReceiptChequeBanking.Type, RPA.ReceiptChequeBanking.Number, 
                      RPA.ReceiptChequeBanking.Date, RPA.ReceiptChequeBanking.ReceiptChequeBankingRef, RPA.ReceiptChequeBanking.CashRef, 
                      Cash.DlTitle AS CashTitle, RPA.ReceiptChequeBanking.State, RPA.ReceiptChequeBanking.CreationDate, RPA.ReceiptChequeBanking.LastModifier, 
                      RPA.ReceiptChequeBanking.LastModificationDate, RPA.ReceiptChequeBanking.FiscalYearRef, RPA.ReceiptChequeBanking.VoucherRef, 
                      RPA.ReceiptChequeBanking.Creator, RPA.ReceiptChequeBanking.Version, ACC.Voucher.Number AS VoucherNumber, 
                      ACC.Voucher.Date AS VoucherDate, BankAccount.DlCode AS BankAccountDlCode, Cash.DlCode AS CashDlCode, BankAccount.AccountNo, 
                      BankAccount.AccountTypeTitle, BankAccount.BankTitle, BankAccount.BankTitle_En, BankAccount.BranchCode, BankAccount.BranchTitle, 
                      BankAccount.BranchTitle_En, BankAccount.Owner AS AccountOwner, BankAccount.Owner_En AS AccountOwner_En, 
                      RPA.ReceiptChequeBanking.SubmitNumber, BankAccount.CurrencyRef AS BankAccountCurrencyRef, Cash.CurrencyRef AS CashCurrencyRef, 
                      Cash.DlTitle_En AS CashTitle_En
FROM         ACC.Voucher RIGHT OUTER JOIN
                      RPA.ReceiptChequeBanking ON ACC.Voucher.VoucherId = RPA.ReceiptChequeBanking.VoucherRef LEFT OUTER JOIN
                      RPA.vwCash AS Cash ON RPA.ReceiptChequeBanking.CashRef = Cash.CashId LEFT OUTER JOIN
                      RPA.vwBankAccount AS BankAccount ON RPA.ReceiptChequeBanking.BankAccountRef = BankAccount.BankAccountId