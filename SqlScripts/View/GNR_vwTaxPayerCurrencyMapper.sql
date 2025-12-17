If Object_ID('GNR.vwTaxPayerCurrencyMapper') IS NOT NULL
	DROP VIEW GNR.vwTaxPayerCurrencyMapper
GO
CREATE VIEW GNR.vwTaxPayerCurrencyMapper
AS
SELECT
  tpcm.TaxPayerCurrencyMapperID
 ,c.CurrencyID AS CurrencyID
 ,c.Title AS CurrencyTitle
 ,tpcm.CurrencyRef
 ,tpcm.TaxPayerCurrencyRef
 ,tpc.Code AS TaxPayerCurrencyCode
 ,tpc.Title AS TaxPayerCurrencyTitle
 ,tpc.UniversalCode
 ,tpcm.Version
 ,tpcm.Creator
 ,tpcm.CreationDate
 ,tpcm.LastModifier
 ,tpcm.LastModificationDate
FROM GNR.Currency c
INNER JOIN GNR.TaxPayerCurrencyMapper tpcm
  ON c.CurrencyID = tpcm.CurrencyRef
LEFT JOIN GNR.TaxPayerCurrency tpc
ON tpcm.TaxPayerCurrencyRef = tpc.TaxPayerCurrencyID