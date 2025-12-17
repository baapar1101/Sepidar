IF NOT EXISTS (SELECT 1 FROM FMK.IDGeneration WHERE TableName='GNR.TaxPayerBill.UniqueNumber')
BEGIN
INSERT INTO FMK.IDGeneration VALUES('GNR.TaxPayerBill.UniqueNumber',1000)
END