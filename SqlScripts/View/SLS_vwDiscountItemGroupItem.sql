If Object_ID('SLS.vwDiscountItemGroupItem') Is Not Null
	Drop View SLS.vwDiscountItemGroupItem
GO
CREATE VIEW SLS.vwDiscountItemGroupItem
AS
SELECT	 DIGI.*
		,I.Code
		,I.Title
		,I.Title_En
		,CASE WHEN I.TracingCategoryRef IS NULL THEN 0 ELSE 1 END AS ItemHasTracing
		,T.Title AS TracingTitle
        ,I.UnitTitle
        ,I.UnitTitle_En
        ,I.SecondaryUnitTitle
        ,I.SecondaryUnitTitle_En
		,I.IsActive
		,I.Sellable
FROM   SLS.DiscountItemGroupItem AS DIGI
		JOIN INV.vwItem AS I ON DIGI.ItemRef = I.ItemID
		LEFT JOIN INV.Tracing T ON T.TracingID = DIGI.TracingRef