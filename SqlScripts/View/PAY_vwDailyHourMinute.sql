IF OBJECT_ID('PAY.vwDailyHourMinute') IS NOT NULL
	DROP VIEW PAY.vwDailyHourMinute
GO

CREATE VIEW PAY.vwDailyHourMinute
AS
SELECT	DHM.[DailyHourMinuteId],DHM.[PayrollConfigurationRef],
		DHM.[Year],DHM.[DailyHourMinute],
	((CASE WHEN DHM.DailyHourMinute < 0 THEN '-' ELSE '' END)) + (RIGHT('000' + CAST(ISNULL(ABS(DailyHourMinute) / 60, 000) AS VARCHAR), 3) 
+ ':' + RIGHT('00' + CAST(ISNULL((ABS(DailyHourMinute) - ABS(DailyHourMinute) / 60 * 60) % 60, '00') AS VARCHAR), 2)) DailyHourMinuteTitle

 
FROM PAY.DailyHourMinute DHM