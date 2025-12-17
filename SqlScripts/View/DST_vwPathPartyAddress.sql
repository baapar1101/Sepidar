--<<FileName:DST_vwPathPartyAddress.sql>>--

IF Object_ID('DST.vwPathPartyAddress') IS NOT NULL
	DROP VIEW DST.vwPathPartyAddress
GO

CREATE VIEW DST.vwPathPartyAddress
AS

SELECT 
	PathAdr.[PathPartyAddressId]
	, PathAdr.[RowOrder]
	, PathAdr.[AreaAndPathRef]
	, AAP.[AreaCode]
	, AAP.[AreaTitle]
	, AAP.[AreaTitle_En]
	, AAP.[FullCode]			AS PathCode
	, AAP.[Title]				AS PathTitle
	, AAP.[Title_En]			AS PathTitle_En
	, PathAdr.[PartyAddressRef]
	, PartyAdr.[Address]
	, PartyAdr.[Adress_En]
	, L.[State]
	, L.[State_En]
	, L.[City]
	, L.[City_En]
	, PartyAdr.[PartyRef]
	, P.[DLCode]				AS PartyDLCode
	, P.[DLTitle]				AS PartyDLTitle
	, P.[DLTitle_En]			AS PartyDLTitle_En
	, P.[IsActive]				AS PartyIsActive
	, P.[IsCustomer]			AS PartyIsCustomer
	, P.[Phone]					AS PartyPhone
	, PathAdr.[Version]
	, PathAdr.[Creator]
	, PathAdr.[CreationDate]
	, PathAdr.[LastModifier]
	, PathAdr.[LastModificationDate]
	, p.CustomerGroupingCode
	, p.CustomerGroupingTitle
FROM 
	DST.PathPartyAddress PathAdr
		JOIN GNR.vwPartyAddress PartyAdr 
			ON PathAdr.[PartyAddressRef] = PartyAdr.[PartyAddressId]
		JOIN GNR.vwParty P 
			ON PartyAdr.[PartyRef] = P.[PartyId]
		LEFT JOIN GNR.vwLocationList L 
			ON PartyAdr.[LocationRef] = L.[LocationId]
		JOIN DST.[vwAreaAndPath] AAP
			ON PathAdr.[AreaAndPathRef] = AAP.[AreaAndPathId]

