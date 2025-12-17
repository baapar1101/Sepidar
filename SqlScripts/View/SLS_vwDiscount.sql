If Object_ID('SLS.vwDiscount') Is Not Null
	Drop View SLS.vwDiscount
GO
CREATE VIEW SLS.vwDiscount
AS
SELECT	 D.DiscountID
      ,D.Number
      ,D.Title
      ,D.Title_En
      ,D.SaleVolumeType
      ,D.DiscountCalcType
	  ,ISNULL(D.DiscountCalculationBasis,0) DiscountCalculationBasis
      ,D.IsActive
      ,D.StartDate
      ,D.EndDate
      ,D.SaleTypeRef, S.Number SaleTypeNumber, S.Title AS SaleTypeTitle,  S.Title_En AS SaleTypeTitle_En
      ,D.CurrencyRef, C.Title AS CurrencyTitle, C.Title_En AS CurrencyTitle_En
      ,D.CustomerGroupingRef, g.Code CustomerGroupingCode,  G.Title AS CustomerGroupingTitle, G.Title_En AS CustomerGroupingTitle_En
	  ,D.Version
      ,D.Creator
      ,D.CreationDate
      ,D.LastModifier
      ,D.LastModificationDate
FROM   SLS.Discount AS D
LEFT OUTER JOIN SLS.SaleType AS S ON D.SaleTypeRef = S.SaleTypeId 
LEFT OUTER JOIN GNR.Currency AS C ON D.CurrencyRef = C.CurrencyID
LEFT OUTER JOIN GNR.Grouping AS G ON D.CustomerGroupingRef = G.GroupingID
