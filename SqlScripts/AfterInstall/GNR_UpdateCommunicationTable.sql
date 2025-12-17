IF EXISTS (SELECT
			1
		FROM [GNR].[Communication] AS [C]
		WHERE [C].[RequestHttpMethod] = 'OldData'
		AND [C].[Method] = 'OldData'
		AND [C].[SendingState] IN (1, 2, 4))
BEGIN
	UPDATE [GNR].[Communication]
	SET [SendingState] = 5
	WHERE [RequestHttpMethod] = 'OldData'
	AND [Method] = 'OldData'
	AND [SendingState] IN (1, 2, 4);
END
GO

IF EXISTS (SELECT
			1
		FROM [GNR].[Communication] AS [C]
		WHERE [C].[RequestBody] LIKE '%YMCode%'
		AND SUBSTRING([C].[RequestBody], CHARINDEX('"YMCode"', [C].[RequestBody]) + 9, 2) NOT IN (13, 14)
		AND [C].[SendingState] IN (1, 2, 4))
BEGIN
	UPDATE [GNR].[Communication]
	SET [SendingState] = 5
	WHERE [RequestBody] LIKE '%YMCode%'
	AND SUBSTRING([RequestBody], CHARINDEX('"YMCode"', [RequestBody]) + 9, 2) NOT IN (13, 14)
	AND [SendingState] IN (1, 2, 4);
END
GO