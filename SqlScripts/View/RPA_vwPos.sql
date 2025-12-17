If Object_ID('RPA.vwPos') Is Not Null
	Drop View RPA.vwPos
GO
CREATE VIEW RPA.vwPos
AS
SELECT     Pos.PosId, Pos.BankAccountRef, Pos.TerminalNo, Pos.DlRef, Pos.FirstAmount, ACC.DL.IsActive, 
      --     Bank.Title + ' ' + Branch.Title + ' ' + Account.AccountNo AS BankAccountTitle,
          Account.BankAccountTitle AS BankAccountTitle,
          Pos.CurrencyRef, Currency.Title AS CurrencyTitle, Pos.Version, Pos.Rate, 
          Pos.Creator, Pos.CreationDate, Pos.LastModifier, Pos.LastModificationDate, ACC.DL.Code AS DlCode, ACC.DL.Title AS DlTitle, 
          ACC.DL.Title_En AS DlTitle_En, Pos.Balance,
      --     Bank.Title_En + ' ' + Branch.Title_En + ' ' + Account.AccountNo AS BankAccountTitle_En
          Account.BankAccountTitle_En AS BankAccountTitle_En
FROM         RPA.Pos AS Pos INNER JOIN
      RPA.vwBankAccount AS Account ON Pos.BankAccountRef = Account.BankAccountId INNER JOIN
      RPA.BankBranch AS Branch ON Account.BankBranchRef = Branch.BankBranchId INNER JOIN
      RPA.Bank AS Bank ON Bank.BankId = Branch.BankRef INNER JOIN
      GNR.Currency AS Currency ON Currency.CurrencyID = Pos.CurrencyRef INNER JOIN
      ACC.DL ON Pos.DlRef = ACC.DL.DLId

