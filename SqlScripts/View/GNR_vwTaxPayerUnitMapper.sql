If Object_ID('GNR.vwTaxPayerUnitMapper') IS NOT NULL
	DROP VIEW GNR.vwTaxPayerUnitMapper
GO
CREATE VIEW GNR.vwTaxPayerUnitMapper
AS
SELECT
  u.UnitID AS UnitID
 ,u.Title AS UnitTitle
 ,tpum.TaxPayerMapperUnitID
 ,tpum.UnitRef
 ,tpum.TaxPayerUnitRef
 ,tpu.Code AS TaxPayerUnitCode
 ,tpu.Ttile AS TaxPayerUnitTitle
 ,tpum.Version
 ,tpum.Creator
 ,tpum.CreationDate
 ,tpum.LastModifier
 ,tpum.LastModificationDate
FROM INV.Unit u
INNER JOIN GNR.TaxPayerUnitMapper tpum
  ON u.UnitID = tpum.UnitRef
LEFT JOIN GNR.TaxPayerUnit tpu
  ON tpum.TaxPayerUnitRef = tpu.TaxPayerUnitID
