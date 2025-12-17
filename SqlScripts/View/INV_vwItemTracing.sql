IF Object_ID('INV.vwItemTracing') IS NOT NULL
	Drop View INV.vwItemTracing
GO

CREATE VIEW [INV].[vwItemTracing]
AS
SELECT ItemRef, TracingRef, IsSelectable, Title AS TracingTitle
FROM
(
	SELECT ItemRef, TracingRef, SUM(IsSelectable) AS IsSelectable -- IsSelectable can only be 1 once, so this sum will be 0 or 1
	FROM
	(
		SELECT ItemRef, TracingRef, 1 AS IsSelectable FROM INV.ItemStockSummary
		UNION
		SELECT ItemRef, TracingRef, 0 AS IsSelectable FROM SLS.vwItemDiscountInfo WHERE DiscountIsActive = 1 AND DiscountCalculationBasis = 0 -- 0: Item
		UNION
		SELECT DiscountedItemRef AS ItemRef, DiscountedTracingRef AS TracingRef, 0 AS IsSelectable FROM SLS.vwItemDiscountInfo WHERE DiscountIsActive = 1 AND DiscountType = 3 -- 3: AnotherItem
		UNION
		SELECT ItemRef, TracingRef, 0 AS IsSelectable FROM SLS.PriceNoteItem
		UNION
		SELECT ItemRef, TracingRef, 0 AS IsSelectable FROM SLS.ProductPackItem
		UNION
		SELECT ItemRef, TracingRef, 0 AS IsSelectable FROM DST.SalesLimitItem
	) A
	WHERE TracingRef IS NOT NULL
	GROUP BY ItemRef, TracingRef
) B
JOIN INV.Tracing ON TracingRef=TracingID
