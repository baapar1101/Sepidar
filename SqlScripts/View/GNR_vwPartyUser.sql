-- ToDo: Remove this file before relese
If Object_ID('GNR.vwPartyUser') Is Not Null
	DROP View GNR.vwPartyUser
GO
--CREATE VIEW GNR.vwPartyUser
--AS
--SELECT
--	PU.[PartyUserId]
--	, PU.[PartyRef]
--	, P.[DLCode]		PartyDLCode
--	, P.[DLTitle]		PartyDLTitle
--	, P.[DLTitle_En]	PartyDLTitle_En
--	, P.[DLType]		PartyDLType
--	, P.[FullName]		PartyFullName
--	, PU.[UserRef]
--	, U.[Name]			UserName
--	, U.[Name_En]		UserName_En
--	, U.[Status]		UserStatus
--	, U.[UserName]		UserUserName
--	, PU.[Version]
--FROM
--	GNR.PartyUser AS PU
--	INNER JOIN GNR.vwParty AS P ON PU.PartyRef = P.PartyId
--	INNER JOIN FMK.vwUser AS U ON PU.UserRef = U.UserID
