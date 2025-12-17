IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=object_id('GNR.TaxPayerCurrency') and [name] = 'UniversalCode') AND
   EXISTS (SELECT 1 FROM GNR.TaxPayerCurrency WHERE UniversalCode IS NULL)
BEGIN
UPDATE GNR.TaxPayerCurrency
SET UniversalCode = RIGHT(Title, 3) WHERE UniversalCode IS NULL
END