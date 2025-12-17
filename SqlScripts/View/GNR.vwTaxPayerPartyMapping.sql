IF Object_ID('GNR.vwTaxPayerPartyMapping') IS NOT NULL
	DROP VIEW GNR.vwTaxPayerPartyMapping
GO
CREATE VIEW GNR.vwTaxPayerPartyMapping
AS
SELECT
  tppm.TaxPayerPartyMappingID
 ,p.PartyId AS PartyRef
 ,p.DLCode AS PartyCode
 ,p.DLTitle AS PartyTitle
 ,p.IsActive AS PartyIsActive
 ,p.Type AS PartyType
 ,tppm.TaxPayerPartyType AS TaxPayerPartyType
 ,tppm.Version
 ,tppm.Creator
 ,tppm.CreationDate
 ,tppm.LastModifier
 ,tppm.LastModificationDate
FROM GNR.TaxPayerPartyMapping tppm
INNER JOIN GNR.vwParty p
  ON tppm.PartyRef = p.PartyId