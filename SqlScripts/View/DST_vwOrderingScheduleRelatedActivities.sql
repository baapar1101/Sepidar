IF OBJECT_ID('DST.vwOrderingScheduleRelatedActivities') IS NOT NULL
	DROP VIEW DST.vwOrderingScheduleRelatedActivities
GO

CREATE VIEW DST.vwOrderingScheduleRelatedActivities
AS

SELECT
	[OSRA].[OrderingScheduleRelatedActivitiesId]
   ,[OSRA].[ScheduleId]
   ,CAST(SUBSTRING(CAST([OSRA].[ScheduleId] AS VARCHAR), 1, 8) AS DATETIME) AS Date
   ,CAST(SUBSTRING(CAST([OSRA].[ScheduleId] AS VARCHAR), 9, LEN(CAST([OSRA].[ScheduleId] AS VARCHAR))) AS INT) AS PartyRef
   ,[OSRA].[OrderRef]
   ,[OSRA].[OrderingFailureItemRef]
   ,[OSRA].[CustomerPartyAddressRef]
   ,[OSRA].[Version]
FROM (SELECT
		[OSRA].[OrderingScheduleRelatedActivitiesId]
	   ,[OSRA].[ScheduleId]
	   ,[OSRA].[OrderRef]
	   ,[OSRA].[OrderingFailureItemRef]
	   ,[O].[CustomerPartyAddressRef]
	   ,[OSRA].[Version]
	FROM [DST].[OrderingScheduleRelatedActivities] AS [OSRA]
	LEFT JOIN [DST].[Order] AS [O]
		ON [OSRA].[OrderRef] = [O].[OrderID]
	WHERE [OSRA].[OrderRef] IS NOT NULL

	UNION

	SELECT
		[OSRA].[OrderingScheduleRelatedActivitiesId]
	   ,[OSRA].[ScheduleId]
	   ,[OSRA].[OrderRef]
	   ,[OSRA].[OrderingFailureItemRef]
	   ,[OFI].[PartyAddressRef]
	   ,[OSRA].[Version]
	FROM [DST].[OrderingScheduleRelatedActivities] AS [OSRA]
	LEFT JOIN [DST].[OrderingFailureItem] AS [OFI]
		ON [OSRA].[OrderingFailureItemRef] = [OFI].[OrderingFailureItemId]
	WHERE [OSRA].[OrderingFailureItemRef] IS NOT NULL) AS [OSRA]