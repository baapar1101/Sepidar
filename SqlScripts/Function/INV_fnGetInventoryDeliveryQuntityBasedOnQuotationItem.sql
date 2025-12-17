If Object_ID('INV.fnGetInventoryDeliveryQuntityBasedOnQuotationItem') Is Not Null
	Drop Function INV.fnGetInventoryDeliveryQuntityBasedOnQuotationItem
GO

CREATE FUNCTION [INV].[fnGetInventoryDeliveryQuntityBasedOnQuotationItem] ()
RETURNS TABLE
AS
	RETURN(
	SELECT
		II.QuotationItemRef,
		SUM(II.Quantity) AS TotalQuantity,
		SUM(II.SecondaryQuantity) AS TotalSecondaryQuantity
	FROM INV.InventoryDeliveryItem II
		INNER JOIN INV.InventoryDelivery I ON II.InventoryDeliveryRef = I.InventoryDeliveryID
	WHERE QuotationItemRef IS NOT NULL AND I.IsReturn = 0 AND I.[Type] = 1
	GROUP BY QuotationItemRef)



