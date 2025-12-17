IF Object_ID('DST.vwOrderingScheduleRecurrence') IS NOT NULL
	DROP VIEW DST.vwOrderingScheduleRecurrence
GO

CREATE VIEW DST.vwOrderingScheduleRecurrence
AS

SELECT 
	R.[OrderingScheduleRecurrenceId]
	, R.[StartDate]
	, R.[EndDate]
	, OS.[PartyRef]
	, P.[DLCode]			AS PartyDLCode
	, P.[DLTitle]			AS PartyDLTitle
	, OS.[AreaAndPathRef]
	, A.[FullCode]			AS PathCode
	, A.[Title]				AS PathTitle
	, R.[Type]
	, R.[DayInterval]
	, R.[WeekInterval]
	, R.[Weekdays]
	, CAST(CASE WHEN (R.[Weekdays] &  1) =  1 THEN 1 ELSE 0 END AS BIT) AS Saturday
	, CAST(CASE WHEN (R.[Weekdays] &  2) =  2 THEN 1 ELSE 0 END AS BIT) AS Sunday
	, CAST(CASE WHEN (R.[Weekdays] &  4) =  4 THEN 1 ELSE 0 END AS BIT) AS Monday
	, CAST(CASE WHEN (R.[Weekdays] &  8) =  8 THEN 1 ELSE 0 END AS BIT) AS Tuesday
	, CAST(CASE WHEN (R.[Weekdays] & 16) = 16 THEN 1 ELSE 0 END AS BIT) AS Wednesday
	, CAST(CASE WHEN (R.[Weekdays] & 32) = 32 THEN 1 ELSE 0 END AS BIT) AS Thursday
	, CAST(CASE WHEN (R.[Weekdays] & 64) = 64 THEN 1 ELSE 0 END AS BIT) AS Friday
	, R.[Version]
	, R.[Creator]
	, R.[CreationDate]
	, R.[LastModifier]
	, R.[LastModificationDate]
FROM 
	DST.OrderingScheduleRecurrence AS R
		JOIN (SELECT O.[OrderingScheduleRecurrenceRef]
				, O.[PartyRef]
				, O.[AreaAndPathRef] 
				FROM DST.OrderingSchedule AS O 
				GROUP BY O.[OrderingScheduleRecurrenceRef], O.[PartyRef], O.[AreaAndPathRef]) AS OS
			ON R.[OrderingScheduleRecurrenceId] = OS.[OrderingScheduleRecurrenceRef]
		JOIN DST.vwAreaAndPath AS A
			ON OS.[AreaAndPathRef] = A.[AreaAndPathId]
		JOIN GNR.vwParty AS P
			ON OS.[PartyRef] = P.[PartyId]

