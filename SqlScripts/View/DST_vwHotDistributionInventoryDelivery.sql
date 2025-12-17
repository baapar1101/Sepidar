IF OBJECT_ID('DST.vwHotDistributionInventoryDelivery') IS NOT NULL
	DROP VIEW DST.vwHotDistributionInventoryDelivery
GO

CREATE VIEW DST.vwHotDistributionInventoryDelivery
AS

SELECT
	[HDID].[HotDistributionInventoryDeliveryId]
   ,[HDID].[HotDistributionRef]
   ,[HDID].[ReturnedInvoiceRef]
   ,[HDID].[InventoryDeliveryRef]
   ,[ID].[Number] AS [InventoryDeliveryNumber]
   ,[ID].[Date] AS [InventoryDeliveryDate]
FROM [DST].[HotDistributionInventoryDelivery] AS [HDID]
JOIN [INV].[InventoryDelivery] AS [ID]
	ON [HDID].[InventoryDeliveryRef] = [ID].[InventoryDeliveryID]
WHERE [ID].[IsReturn] = 0

