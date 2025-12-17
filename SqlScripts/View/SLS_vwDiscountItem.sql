If Object_ID('SLS.vwDiscountItem') Is Not Null
	Drop View SLS.vwDiscountItem
GO
CREATE VIEW SLS.vwDiscountItem
AS
SELECT	DI.*
		,I.Code AS ItemCode
		,I.Title AS ItemTitle
		,I.Title_En AS ItemTitle_En
		,PP.Title AS ProductPackTitle
		,T.Title AS TracingTitle
		,CASE WHEN I.TracingCategoryRef IS NULL THEN 0 ELSE 1 END AS ItemHasTracing
		,DIG.Title AS DiscountItemGroupTitle
		,DIG.Title_En AS DiscountItemGroupTitle_En
FROM   SLS.DiscountItem AS DI
		LEFT JOIN INV.Item AS I ON DI.ItemRef = I.ItemID 		
		LEFT JOIN SLS.ProductPack PP ON PP.ProductPackID = DI.ProductPackRef
		LEFT JOIN INV.Tracing T ON t.TracingID = DI.TracingRef
		LEFT JOIN SLS.DiscountItemGroup DIG ON DIG.DiscountItemGroupID = DI.DiscountItemGroupRef
		
