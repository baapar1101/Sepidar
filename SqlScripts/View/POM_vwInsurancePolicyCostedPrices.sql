IF OBJECT_ID('POM.vwInsurancePolicyCostedPrices') IS NOT NULL
	DROP VIEW POM.vwInsurancePolicyCostedPrices
GO
Create View POM.vwInsurancePolicyCostedPrices
AS
	SELECT IPI.InsurancePolicyItemID
		,IPI.BasePurchaseOrderItemRef
		,IPI.InsurancePolicyRef
		,MIN(IPI.Price) AS Price
		,MIN(IPI.PriceInBaseCurrency) AS PriceInBaseCurrency
		,ISNULL(SUM(PCI.TotalInsurancePolicy), 0) AS UsedPrice
		,ISNULL(SUM(PCI.TotalInsurancePolicyInBaseCurrency), 0) AS UsedPriceInBaseCurrency
		,MAX(CASE WHEN PCI.PurchaseCostItemID IS NULL THEN 0 ELSE 1 END) AS HasPurchaseCostItem
		,IP.FiscalYearRef
	FROM POM.InsurancePolicyItem AS IPI
	INNER JOIN POM.InsurancePolicy AS IP
		ON IPI.InsurancePolicyRef=IP.InsurancePolicyID
	LEFT JOIN POM.PurchaseCostItem PCI ON IPI.InsurancePolicyItemID = PCI.InsurancePolicyItemRef
	GROUP BY IPI.InsurancePolicyItemID , IPI.InsurancePolicyRef, IPI.BasePurchaseOrderItemRef ,IP.FiscalYearRef

GO
