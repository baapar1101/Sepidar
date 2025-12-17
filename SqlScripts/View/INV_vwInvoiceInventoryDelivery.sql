If Object_ID('INV.vwInvoiceInventoryDelivery') Is Not Null
	Drop View INV.vwInvoiceInventoryDelivery
GO
CREATE VIEW [INV].[vwInvoiceInventoryDelivery] AS
SELECT BaseInvoiceItem,
	SUM(CASE WHEN ID.IsReturn=0 THEN Quantity ELSE -Quantity END) SumQuantity,
	SUM(CASE WHEN ID.IsReturn=0 THEN SecondaryQuantity ELSE -SecondaryQuantity END) SumSecondaryQuantity
FROM
 INV.[InventoryDeliveryItem] IDI INNER JOIN INV.[InventoryDelivery] ID ON
 IDI.[InventoryDeliveryRef]=ID.[InventoryDeliveryID]
 WHERE ID.[Type]=1
 GROUP BY [BaseInvoiceItem]

UNION 

SELECT
	[II].[InvoiceItemID]
   ,[II].[Quantity]
   ,[II].[SecondaryQuantity]
FROM [DST].[HotDistributionSaleDocument] AS [HDSD]
JOIN [SLS].[InvoiceItem] AS [II]
	ON [HDSD].[InvoiceRef] = [II].[InvoiceRef]
JOIN [INV].[Item] AS [I]
	ON [II].[ItemRef] = [I].[ItemID]
WHERE [HDSD].[InvoiceRef] IS NOT NULL
AND [I].[Type] = 1 -- Product
