If Object_ID('RPA.vwReconciliation') Is Not Null
	Drop View RPA.vwReconciliation
GO
CREATE VIEW RPA.vwReconciliation
AS
SELECT     RPA.Reconciliation.ReconciliationId, RPA.Reconciliation.Number, RPA.Reconciliation.BankAccountRef, RPA.Reconciliation.BankBillRef, 
                      RPA.Reconciliation.Date, RPA.Reconciliation.State, RPA.Reconciliation.Creator, RPA.Reconciliation.CreationDate, RPA.Reconciliation.LastModifier, 
                      RPA.Reconciliation.Version, RPA.Reconciliation.LastModificationDate, RPA.Reconciliation.FiscalYearRef, RPA.BankBill.Number AS BillNumber, 
                    --   RPA.Bank.Title + ' ' + RPA.BankBranch.Title + ' ' + RPA.BankAccount.AccountNo AS BankAccountTitle,
                    --   RPA.Bank.Title_En + ' ' + RPA.BankBranch.Title_En + ' ' + RPA.BankAccount.AccountNo AS BankAccountTitle_En,
                      RPA.vwBankAccount.BankAccountTitle AS BankAccountTitle, 
                      RPA.vwBankAccount.BankAccountTitle_En AS BankAccountTitle_En,
                      RPA.Reconciliation.BankBalance, 
                      RPA.Reconciliation.BankBillBalance, RPA.Reconciliation.BankBalanceInBaseCurrency, RPA.Reconciliation.BankBillBalanceInBaseCurrency, 
                      RPA.vwBankAccount.Rate, RPA.vwBankAccount.CurrencyRef, GNR.Currency.Title AS CurrencyTitle, GNR.Currency.Title_En AS CurrencyTitle_En
FROM         RPA.Reconciliation INNER JOIN
                      RPA.vwBankAccount ON RPA.Reconciliation.BankAccountRef = RPA.vwBankAccount.BankAccountId INNER JOIN
                      RPA.BankBranch ON RPA.vwBankAccount.BankBranchRef = RPA.BankBranch.BankBranchId INNER JOIN
                      RPA.Bank ON RPA.BankBranch.BankRef = RPA.Bank.BankId INNER JOIN
                      GNR.Currency ON RPA.vwBankAccount.CurrencyRef = GNR.Currency.CurrencyID LEFT OUTER JOIN
                      RPA.BankBill ON RPA.Reconciliation.BankBillRef = RPA.BankBill.BankBillId

