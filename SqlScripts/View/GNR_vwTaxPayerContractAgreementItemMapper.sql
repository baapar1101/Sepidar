IF Object_ID('GNR.vwTaxPayerContractAgreementItemMapper') IS NOT NULL
	DROP VIEW GNR.vwTaxPayerContractAgreementItemMapper
GO
CREATE VIEW GNR.vwTaxPayerContractAgreementItemMapper
AS
SELECT
    M.[TaxPayerContractAgreementItemMapperID],
    M.[Serial],
    M.[SerialTitle],
    M.[TaxRate],
    M.[Version]
FROM GNR.TaxPayerContractAgreementItemMapper M