If Object_ID('SLS.vwProductPackItem') Is Not Null
	Drop View SLS.vwProductPackItem
GO
CREATE VIEW SLS.vwProductPackItem
AS
SELECT	PPI.*,
		I.Code AS ItemCode,I.Title AS ItemTitle,I.Title_En AS ItemTitle_En,
		T.Title AS TracingTitle,
		CASE WHEN I.TracingCategoryRef IS NULL THEN 0 ELSE 1 END AS ItemHasTracing,
		I.SecondaryUnitRef AS ItemSecondaryUnitRef,
		I.UnitsRatio AS ItemUnitsRatio,
		I.IsUnitRatioConstant AS ItemIsUnitRatioConstant,
		I.IsActive AS ItemIsActive,
		I.Sellable AS ItemIsSellable
FROM   SLS.ProductPackItem AS PPI
		INNER JOIN INV.Item AS I ON PPI.ItemRef = I.ItemID 		
		LEFT JOIN INV.Tracing T ON T.TracingID = PPI.TracingRef
