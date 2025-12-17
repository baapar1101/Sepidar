--<<FileName:GNR_vwTaxPayerUnit.sql>>--

IF OBJECT_ID('GNR.vwTaxPayerUnit') IS NOT NULL
  DROP VIEW GNR.vwTaxPayerUnit
GO

CREATE VIEW GNR.vwTaxPayerUnit
AS
SELECT
  tpu.TaxPayerUnitID
 ,tpu.Code
 ,tpu.Ttile
 ,tpu.Version
 ,tpu.Creator
 ,tpu.CreationDate
 ,tpu.LastModifier
 ,tpu.LastModificationDate
 ,u.Name AS CreatorName
 ,MU.Name AS LastModifierName
FROM GNR.TaxPayerUnit tpu
INNER JOIN FMK.[User] u
  ON tpu.Creator = u.UserID
INNER JOIN FMK.[User] MU
  ON tpu.LastModifier = MU.UserID