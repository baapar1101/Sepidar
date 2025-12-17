IF OBJECT_ID('SLS.vwDiscountQuantityItem') IS NOT NULL
  DROP VIEW SLS.vwDiscountQuantityItem
GO
CREATE VIEW SLS.vwDiscountQuantityItem
AS
SELECT
  DI.*
 ,I.Code AS ItemCode
 ,I.Title AS ItemTitle
 ,I.Title_En AS ItemTitle_En
 ,T.Title AS TracingTitle
 ,CASE
    WHEN I.TracingCategoryRef IS NULL THEN 0
    ELSE 1
  END AS ItemHasTracing
 ,GR1.FullCode AS PurchaseGroupCode
 ,GR1.Title AS PurchaseGroupTitle
 ,GR1.Title_En AS PurchaseGroupTitle_En
 ,GR2.FullCode AS SaleGroupCode
 ,GR2.Title AS SaleGroupTitle
 ,GR2.Title_En AS SaleGroupTitle_En
FROM SLS.DiscountQuantityItem AS DI
LEFT JOIN INV.Item AS I
  ON DI.ItemRef = I.ItemID
LEFT JOIN INV.Tracing T
  ON T.TracingID = DI.TracingRef
LEFT JOIN GNR.[vwGrouping] GR1
  ON DI.PurchaseGroupRef = GR1.GroupingID
LEFT JOIN GNR.[vwGrouping] GR2
  ON DI.SalesGroupRef = GR2.GroupingID