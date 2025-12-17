IF Object_ID('GNR.vwTaxPayerItemMapping') IS NOT NULL
	DROP VIEW GNR.vwTaxPayerItemMapping
GO
CREATE VIEW GNR.vwTaxPayerItemMapping
AS
SELECT
    IM.TaxPayerItemMappingID,
    I.ItemID AS ItemRef,
    I.Code AS ItemCode,
    I.Title AS ItemTitle,
    I.[Type] as ItemType,
    IM.Serial,
    G.Title AS SaleGroupTitle,
    I.IsActive ItemIsActive,
    IM.TaxPayerCurrencyRef,
    TPC.UniversalCode AS TaxPayerCurrencyUniversalCode,
    tpc.Code AS TaxPayerCurrencyCode,
    TPC.Title AS TaxPayerCurrencyTitle,
    IM.[Version]
FROM GNR.TaxPayerItemMapping IM
INNER JOIN INV.Item I ON IM.ItemRef = I.ItemID
LEFT JOIN GNR.[Grouping] G ON I.SaleGroupRef = G.GroupingID
LEFT JOIN GNR.TaxPayerCurrency TPC ON IM.TaxPayerCurrencyRef = TPC.TaxPayerCurrencyID