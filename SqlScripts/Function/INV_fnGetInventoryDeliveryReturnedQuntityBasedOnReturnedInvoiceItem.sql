If Object_ID('INV.fnGetInventoryDeliveryReturnedQuntityBasedOnReturnedInvoiceItem') Is Not Null
	Drop Function INV.fnGetInventoryDeliveryReturnedQuntityBasedOnReturnedInvoiceItem
GO
-- =============================================
-- Author:		MuhammadHD
-- Create date: 
-- Description:	
-- =============================================
CREATE FUNCTION [INV].[fnGetInventoryDeliveryReturnedQuntityBasedOnReturnedInvoiceItem] ()
RETURNS TABLE
AS
	-- Add the T-SQL statements to compute the return value here
	RETURN(
	SELECT
		BaseReturnedInvoiceItem AS ReturnedInvoiceItemID,
		SUM(Quantity) AS TotalQuantity,
		SUM(SecondaryQuantity) AS TotalSecondaryQuantity
	FROM
		INV.InventoryDeliveryItem II INNER JOIN INV.InventoryDelivery I ON
		II.InventoryDeliveryRef = I.InventoryDeliveryID
		WHERE BaseReturnedInvoiceItem IS NOT NULL AND I.[IsReturn] = 1 AND I.[Type] = 1
	GROUP BY BaseReturnedInvoiceItem)



