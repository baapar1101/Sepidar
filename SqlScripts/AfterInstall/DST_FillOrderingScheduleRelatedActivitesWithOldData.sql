IF NOT EXISTS (SELECT
			1
		FROM [DST].[OrderingScheduleRelatedActivities] AS [OSRA])
BEGIN
	BEGIN TRANSACTION

	-- Insert Orders
	DECLARE @RecordCount INT = 0
	DECLARE @ItemId INT

	DECLARE @Step INT = 0
	DECLARE @ID INT = 0

	SELECT
		@RecordCount = COUNT(1)
	FROM [DST].[Order] AS [O]
	JOIN [DST].[OrderingSchedule] AS [OS]
		ON ([O].[Date] = [OS].[Date]
				AND [O].[BrokerPartyRef] = [OS].[PartyRef])
	JOIN [DST].[PathPartyAddress] AS [PPA]
		ON ([O].[CustomerPartyAddressRef] = [PPA].[PartyAddressRef]
				AND [OS].[AreaAndPathRef] = [PPA].[AreaAndPathRef])

	EXEC [FMK].[spGetNextId] @tablename = 'DST.OrderingScheduleRelatedActivities'
							,@id = @ItemId OUTPUT
							,@incvalue = @RecordCount

	SET @Step = @ItemId - @RecordCount
	SELECT
		@ID = @Step

	INSERT INTO [DST].[OrderingScheduleRelatedActivities] ([OrderingScheduleRelatedActivitiesId],
	[ScheduleId],
	[OrderRef],
	[OrderingFailureItemRef],
	[Version])
		SELECT
			ROW_NUMBER() OVER (ORDER BY [O].[OrderID]) + @ID
		   ,CAST(CONVERT(VARCHAR, [OS].[Date], 112) + CAST([OS].[PartyRef] AS VARCHAR) AS BIGINT)
		   ,[O].[OrderID]
		   ,NULL
		   ,1
		FROM [DST].[Order] AS [O]
		JOIN [DST].[OrderingSchedule] AS [OS]
			ON ([O].[Date] = [OS].[Date]
					AND [O].[BrokerPartyRef] = [OS].[PartyRef])
		JOIN [DST].[PathPartyAddress] AS [PPA]
			ON ([O].[CustomerPartyAddressRef] = [PPA].[PartyAddressRef]
					AND [OS].[AreaAndPathRef] = [PPA].[AreaAndPathRef])

	-- Insert Ordering Failure Items
	SELECT
		@RecordCount = 0
	   ,@ItemId = 0
	   ,@Step = 0
	   ,@ID = 0

	SELECT
		@RecordCount = COUNT(1)
	FROM [DST].[OrderingFailureItem] AS [OFI]
	JOIN [DST].[OrderingFailure] AS [OF]
		ON [OFI].[OrderingFailureRef] = [OF].[OrderingFailureId]
	JOIN [DST].[OrderingSchedule] AS [OS]
		ON ([OF].[Date] = [OS].[Date]
				AND [OF].[PartyRef] = [OS].[PartyRef])
	JOIN [DST].[PathPartyAddress] AS [PPA]
		ON ([OS].[AreaAndPathRef] = [PPA].[AreaAndPathRef]
				AND [OFI].[PartyAddressRef] = [PPA].[PartyAddressRef])

	EXEC [FMK].[spGetNextId] @tablename = 'DST.OrderingScheduleRelatedActivities'
							,@id = @ItemId OUTPUT
							,@incvalue = @RecordCount

	SET @Step = @ItemId - @RecordCount
	SELECT
		@ID = @Step

	INSERT INTO [DST].[OrderingScheduleRelatedActivities] ([OrderingScheduleRelatedActivitiesId],
	[ScheduleId],
	[OrderRef],
	[OrderingFailureItemRef],
	[Version])
		SELECT
			ROW_NUMBER() OVER (ORDER BY [OFI].[OrderingFailureItemId]) + @ID
		   ,CAST(CONVERT(VARCHAR, [OS].[Date], 112) + CAST([OS].[PartyRef] AS VARCHAR) AS BIGINT)
		   ,NULL
		   ,[OFI].[OrderingFailureItemId]
		   ,1
		FROM [DST].[OrderingFailureItem] AS [OFI]
		JOIN [DST].[OrderingFailure] AS [OF]
			ON [OFI].[OrderingFailureRef] = [OF].[OrderingFailureId]
		JOIN [DST].[OrderingSchedule] AS [OS]
			ON ([OF].[Date] = [OS].[Date]
					AND [OF].[PartyRef] = [OS].[PartyRef])
		JOIN [DST].[PathPartyAddress] AS [PPA]
			ON ([OS].[AreaAndPathRef] = [PPA].[AreaAndPathRef]
					AND [OFI].[PartyAddressRef] = [PPA].[PartyAddressRef])

	COMMIT
END