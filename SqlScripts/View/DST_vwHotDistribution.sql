IF OBJECT_ID('DST.vwHotDistribution') IS NOT NULL
	DROP VIEW DST.vwHotDistribution
GO

CREATE VIEW DST.vwHotDistribution
AS

SELECT
	HD.[HotDistributionId]
   ,HD.[Date]
   ,HD.[Number]
   ,HD.[DistributorPartyRef]
   ,DistP.[DLRef] AS [DistributorPartyDLRef]
   ,DistP.[DLCode] AS [DistributorPartyDLCode]
   ,DistP.[DLTitle] AS [DistributorPartyDLTitle]
   ,DistP.[DLTitle_En] AS [DistributorPartyDLTitle_En]
   ,HD.[TruckRef]
   ,T.[Title] AS [TruckTitle]
   ,T.[Title_En] AS [TruckTitle_En]
   ,T.[MinimumWeight] AS [TruckMinimumWeight]
   ,T.[MaximumWeight] AS [TruckMaximumWeight]
   ,T.[MinimumVolumeCapacity] AS [TruckMinimumVolume]
   ,T.[MaximumVolumeCapacity] AS [TruckMaximumVolume]
   ,HD.[DriverPartyRef]
   ,DrvP.[DLRef] AS [DriverPartyDLRef]
   ,DrvP.[DLCode] AS [DriverPartyDLCode]
   ,DrvP.[DLTitle] AS [DriverPartyDLTitle]
   ,DrvP.[DLTitle_En] AS [DriverPartyDLTitle_En]
   ,HD.[StockRef]
   ,S.[Code] AS [StockCode]
   ,S.[Title] AS [StockTitle]
   ,S.[Title_En] AS [StockTitle_En]
   ,[HotDistributionItemsWeightAndVolume].[TotalWeigth]
   ,[HotDistributionItemsWeightAndVolume].[TotalVolume]
   ,HD.[InventoryDeliveryRef]
   ,ID.[Number] AS [InventoryDeliveryNumber]
   ,HD.[State]
   ,HD.[IsModifiedByDevice]
   ,HD.[FiscalYearRef]
   ,HD.[TransferHotDistributionRef]
   ,HD.[Version]
   ,HD.[Creator]
   ,HD.[CreationDate]
   ,HD.[LastModifier]
   ,HD.[LastModificationDate]
   ,CU.Name CreatorName
   ,MU.Name LastModifierName
FROM DST.HotDistribution AS HD
INNER JOIN FMk.[User] CU 
	ON HD.Creator = CU.UserID
INNER JOIN FMk.[User] MU 
	ON HD.LastModifier = MU.UserID
LEFT JOIN GNR.vwParty AS DistP
	ON HD.[DistributorPartyRef] = DistP.[PartyId]
LEFT JOIN GNR.vwTruck AS T
	ON HD.[TruckRef] = T.[TruckID]
LEFT JOIN GNR.vwParty AS DrvP
	ON HD.[DriverPartyRef] = DrvP.[PartyId]
LEFT JOIN INV.Stock AS S
	ON HD.[StockRef] = S.[StockID]
LEFT JOIN INV.InventoryDelivery AS ID
	ON HD.[InventoryDeliveryRef] = ID.[InventoryDeliveryID]
LEFT JOIN (SELECT
		[HDI].[HotDistributionRef]
	   ,SUM([HDI].[TotalWeight]) AS [TotalWeigth]
	   ,SUM([HDI].[TotalVolume]) AS [TotalVolume]
	FROM [DST].[vwHotDistributionItem] AS [HDI]
	GROUP BY [HDI].[HotDistributionRef]) AS [HotDistributionItemsWeightAndVolume]
	ON [HotDistributionItemsWeightAndVolume].[HotDistributionRef] = [HD].[HotDistributionId]


