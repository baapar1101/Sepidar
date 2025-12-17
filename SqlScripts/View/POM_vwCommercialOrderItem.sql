If Object_ID('POM.vwCommercialOrderItem') Is Not Null
	Drop View POM.vwCommercialOrderItem
GO
CREATE VIEW POM.vwCommercialOrderItem
AS
SELECT  COI.CommercialOrderItemId,  
		COI.CommercialOrderRef,
		COI.PurchaseOrderItemRef, COI.RowNumber,
		RegisterFee,
		POI.ItemRef, POI.ItemCode, POI.ItemTitle, ItemTitle_En,
		POI.Quantity,  POI.SecondaryQuantity, POI.TracingTitle,POI.TracingRef, POI.NetPrice  Price,
		PO.CurrencyRef,
		PO.CurrencyRate,
		PO.CurrencyTitle,
		PO.CurrencyTitle_En

FROM  POM.CommercialOrderItem COI INNER JOIN
	  POM.vwPurchaseOrderItem POI ON  CoI.PurchaseOrderItemRef = poI.purchaseOrderItemID
	                              INNER JOIN
      POM.vwPurchaseOrder PO      ON   POI.PurchaseOrderRef=PO.PurchaseOrderID