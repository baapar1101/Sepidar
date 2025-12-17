If Object_ID('INV.fnGetInventoryDeliveryQuntityBasedOnInvoiceItem') Is Not Null
	Drop Function INV.fnGetInventoryDeliveryQuntityBasedOnInvoiceItem
GO
-- =============================================
-- Author:		MuhammadHD
-- Create date: 
-- Description:	
-- =============================================
CREATE FUNCTION [INV].[fnGetInventoryDeliveryQuntityBasedOnInvoiceItem] ()
RETURNS TABLE
AS
	-- Add the T-SQL statements to compute the return value here
	RETURN(
	SELECT
		BaseInvoiceItem AS InvoiceItemID,
		SUM(Quantity) AS TotalQuantity,
		SUM(SecondaryQuantity) AS TotalSecondaryQuantity
	FROM
		INV.InventoryDeliveryItem II INNER JOIN INV.InventoryDelivery I ON
		II.InventoryDeliveryRef = I.InventoryDeliveryID
		WHERE BaseInvoiceItem IS NOT NULL AND I.[IsReturn]=0 AND I.[Type] = 1
	GROUP BY BaseInvoiceItem

	UNION 

	SELECT
		[II].[InvoiceItemID]
	   ,CASE
          WHEN [II].ItemType = 1 THEN [II].[Quantity]
          ELSE 0
        END As Quantity
	   ,[II].[SecondaryQuantity]
	FROM [DST].[HotDistributionSaleDocument] AS [HDSD]
	JOIN [SLS].[vwInvoiceItem] AS [II]
		ON [HDSD].[InvoiceRef] = [II].[InvoiceRef]
	WHERE [HDSD].[InvoiceRef] IS NOT NULL)



