If Object_ID('SLS.vwPriceNoteItem') Is Not Null
	Drop View SLS.vwPriceNoteItem
GO
CREATE VIEW SLS.vwPriceNoteItem
AS
SELECT     PNI.PriceNoteItemID, PNI.PriceNoteRef, PNI.SaleTypeRef, ST.Title AS SaleTypeTitle, ST.Title_En AS SaleTypeTitle_En, PNI.ItemRef, PNI.CanChangeInvoiceFee, PNI.CanChangeInvoiceDiscount, 
		   PNI.UnitRef, PNI.CurrencyRef,PNI.Fee, PNI.Discount, PNI.AdditionRate,PNI.TracingRef,PNI.CustomerGroupingRef,
		   PNI.LowerMargin,PNI.UpperMargin,
           I.Code AS ItemCode, I.Title AS ItemTitle, I.Title_En AS ItemTitle_En,I.ConsumerFee,
           CASE WHEN I.TracingCategoryRef IS NULL THEN 0 ELSE 1 END AS ItemHasTracing,
           GR.Title AS ItemSaleGroupTitle,GR.Title_En AS ItemSaleGroupTitle_En,GR.Code AS ItemSaleGroupCode,
           U.Title AS UnitTitle, U.Title_En AS UnitTitle_En, 
           C.Title AS CurrencyTitle, C.Title_En AS CurrencyTitle_En, C.PrecisionCount AS CurrencyPrecisionCount, 
           ST.Number SaleTypeNumber,
           T.Title AS TracingTitle,
           GRC.Title AS CustomerGroupingTitle,GRC.Title_En AS CustomerGroupingTitle_En
FROM   SLS.PriceNoteItem AS PNI 
		INNER JOIN SLS.SaleType AS ST ON PNI.SaleTypeRef = ST.SaleTypeId 
		INNER JOIN INV.Unit AS U ON PNI.UnitRef = U.UnitID 
		INNER JOIN INV.Item AS I ON PNI.ItemRef = I.ItemID 		
        INNER JOIN GNR.Currency AS C ON PNI.CurrencyRef = C.CurrencyID
        LEFT JOIN  GNR.[Grouping] GR ON I.SaleGroupRef = GR.GroupingID 
        LEFT JOIN INV.Tracing AS T ON T.TracingID = PNI.TracingRef
        LEFT JOIN GNR.[Grouping] GRC ON GRC.GroupingID = PNI.CustomerGroupingRef


