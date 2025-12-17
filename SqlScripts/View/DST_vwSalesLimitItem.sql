IF Object_ID('DST.vwSalesLimitItem') IS NOT NULL
	DROP VIEW DST.vwSalesLimitItem
GO

CREATE VIEW DST.vwSalesLimitItem
AS
SELECT [SalesLimitItemId]
      , [SalesLimitRef]
	  , SLI.ItemRef,  
   I.Code AS ItemCode,I.Title AS ItemTitle,I.Title_En AS ItemTitle_En,  
   I.UnitRef, U1.Title AS UnitTitle, U1.Title_En AS UnitTitle_En, I.SecondaryUnitRef, U2.Title AS SecondaryUnitTitle,
   I.IsUnitRatioConstant, I.UnitsRatio,
   SLI.TracingRef, T.Title AS TracingTitle,CASE WHEN I.TracingCategoryRef IS NULL THEN 0 ELSE 1 END AS ItemHasTracing  
   FROM [DST].[SalesLimitItem] SLI
	 INNER JOIN Inv.Item I On SLI.ItemRef = I.ItemID  
	 LEFT JOIN INV.Tracing T ON t.TracingID = SLI.TracingRef
	 	LEFT OUTER JOIN INV.Unit AS u1 ON I.UnitRef = u1.UnitID 	
	LEFT OUTER JOIN INV.Unit AS u2 ON I.SecondaryUnitRef = u2.UnitID 

	