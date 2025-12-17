If Object_ID('SLS.vwItemAdditionFactor') Is Not Null
	Drop View SLS.vwItemAdditionFactor
GO

CREATE view SLS.vwItemAdditionFactor as  
SELECT  
    IAF.ItemAdditionFactorID, IAF.AdditionFactorRef, 
    IAF.ItemRef,  
    I.Code AS ItemCode, I.Title AS ItemTitle, I.Title_En AS ItemTitle_En,  
    IAF.TracingRef, 
    T.Title AS TracingTitle, CASE WHEN I.TracingCategoryRef IS NULL THEN 0 ELSE 1 END AS ItemHasTracing  
FROM 
    SLS.ItemAdditionFactor IAF
    INNER JOIN Inv.Item I On IAF.ItemRef = I.ItemID  
    LEFT JOIN INV.Tracing T ON T.TracingID = IAF.TracingRef
