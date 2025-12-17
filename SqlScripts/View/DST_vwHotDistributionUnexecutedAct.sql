IF Object_ID('DST.vwHotDistributionUnexecutedAct') IS NOT NULL
	DROP VIEW DST.vwHotDistributionUnexecutedAct
GO

CREATE VIEW DST.vwHotDistributionUnexecutedAct
AS

SELECT 
	[HDUA].[HotDistributionUnexecutedActId]
	, [HDUA].[HotDistributionRef]
	, [HDUA].[PartyAddressRef]
	, P.[DLCode]					AS [CustomerDLCode]
	, P.[DLTitle]					AS [CustomerDLTitle]
	, P.[DLTitle_En]				AS [CustomerDLTitle_En]
	, PA.[Address]
	, PA.[Adress_En]
	, [HDUA].[AreaAndPathRef]
	, AAP.[AreaTitle]
	, AAP.[AreaTitle_En]				
	, [AAP].[FullCode]				AS [PathCode]
	, AAP.[Title]					AS [PathTitle]
	, AAP.[Title_En]				AS [PathTitle_En]
	, [HDUA].[UnexecutedActReasonRef]
	, UAR.[Title]					AS [UnexecutedActReasonTitle]
	, UAR.[Title_En]				AS [UnexecutedActReasonTitle_En]
	, [HDUA].[Description]
	, [HDUA].[Description_En]
	, CASE
      	WHEN ISNULL([HDUA].[Guid], '') = '' THEN 0
		ELSE 1
      END AS [IsCreatedByDevice]
	, [HDUA].[Guid]
	, [HDUA].[Creator]
	, [HDUA].[CreationDate]
	, [HDUA].[LastModifier]
	, [HDUA].[LastModificationDate]
FROM 
	DST.[HotDistributionUnexecutedAct] AS [HDUA]
		LEFT JOIN GNR.[vwPartyAddress] PA
			ON [HDUA].[PartyAddressRef] = PA.[PartyAddressId]
		LEFT JOIN GNR.[vwParty] P
			ON PA.[PartyRef] = P.[PartyId]
		JOIN DST.[vwAreaAndPath] AAP
			ON [HDUA].[AreaAndPathRef] = AAP.[AreaAndPathId]
		LEFT JOIN DST.[vwUnexecutedActReason] UAR
			ON [HDUA].[UnexecutedActReasonRef] = UAR.[UnexecutedActReasonId]