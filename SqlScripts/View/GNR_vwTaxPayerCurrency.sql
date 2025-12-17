--<<FileName:GNR_vwTaxPayerCurrency.sql>>--

IF OBJECT_ID('GNR.vwTaxPayerCurrency') IS NOT NULL
  DROP VIEW GNR.vwTaxPayerCurrency
GO
CREATE VIEW GNR.vwTaxPayerCurrency
AS
SELECT
  tpc.TaxPayerCurrencyID
 ,tpc.Code
 ,tpc.Title
 ,tpc.UniversalCode
 ,tpc.Version
 ,tpc.Creator
 ,tpc.CreationDate
 ,tpc.LastModifier
 ,tpc.LastModificationDate
FROM GNR.TaxPayerCurrency tpc