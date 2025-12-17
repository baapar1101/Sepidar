IF Object_ID('GNR.vwTaxPayerContractMapper') IS NOT NULL
	DROP VIEW GNR.vwTaxPayerContractMapper
GO
CREATE VIEW GNR.vwTaxPayerContractMapper
AS
SELECT
    tpcm.TaxPayerContractMapperID,
    c.ContractID AS ContractRef,
    c.DocumentNumber AS DocumentNumber,
    c.Title AS ContractTitle,
    c.DLTitle AS DlTitle,
    tpcm.TaxPayerContractSerial,
    c.IsActive,
    tpcm.[Version]
FROM GNR.TaxPayerContractMapper tpcm
INNER JOIN CNT.vwContract c ON tpcm.ContractRef = c.ContractID
WHERE c.Nature = 1