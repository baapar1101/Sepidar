If Object_ID('SLS.vwAdditionFactor') Is Not Null
	Drop View SLS.vwAdditionFactor
GO
CREATE VIEW SLS.vwAdditionFactor
AS
SELECT	 
    AF.AdditionFactorID, AF.Number, AF.Title, AF.Title_En, AF.SaleVolumeType, AF.Basis,
    AF.IsActive, AF.StartDate, AF.EndDate, AF.IsEffectiveOnVat,
    AF.SaleTypeRef, S.Number AS SaleTypeNumber, S.Title AS SaleTypeTitle, S.Title_En AS SaleTypeTitle_En,
    AF.SLRef, A.FullCode AS SLCode, A.Title AS SLTitle, A.Title_En AS SLTitle_En,
    AF.CurrencyRef, C.Title AS CurrencyTitle, C.Title_En AS CurrencyTitle_En,
    AF.CustomerGroupingRef, g.Code CustomerGroupingCode,  G.Title AS CustomerGroupingTitle, G.Title_En AS CustomerGroupingTitle_En,
	AF.Version, AF.Creator, AF.CreationDate, AF.LastModifier, AF.LastModificationDate
FROM 
    SLS.AdditionFactor AS AF
    LEFT OUTER JOIN SLS.SaleType AS S ON AF.SaleTypeRef = S.SaleTypeId 
    LEFT OUTER JOIN GNR.Currency AS C ON AF.CurrencyRef = C.CurrencyID
    LEFT OUTER JOIN GNR.Grouping AS G ON AF.CustomerGroupingRef = G.GroupingID
    INNER JOIN ACC.vwAccount AS A ON AF.SLRef = A.AccountID
