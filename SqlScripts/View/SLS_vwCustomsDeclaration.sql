If Object_ID('SLS.vwCustomsDeclaration') Is Not Null
    Drop View SLS.vwCustomsDeclaration
GO
CREATE VIEW SLS.vwCustomsDeclaration
AS
SELECT CD.[CustomsDeclarationId],
       CD.[Number],
       CD.[CottageNumber],
       CD.[CottageDate],
       CD.Price,
       CD.PriceInBaseCurrency,
       CD.OtherTaxes,
       CD.OtherAmounts,
       CD.[State],
       CD.[FiscalYearRef],
       CD.[CurrencyRef],
       CD.[Rate],
       C.Title AS CurrencyTitle,
       C.PrecisionCount AS CurrencyPrecisionCount,
       CD.TaxPayerBillIssueDateTime,
       CD.[SellerCustomsDeclarationCode],
       CD.[Version],
       CD.[Creator],
       CD.[CreationDate],
       CD.[LastModifier],
       CD.[LastModificationDate]
FROM SLS.CustomsDeclaration CD
LEFT JOIN GNR.Currency AS C ON CD.CurrencyRef = C.CurrencyID 
