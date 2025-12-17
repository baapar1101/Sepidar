IF Object_ID('DST.vwOrderingSchedule') IS NOT NULL
	DROP VIEW DST.vwOrderingSchedule
GO

CREATE VIEW DST.vwOrderingSchedule
AS

SELECT 
	PS.[OrderingScheduleId]
	, PS.[OrderingScheduleRecurrenceRef]
	, PS.[Date]
	, PS.[PartyRef]
	, P.[DLCode]			AS PartyDLCode
	, P.[DLTitle]			AS PartyDLTitle
    , P.[DLTitle_En]        AS PartyDLTitle_En
	, PS.[AreaAndPathRef]
	, AP.[FullCode]			AS PathCode
	, AP.[Title]			AS PathTitle
    , AP.[Title_En]         AS PathTitle_En
	, PS.[CustomerAddressRef]
	, PartyAdr.[Address]    AS CustomerAddress
	, PartyAdr.[Adress_En]  AS CustomerAdress_En
	, L.[State]             AS CustomerState
	, L.[State_En]          AS CustomerState_En
	, L.[City]              AS CustomerCity
	, L.[City_En]           AS CustomerCity_En
	, PartyAdr.[PartyRef]   AS CustomerRef
	, Customer.[DLCode]		AS CustomerDLCode
	, Customer.[DLTitle]	AS CustomerDLTitle
	, Customer.[DLTitle_En]	AS CustomerDLTitle_En
	, Customer.CustomerGroupingCode
	, Customer.CustomerGroupingTitle
	, Customer.CustomerGroupingTitle_En
	, Customer.IsActive     AS CustomerIsActive
	, CAST(
		CASE 
			WHEN 
				EXISTS 
					(SELECT	1
					FROM [DST].[vwOrderingScheduleRelatedActivities] AS [OSRA]
						LEFT JOIN DST.[PathPartyAddress] PPA ON [OSRA].[CustomerPartyAddressRef] = [PPA].[PartyAddressRef]
					WHERE [OSRA].[Date] = PS.[Date] AND [OSRA].[PartyRef] = PS.[PartyRef] 
						AND ([PPA].[AreaAndPathRef] = PS.[AreaAndPathRef] OR [OSRA].[CustomerPartyAddressRef] = PS.CustomerAddressRef))
			THEN 
				1 
			ELSE 
				0 
			END 
			AS BIT)			AS HasResult
	, PS.[IsLockedByDevice]
	, PS.[FiscalYearRef]
	, PS.[Version]
	, PS.[Creator]
	, PS.[CreationDate]
	, PS.[LastModifier]
	, PS.[LastModificationDate]
FROM 
	DST.OrderingSchedule AS PS
		JOIN GNR.vwParty AS P 
			ON PS.[PartyRef] = P.[PartyId]
		LEFT JOIN DST.vwAreaAndPath AS AP 
			ON PS.[AreaAndPathRef] = AP.[AreaAndPathId]
		LEFT JOIN GNR.vwPartyAddress AS PartyAdr 
			ON PS.[CustomerAddressRef] = PartyAdr.[PartyAddressId]
		LEFT JOIN GNR.vwParty AS Customer 
			ON PartyAdr.[PartyRef] = Customer.[PartyId]
		LEFT JOIN GNR.vwLocationList L 
			ON PartyAdr.[LocationRef] = L.[LocationId]


