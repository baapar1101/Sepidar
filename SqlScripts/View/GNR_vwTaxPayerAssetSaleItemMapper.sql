IF Object_ID('GNR.vwTaxPayerAssetSaleItemMapper') IS NOT NULL
	DROP VIEW GNR.vwTaxPayerAssetSaleItemMapper
GO
CREATE VIEW GNR.vwTaxPayerAssetSaleItemMapper
AS
SELECT
    M.[TaxPayerAssetSaleItemMapperID],
    M.[Serial],
    M.[SerialTitle],
    M.[TaxRate],
    M.[Version]
FROM GNR.TaxPayerAssetSaleItemMapper M