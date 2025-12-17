IF OBJECT_ID('DST.vwHotDistributionInventoryDeliveryReturn') IS NOT NULL
	DROP VIEW DST.vwHotDistributionInventoryDeliveryReturn
GO

CREATE VIEW DST.vwHotDistributionInventoryDeliveryReturn
AS

SELECT
	[HDID].[HotDistributionInventoryDeliveryId]
   ,[HDID].[HotDistributionRef]
   ,[HDID].[InventoryDeliveryRef]
   ,[ID].[Number]					AS [InventoryDeliveryReturnNumber]
   ,[ID].[Date]						AS [InventoryDeliveryReturnDate]	
FROM [DST].[HotDistributionInventoryDelivery] AS [HDID]
	JOIN [INV].[InventoryDelivery] AS [ID]
		ON [HDID].[InventoryDeliveryRef] = [ID].[InventoryDeliveryID]
WHERE [ID].[IsReturn] = 1

