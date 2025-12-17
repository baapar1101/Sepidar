IF OBJECT_ID('POM.vwCommercialOrderCostedPrices') IS NOT NULL
	DROP VIEW POM.vwCommercialOrderCostedPrices
GO
Create View POM.vwCommercialOrderCostedPrices
AS
	SELECT IPI.CommercialOrderItemID
		,IPI.PurchaseOrderItemRef
		,IPI.CommercialOrderRef
		,MIN(IPI.RegisterFee) AS Price
		,MIN(IPI.RegisterFee) AS PriceInBaseCurrency
		,ISNULL(SUM(PCI.TotalCommercialOrder), 0) AS UsedPrice
		,ISNULL(SUM(PCI.TotalCommercialOrderInBaseCurrency), 0) AS UsedPriceInBaseCurrency
		,MAX(CASE WHEN PCI.PurchaseCostItemID IS NULL THEN 0 ELSE 1 END) AS HasPurchaseCostItem
	FROM POM.CommercialOrderItem AS IPI
		LEFT JOIN POM.PurchaseCostItem PCI ON IPI.CommercialOrderItemID = PCI.CommercialOrderItemRef
	GROUP BY IPI.CommercialOrderItemID , IPI.CommercialOrderRef, IPI.PurchaseOrderItemRef

GO
