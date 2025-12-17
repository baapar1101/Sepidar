If Object_ID('SLS.vwItemDiscount') Is Not Null
	Drop View SLS.vwItemDiscount
GO

CREATE view SLS.vwItemDiscount as  
SELECT  IOD.ItemDiscountID,  IOD.DiscountRef, IOD.ItemRef,  
   I.Code AS ItemCode,I.Title AS ItemTitle,I.Title_En AS ItemTitle_En,  
   IOD.TracingRef, T.Title AS TracingTitle,CASE WHEN I.TracingCategoryRef IS NULL THEN 0 ELSE 1 END AS ItemHasTracing  
 FROM SLS.ItemDiscount IOD   
  INNER JOIN Inv.Item I On IOD.ItemRef = I.ItemID  
    LEFT JOIN INV.Tracing T ON t.TracingID = IOD.TracingRef