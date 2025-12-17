IF Object_ID('DST.vwColdDistribution') IS NOT NULL
	DROP VIEW DST.vwColdDistribution
GO

CREATE VIEW DST.vwColdDistribution
AS

SELECT 
	CDI.[ColdDistributionId]
	, CDI.[Date]
	, CDI.[Number]
	, CDI.[DistributorPartyRef]
	, DistP.[DLCode]			AS [DistributorPartyDLCode]
	, DistP.[DLTitle]			AS [DistributorPartyDLTitle]
	, DistP.[DLTitle_En]		AS [DistributorPartyDLTitle_En]
	, CDI.[TruckRef]
	, T.[Title]					AS [TruckTitle]
	, T.[Title_En]				AS [TruckTitle_En]
	, T.[MinimumWeight]			AS [TruckMinimumWeight]
	, T.[MaximumWeight]			AS [TruckMaximumWeight]
	, T.[MinimumVolumeCapacity]	AS [TruckMinimumVolumeCapacity]
	, T.[MaximumVolumeCapacity]	AS [TruckMaximumVolumeCapacity]
	, CDI.[DriverPartyRef]
	, DrvP.[DLCode]				AS [DriverPartyDLCode]
	, DrvP.[DLTitle]			AS [DriverPartyDLTitle]
	, DrvP.[DLTitle_En]			AS [DriverPartyDLTitle_En]
	, CDI.[State]
	, CDI.[IsModifiedByDevice]
	, CDI.[FiscalYearRef]
	, CDI.[Version]
	, CDI.[Creator]
	, CDI.[CreationDate]
	, CDI.[LastModifier]
	, CDI.[LastModificationDate]
    ,CU.Name CreatorName
    ,MU.Name LastModifierName
FROM 
	DST.ColdDistribution AS CDI
		INNER JOIN FMk.[User] CU 
			ON CDI.Creator = CU.UserID
		INNER JOIN FMk.[User] MU 
			ON CDI.LastModifier = MU.UserID
		LEFT JOIN GNR.vwParty AS DistP
			ON CDI.[DistributorPartyRef] = DistP.[PartyId]
		LEFT JOIN GNR.vwTruck AS T
			ON CDI.[TruckRef] = T.[TruckID]
		LEFT JOIN GNR.vwParty AS DrvP
			ON CDI.[DriverPartyRef] = DrvP.[PartyId]

