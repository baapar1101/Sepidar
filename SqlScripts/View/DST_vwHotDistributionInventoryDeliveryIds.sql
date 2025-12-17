IF OBJECT_ID('DST.vwHotDistributionInventoryDeliveryIds') IS NOT NULL
	DROP VIEW DST.vwHotDistributionInventoryDeliveryIds
GO

CREATE VIEW DST.vwHotDistributionInventoryDeliveryIds
AS

SELECT
	[HD].[HotDistributionId]
   ,[HD].[Number] AS [HotDistributionNumber]
   ,[InventoryDeliveryIds].[InventoryDeliveryRef]
FROM (SELECT
		[HDID].[HotDistributionRef]
	   ,[HDID].[InventoryDeliveryRef]
	FROM [DST].[HotDistributionInventoryDelivery] AS [HDID]

	UNION

	SELECT
		[HD].[HotDistributionId]
	   ,[HD].[InventoryDeliveryRef]
	FROM [DST].[HotDistribution] AS [HD]) AS InventoryDeliveryIds
JOIN [DST].[HotDistribution] AS [HD]
	ON [HD].[HotDistributionId] = [InventoryDeliveryIds].[HotDistributionRef]
WHERE [InventoryDeliveryIds].[InventoryDeliveryRef] IS NOT NULL