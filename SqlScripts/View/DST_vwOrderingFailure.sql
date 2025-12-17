IF Object_ID('DST.vwOrderingFailure') IS NOT NULL
	DROP VIEW DST.vwOrderingFailure
GO

CREATE VIEW DST.vwOrderingFailure
AS

SELECT 
	F.[OrderingFailureId]
	, F.[Date]
	, F.[PartyRef]
	, P.[DLCode]		AS PartyDLCode
	, P.[DLTitle]		AS PartyDLTitle
	, P.[DLTitle_En]	AS PartyDLTitle_En
	, F.[FiscalYearRef]
	, F.[Version]
	, F.[Creator]
	, F.[CreationDate]
	, F.[LastModifier]
	, F.[LastModificationDate]
	, CU.Name CreatorName
    , MU.Name LastModifierName
FROM 
	DST.[OrderingFailure] F
    JOIN GNR.[vwParty] P
	ON F.[PartyRef] = P.[PartyId]
	INNER JOIN FMk.[User] CU ON F.Creator = CU.UserID
	LEFT JOIN FMk.[User] MU ON F.LastModifier = MU.UserID