IF Object_ID('DST.vwOrderingFailureItem') IS NOT NULL
	DROP VIEW DST.vwOrderingFailureItem
GO

CREATE VIEW DST.vwOrderingFailureItem
AS

SELECT 
	OFI.[OrderingFailureItemId]
	, OFI.[OrderingFailureRef]
	, OFI.[PartyAddressRef]
	, P.[DLCode]					AS [CustomerDLCode]
	, P.[DLTitle]					AS [CustomerDLTitle]
	, P.[DLTitle_En]				AS [CustomerDLTitle_En]
	, PA.[Address]
	, PA.[Adress_En]
	, OFI.[AreaAndPathRef]
	, AAP.[AreaTitle]
	, AAP.[AreaTitle_En]				
	, AAP.[Title]					AS [PathTitle]
	, AAP.[Title_En]				AS [PathTitle_En]
	, OFI.[UnexecutedActReasonRef]
	, UAR.[Title]					AS [UnexecutedActReasonTitle]
	, UAR.[Title_En]				AS [UnexecutedActReasonTitle_En]
	, OFI.[Description]
	, OFI.[Description_En]
	, CASE
      	WHEN ISNULL([OFI].[Guid], '') = '' THEN 0
		ELSE 1
      END AS [IsCreatedByDevice]
	, OFI.[Guid]
	, OFI.[Creator]
	, OFI.[CreationDate]
	, OFI.[LastModifier]
	, OFI.[LastModificationDate]
FROM 
	DST.[OrderingFailureItem] OFI
		LEFT JOIN GNR.[vwPartyAddress] PA
			ON OFI.[PartyAddressRef] = PA.[PartyAddressId]
		LEFT JOIN GNR.[vwParty] P
			ON PA.[PartyRef] = P.[PartyId]
		LEFT JOIN DST.[vwAreaAndPath] AAP
			ON OFI.[AreaAndPathRef] = AAP.[AreaAndPathId]
		LEFT JOIN DST.[vwUnexecutedActReason] UAR
			ON OFI.[UnexecutedActReasonRef] = UAR.[UnexecutedActReasonId]