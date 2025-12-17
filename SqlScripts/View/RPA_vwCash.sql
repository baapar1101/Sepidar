If Object_ID('RPA.vwCash') Is Not Null
	Drop View RPA.vwCash
GO
CREATE VIEW RPA.vwCash
AS
SELECT     Cash.CashId, Cash.Title_En, Cash.Title, Cash.DlRef, Cash.CurrencyRef, DL.IsActive, Cash.FirstAmount, Cash.FirstDate, 
                      Currency.Title AS CurrencyTitle, Cash.Version, Cash.Rate, Cash.Creator, Cash.CreationDate, Cash.LastModifier, DL.Title AS DlTitle, 
                      DL.Code AS DlCode, Cash.LastModificationDate, DL.Title_En AS DlTitle_En, Cash.Balance, Currency.Title_En AS CurrencyTitle_En
FROM         RPA.Cash AS Cash 
	INNER JOIN GNR.Currency AS Currency ON Currency.CurrencyID = Cash.CurrencyRef 
	INNER JOIN ACC.DL DL ON Cash.DlRef = DL.DLId

