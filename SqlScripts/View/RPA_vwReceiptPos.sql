If Object_ID('RPA.vwReceiptPos') Is Not Null
	Drop View RPA.vwReceiptPos
GO
CREATE VIEW RPA.vwReceiptPos
AS
SELECT
            -- Bank.Title + ' ' + BankBranch.Title + ' ' + BankAccount.AccountNo AS BankAccountTitle,
            BankAccount.BankAccountTitle AS BankAccountTitle,
            ReceiptPos.ReceiptPosId, ReceiptPos.PosRef, 
            ReceiptPos.Amount, ReceiptPos.state, ReceiptPos.Version, ReceiptPos.ReceiptHeaderRef, ReceiptPos.HeaderNumber, ReceiptPos.HeaderDate, 
            ReceiptPos.CurrencyRef, ReceiptPos.Rate, GNR.Currency.Title AS CurrencyTitle, GNR.Currency.Title_En AS CurrencyTitle_En, 
            Pos.TerminalNo AS TerminalNumber, ReceiptPos.AmountInBaseCurrency, 
		-- Bank.Title_En + ' ' + BankBranch.Title_En + ' ' + BankAccount.AccountNo AS BankAccountTitle_En,
		BankAccount.BankAccountTitle_En AS BankAccountTitle_En,
	[ReceiptPos].[TrackingCode]
FROM         RPA.ReceiptPos AS ReceiptPos INNER JOIN
      RPA.Pos AS Pos ON Pos.PosId = ReceiptPos.PosRef INNER JOIN
      RPA.vwBankAccount AS BankAccount ON BankAccount.BankAccountId = Pos.BankAccountRef INNER JOIN
      RPA.BankBranch AS BankBranch ON BankBranch.BankBranchId = BankAccount.BankBranchRef INNER JOIN
      RPA.Bank AS Bank ON BankBranch.BankRef = Bank.BankId INNER JOIN
      GNR.Currency ON ReceiptPos.CurrencyRef = GNR.Currency.CurrencyID

