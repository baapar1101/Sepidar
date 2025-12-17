IF EXISTS (SELECT
			1
		FROM [PAY].[PiofyMonthlyCalculation] AS [PMC]
		WHERE LEN([PMC].[YMCode]) = 4)
BEGIN
	UPDATE [PAY].[PiofyMonthlyCalculation]
	SET [YMCode] = ((CASE
		WHEN ([YMCode] / 100) >= 50 THEN 13
		ELSE 14
	END) * 10000) + [YMCode]
	WHERE LEN([YMCode]) = 4;
END
GO