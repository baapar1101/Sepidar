If Object_ID('RPA.vwBankAccount') Is Not Null
	Drop View RPA.vwBankAccount
GO
CREATE VIEW RPA.vwBankAccount
AS
SELECT
        Account.BankAccountId, Account.BankBranchRef, Account.AccountNo, Account.AccountTypeRef, Account.DlRef, ACC.DL.IsActive, Account.CurrencyRef, 
        Account.FirstAmount, Account.FirstDate, Bank.Title + ' ' + Branch.Title AS BankBranchTitle, Bank.Title_En + ' ' + Branch.Title_En AS BankBranchTitle_En,
        AccountType.Title AS AccountTypeTitle, Currency.Title AS CurrencyTitle, Account.[Version], Account.Rate, Account.Creator, Account.CreationDate, 
        Account.LastModifier, Account.LastModificationDate, ACC.DL.Title AS DlTitle, ACC.DL.Code AS DlCode, ACC.DL.Title_En AS DlTitle_En, Account.Balance, 
        Currency.PrecisionCount, Account.BillFirstAmount,
        -- Bank.Title + ' ' + Branch.Title + ' ' + Account.AccountNo AS BankAccountTitle, 
        -- Bank.Title_En + ' ' + Branch.Title_En + ' ' + Account.AccountNo AS BankAccountTitle_En,
        ACC.DL.Title AS BankAccountTitle,
        ACC.DL.Title_En AS BankAccountTitle_En,
        AccountType.Title_En AS AccountTypeTitle_En, 
        Currency.Title_En AS CurrencyTitle_En, Account.ClearFormatName, Bank.Title AS BankTitle, Bank.Title_En AS BankTitle_En, 
        Branch.Code AS BranchCode, Branch.Title AS BranchTitle, Branch.Title_En AS BranchTitle_En, Account.[Owner], Account.Owner_En, 
        Account.BlockedAmount, ShowBankFeeSeparately, Account.ShebaNumber, Account.CreditCardNumber
    FROM
        RPA.BankAccount AS Account 
        INNER JOIN RPA.BankBranch AS Branch ON Account.BankBranchRef = Branch.BankBranchId 
        INNER JOIN RPA.Bank AS Bank ON Bank.BankId = Branch.BankRef 
        INNER JOIN RPA.AccountType AS AccountType ON AccountType.AccountTypeId = Account.AccountTypeRef 
        INNER JOIN GNR.Currency AS Currency ON Currency.CurrencyID = Account.CurrencyRef 
        INNER JOIN ACC.DL ON Account.DlRef = ACC.DL.DLId