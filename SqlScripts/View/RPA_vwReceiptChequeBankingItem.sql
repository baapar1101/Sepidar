If Object_ID('RPA.vwReceiptChequeBankingItem') Is Not Null
	Drop View RPA.vwReceiptChequeBankingItem
GO
CREATE VIEW RPA.vwReceiptChequeBankingItem
AS
SELECT     RC.Number, 
		   RC.SecondNumber, 
           RC.SayadCode,
		   RC.Date, 
		   RC.Amount, 
           RC.Description, 
           RC.Description_En, 
           RC.CurrencyRef, 
           RPA.Bank.Title + ' ' + ISNULL(RC.BranchTitle, '') + RC.AccountNo AS BankAccountTitle, 
           RPA.Bank.Title_En + ' ' + ISNULL(RC.BranchTitle, '') + RC.AccountNo AS BankAccountTitle_En, 
           RC.HeaderNumber AS ChequeHeaderNumber, 
           RC.HeaderDate AS ChequeHeaderDate,
           RH.DlRef AS ChequeHeaderDLRef,
		   RH.DlCode AS ChequeHeaderDLCode,
           RPA.ReceiptChequeBankingItem.ReceiptChequeBankingItemId, 
           RPA.ReceiptChequeBankingItem.ReceiptChequeRef, 
           RPA.ReceiptChequeBankingItem.ReceiptChequeBankingRef, 
           RPA.ReceiptChequeBankingItem.ReceiptChequeBankingItemRef, 
           RPA.ReceiptChequeBankingItem.ForcastDate, 
           RPA.ReceiptChequeBankingItem.State, 
           RPA.ReceiptChequeBankingItem.HeaderDate, 
           RPA.ReceiptChequeBankingItem.HeaderNumber, 
           RPA.ReceiptChequeBankingItem.BankAccountRef, 
           RPA.ReceiptChequeBankingItem.CashRef, 
           RPA.ReceiptChequeBankingItem.HeaderState, 
           RC.Rate, 
           RC.DlRef, 
        --    Bank_1.Title + ' ' + BankBranch_1.Title + ' ' + vwBankAccount.AccountNo AS HeaderBankAccountTitle, 
        --    Bank_1.Title_En + ' ' + BankBranch_1.Title_En + ' ' + vwBankAccount.AccountNo AS HeaderBankAccountTitle_En, 
           vwBankAccount.BankAccountTitle AS HeaderBankAccountTitle,
           vwBankAccount.BankAccountTitle_En AS HeaderBankAccountTitle_En,
           RC.AmountInBaseCurrency, 
           ReceiptChequeBankingItem_1.HeaderNumber AS SubmitNumber, 
           BankAccount_1.BankAccountTitle AS SubmitBankAccount, 
           BankAccount_1.BankAccountTitle_En AS SubmitBankAccount_En, 
           RC.State AS ChequeState, 
           RC.AccountNo, 
           RC.BranchCode, 
           RC.BranchTitle, 
           RPA.Bank.Title AS BankTitle, 
           RPA.Bank.Title_En AS BankTitle_En,
           RC.ChequeOwner

FROM                  RPA.BankBranch AS BankBranch_1 INNER JOIN
                      RPA.vwBankAccount ON BankBranch_1.BankBranchId = RPA.vwBankAccount.BankBranchRef INNER JOIN
                      RPA.Bank AS Bank_1 ON BankBranch_1.BankRef = Bank_1.BankId RIGHT OUTER JOIN
                      RPA.ReceiptChequeBankingItem INNER JOIN
                      RPA.ReceiptCheque RC ON RPA.ReceiptChequeBankingItem.ReceiptChequeRef =RC.ReceiptChequeId INNER JOIN
                      RPA.vwReceiptHeader RH ON RH.ReceiptHeaderId = RC.ReceiptHeaderRef INNER JOIN
                      RPA.Bank ON RC.BankRef = RPA.Bank.BankId ON 
                      RPA.vwBankAccount.BankAccountId = RPA.ReceiptChequeBankingItem.BankAccountRef LEFT OUTER JOIN
                      RPA.ReceiptChequeBankingItem AS ReceiptChequeBankingItem_1 ON  ReceiptChequeBankingItem_1.ReceiptChequeBankingItemId = RPA.ReceiptChequeBankingItem.ReceiptChequeBankingItemRef LEFT OUTER JOIN
                      RPA.vwBankAccount AS BankAccount_1 ON ReceiptChequeBankingItem_1.BankAccountRef = BankAccount_1.BankAccountId