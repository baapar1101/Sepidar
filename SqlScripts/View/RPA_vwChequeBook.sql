If Object_ID('RPA.vwChequeBook') Is Not Null
	Drop View RPA.vwChequeBook
GO
CREATE VIEW RPA.vwChequeBook
AS
SELECT     ChequeBook.ChequeBookId, ChequeBook.BankAccountRef, ChequeBook.beginNumber, 
        --   Bank.Title + ' ' + BankBranch.Title + ' ' + BankAccount.AccountNo AS BankAccountTitle,
          BankAccount.BankAccountTitle AS BankAccountTitle,
          ChequeBook.Count, ChequeBook.PrintFormat, 
          ChequeBook.Series, ChequeBook.Version, ChequeBook.Creator, ChequeBook.CreationDate, ChequeBook.LastModifier, 
          ChequeBook.LastModificationDate,
        --   Bank.Title_En + ' ' + BankBranch.Title_En + ' ' + BankAccount.AccountNo AS BankAccountTitle_En
          BankAccount.BankAccountTitle_En AS BankAccountTitle_En
FROM         RPA.ChequeBook AS ChequeBook INNER JOIN
          RPA.vwBankAccount AS BankAccount ON ChequeBook.BankAccountRef = BankAccount.BankAccountId INNER JOIN
          RPA.BankBranch AS BankBranch ON BankAccount.BankBranchRef = BankBranch.BankBranchId INNER JOIN
          RPA.Bank AS Bank ON BankBranch.BankRef = Bank.BankId

