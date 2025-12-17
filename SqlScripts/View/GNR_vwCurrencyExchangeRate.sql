If Object_ID('GNR.vwCurrencyExchangeRate') Is Not Null
	Drop View GNR.vwCurrencyExchangeRate
GO
CREATE VIEW GNR.vwCurrencyExchangeRate
AS
SELECT     R.CurrencyExchangeRateId, R.CurrencyRef, R.EffectiveDate, 
                      R.ExchangeRate, R.Version, R.Creator, 
                      R.CreationDate, R.LastModifier, R.LastModificationDate, 
                      C.Title AS CurrencyTitle, C.Title_En AS CurrencyTitle_En, C.ExchangeUnit, R.FiscalYearRef
FROM         Gnr.Currency C INNER JOIN
                      GNR.CurrencyExchangeRate R ON C.CurrencyID = R.CurrencyRef

