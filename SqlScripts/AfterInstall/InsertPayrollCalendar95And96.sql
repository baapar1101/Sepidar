/*****************************************************/
/***** CREATE DailyHourMinute FOR 1395 Untill 1404 ******/
/*****************************************************/
DECLARE @1395Year INT = 1395, @1396Year INT = 1396, @Year INT = -1 , @1397Year INT = 1397, @1398Year INT = 1398, @1399Year INT = 1399 , @1400Year INT = 1400
, @1401Year INT = 1401 , @1402Year INT = 1402 , @1403Year INT = 1403, @1404Year INT = 1404
DECLARE @PayrollConfigurationRef INT = (SELECT PayrollConfigurationId FROM PAY.PayrollConfiguration)
DECLARE @DailyHourMinute INT = 440

IF NOT EXISTS (SELECT 1 FROM PAY.DailyHourMinute WHERE [YEAR] = @1395Year)
BEGIN 
	SELECT TOP 1 @DailyHourMinute = ISNULL(DailyHourMinute, 440), @Year = ISNULL([Year], -1)
	FROM PAY.DailyHourMinute D
	WHERE D.[Year] < @1395Year
	ORDER BY [Year] DESC

	DECLARE @MaxDailyHourMinuteID INT = (SELECT (ISNULL(MAX(DailyHourMinuteId), 0) + 1) FROM PAY.DailyHourMinute) 
	INSERT INTO PAY.DailyHourMinute(DailyHourMinuteId, PayrollConfigurationRef, [Year], DailyHourMinute)
	SELECT @MaxDailyHourMinuteID , @PayrollConfigurationRef, @1395Year, @DailyHourMinute
END

/** Insert 1396 DailyHourMinute ****/
IF NOT EXISTS (SELECT 1 FROM PAY.DailyHourMinute WHERE [YEAR] = @1396Year)
BEGIN
	SET @MaxDailyHourMinuteID = (SELECT (ISNULL(MAX(DailyHourMinuteId), 0) + 1) FROM PAY.DailyHourMinute)
	SET @DailyHourMinute = (SELECT DailyHourMinute FROM PAY.DailyHourMinute WHERE Year = @1395Year)
	INSERT INTO PAY.DailyHourMinute(DailyHourMinuteId, PayrollConfigurationRef, [Year], DailyHourMinute)
	SELECT @MaxDailyHourMinuteID , @PayrollConfigurationRef, @1396Year, @DailyHourMinute	
END

/** Insert 1397 DailyHourMinute ****/
IF NOT EXISTS (SELECT 1 FROM PAY.DailyHourMinute WHERE [YEAR] = @1397Year)
BEGIN
	SET @MaxDailyHourMinuteID = (SELECT (ISNULL(MAX(DailyHourMinuteId), 0) + 1) FROM PAY.DailyHourMinute)
	SET @DailyHourMinute = (SELECT DailyHourMinute FROM PAY.DailyHourMinute WHERE Year = @1396Year)
	INSERT INTO PAY.DailyHourMinute(DailyHourMinuteId, PayrollConfigurationRef, [Year], DailyHourMinute)
	SELECT @MaxDailyHourMinuteID , @PayrollConfigurationRef, @1397Year, @DailyHourMinute	
END

/** Insert 1398 DailyHourMinute ****/
IF NOT EXISTS (SELECT 1 FROM PAY.DailyHourMinute WHERE [YEAR] = @1398Year)
BEGIN
	SET @MaxDailyHourMinuteID = (SELECT (ISNULL(MAX(DailyHourMinuteId), 0) + 1) FROM PAY.DailyHourMinute)
	SET @DailyHourMinute = (SELECT DailyHourMinute FROM PAY.DailyHourMinute WHERE Year = @1397Year)
	INSERT INTO PAY.DailyHourMinute(DailyHourMinuteId, PayrollConfigurationRef, [Year], DailyHourMinute)
	SELECT @MaxDailyHourMinuteID , @PayrollConfigurationRef, @1398Year, @DailyHourMinute	
END

/** Insert 1399 DailyHourMinute ****/
IF NOT EXISTS (SELECT 1 FROM PAY.DailyHourMinute WHERE [YEAR] = @1399Year)
BEGIN
	SET @MaxDailyHourMinuteID = (SELECT (ISNULL(MAX(DailyHourMinuteId), 0) + 1) FROM PAY.DailyHourMinute)
	SET @DailyHourMinute = (SELECT DailyHourMinute FROM PAY.DailyHourMinute WHERE Year = @1398Year)
	INSERT INTO PAY.DailyHourMinute(DailyHourMinuteId, PayrollConfigurationRef, [Year], DailyHourMinute)
	SELECT @MaxDailyHourMinuteID , @PayrollConfigurationRef, @1399Year, @DailyHourMinute	
END

/** Insert 1400 DailyHourMinute ****/
IF NOT EXISTS (SELECT 1 FROM PAY.DailyHourMinute WHERE [YEAR] = @1400Year)
BEGIN
	SET @MaxDailyHourMinuteID = (SELECT (ISNULL(MAX(DailyHourMinuteId), 0) + 1) FROM PAY.DailyHourMinute)
	SET @DailyHourMinute = (SELECT DailyHourMinute FROM PAY.DailyHourMinute WHERE Year = @1399Year)
	INSERT INTO PAY.DailyHourMinute(DailyHourMinuteId, PayrollConfigurationRef, [Year], DailyHourMinute)
	SELECT @MaxDailyHourMinuteID , @PayrollConfigurationRef, @1400Year, @DailyHourMinute	
END

/** Insert 1401 DailyHourMinute ****/
IF NOT EXISTS (SELECT 1 FROM PAY.DailyHourMinute WHERE [YEAR] = @1401Year)
BEGIN
	SET @MaxDailyHourMinuteID = (SELECT (ISNULL(MAX(DailyHourMinuteId), 0) + 1) FROM PAY.DailyHourMinute)
	SET @DailyHourMinute = (SELECT DailyHourMinute FROM PAY.DailyHourMinute WHERE Year = @1400Year)
	INSERT INTO PAY.DailyHourMinute(DailyHourMinuteId, PayrollConfigurationRef, [Year], DailyHourMinute)
	SELECT @MaxDailyHourMinuteID , @PayrollConfigurationRef, @1401Year, @DailyHourMinute	
END

/** Insert 1402 DailyHourMinute ****/
IF NOT EXISTS (SELECT 1 FROM PAY.DailyHourMinute WHERE [YEAR] = @1402Year)
BEGIN
	SET @MaxDailyHourMinuteID = (SELECT (ISNULL(MAX(DailyHourMinuteId), 0) + 1) FROM PAY.DailyHourMinute)
	SET @DailyHourMinute = (SELECT DailyHourMinute FROM PAY.DailyHourMinute WHERE Year = @1401Year)
	INSERT INTO PAY.DailyHourMinute(DailyHourMinuteId, PayrollConfigurationRef, [Year], DailyHourMinute)
	SELECT @MaxDailyHourMinuteID , @PayrollConfigurationRef, @1402Year, @DailyHourMinute	
END

/** Insert 1403 DailyHourMinute ****/
IF NOT EXISTS (SELECT 1 FROM PAY.DailyHourMinute WHERE [YEAR] = @1403Year)
BEGIN
	SET @MaxDailyHourMinuteID = (SELECT (ISNULL(MAX(DailyHourMinuteId), 0) + 1) FROM PAY.DailyHourMinute)
	SET @DailyHourMinute = (SELECT DailyHourMinute FROM PAY.DailyHourMinute WHERE Year = @1402Year)
	INSERT INTO PAY.DailyHourMinute(DailyHourMinuteId, PayrollConfigurationRef, [Year], DailyHourMinute)
	SELECT @MaxDailyHourMinuteID , @PayrollConfigurationRef, @1403Year, @DailyHourMinute	
END

/** Insert 1404 DailyHourMinute ****/
IF NOT EXISTS (SELECT 1 FROM PAY.DailyHourMinute WHERE [YEAR] = @1404Year)
BEGIN
	SET @MaxDailyHourMinuteID = (SELECT (ISNULL(MAX(DailyHourMinuteId), 0) + 1) FROM PAY.DailyHourMinute)
	SET @DailyHourMinute = (SELECT DailyHourMinute FROM PAY.DailyHourMinute WHERE Year = @1403Year)
	INSERT INTO PAY.DailyHourMinute(DailyHourMinuteId, PayrollConfigurationRef, [Year], DailyHourMinute)
	SELECT @MaxDailyHourMinuteID , @PayrollConfigurationRef, @1404Year, @DailyHourMinute	
END

/** Update Max DailyHourMinuteID ****/
IF (@MaxDailyHourMinuteID > 0)
BEGIN
	EXEC FMK.[spSetLastId] 'PAY.DailyHourMinute', @MaxDailyHourMinuteID
END

/*****************************************************/
/***** CREATE PayrollCalendar For 1395 And 1396 ******/
/*****************************************************/
IF NOT EXISTS (SELECT 1 FROM PAY.PayrollCalendar WHERE [YEAR] = @1395Year)
BEGIN
	DECLARE @MaxPayrollCalendarID INT = (SELECT (ISNULL(MAX(PayrollCalendarId), 0) + 1) FROM PAY.PayrollCalendar) 
	IF @Year != -1
	BEGIN
	
		INSERT INTO PAY.PayrollCalendar(PayrollCalendarId,
			[Year],
			[Month],
			[Day],
			HourMinute,
			PayrollConfigurationRef)
		SELECT ROW_NUMBER() Over(ORDER BY [Month] ASC) + @MaxPayrollCalendarID,
			@1395Year,
			PC.[Month],
			PC.[Day],
			PC.HourMinute,
			PC.PayrollConfigurationRef
		FROM PAY.PayrollCalendar PC
		WHERE [YEAR] = @Year
		ORDER BY [Month]
	END
	ELSE
	BEGIN
		INSERT INTO PAY.PayrollCalendar(PayrollCalendarId, [Year], [Month], [Day], HourMinute, PayrollConfigurationRef) VALUES
			(1,  @1395Year, 1,  31, 440, @PayrollConfigurationRef),
			(2,  @1395Year, 2,  31, 440, @PayrollConfigurationRef),
			(3,  @1395Year, 3,  31, 440, @PayrollConfigurationRef),
			(4,  @1395Year, 4,  31, 440, @PayrollConfigurationRef),
			(5,  @1395Year, 5,  31, 440, @PayrollConfigurationRef),
			(6,  @1395Year, 6,  31, 440, @PayrollConfigurationRef),
			(7,  @1395Year, 7,  30, 440, @PayrollConfigurationRef),
			(8,  @1395Year, 8,  30, 440, @PayrollConfigurationRef),
			(9,  @1395Year, 9,  30, 440, @PayrollConfigurationRef),
			(10, @1395Year, 10, 30, 440, @PayrollConfigurationRef),
			(11, @1395Year, 11, 30, 440, @PayrollConfigurationRef),
			(12, @1395Year, 12, 30, 440, @PayrollConfigurationRef)
	END
END

/*** Update Month 12 For Inserted Row Or Existed Row For 1395 ***/
UPDATE PAY.PayrollCalendar
SET [Day] = 30
WHERE [YEAR] = @1395Year AND [Month] = 12


/*** Insert 1396 PayrollCalendar *******************************/
IF NOT EXISTS (SELECT 1 FROM PAY.PayrollCalendar WHERE [YEAR] = @1396Year) AND
	EXISTS (SELECT 1 FROM PAY.DailyHourMinute WHERE [YEAR] = @1396Year)
BEGIN
	SET @MaxPayrollCalendarID = (SELECT (MAX(PayrollCalendarId) + 1) FROM PAY.PayrollCalendar) 
	INSERT INTO PAY.PayrollCalendar(PayrollCalendarId,
		[Year],
		[Month],
		[Day],
		HourMinute,
		PayrollConfigurationRef)
	SELECT ROW_NUMBER() Over(ORDER BY [Month] ASC) + @MaxPayrollCalendarID,
		@1396Year,
		PC.[Month],
		PC.[Day],
		PC.HourMinute,
		PC.PayrollConfigurationRef
	FROM PAY.PayrollCalendar PC
	WHERE [YEAR] = @1395Year
	ORDER BY [Month]
END

/*** Update Month 12 For Inserted Row Or Existed Row For 1396 ***/
UPDATE PAY.PayrollCalendar
SET [Day] = 29
WHERE [YEAR] = @1396Year AND [Month] = 12	


/*** Insert 1397 PayrollCalendar *******************************/
IF NOT EXISTS (SELECT 1 FROM PAY.PayrollCalendar WHERE [YEAR] = @1397Year) AND
	EXISTS (SELECT 1 FROM PAY.DailyHourMinute WHERE [YEAR] = @1397Year)
BEGIN
	SET @MaxPayrollCalendarID = (SELECT (MAX(PayrollCalendarId) + 1) FROM PAY.PayrollCalendar) 
	INSERT INTO PAY.PayrollCalendar(PayrollCalendarId,
		[Year],
		[Month],
		[Day],
		HourMinute,
		PayrollConfigurationRef)
	SELECT ROW_NUMBER() Over(ORDER BY [Month] ASC) + @MaxPayrollCalendarID,
		@1397Year,
		PC.[Month],
		PC.[Day],
		PC.HourMinute,
		PC.PayrollConfigurationRef
	FROM PAY.PayrollCalendar PC
	WHERE [YEAR] = @1396Year
	ORDER BY [Month]
END

/*** Update Month 12 For Inserted Row Or Existed Row For 1397 ***/
UPDATE PAY.PayrollCalendar
SET [Day] = 29
WHERE [YEAR] = @1397Year AND [Month] = 12	


/*** Insert 1398 PayrollCalendar *******************************/
IF NOT EXISTS (SELECT 1 FROM PAY.PayrollCalendar WHERE [YEAR] = @1398Year) AND
	EXISTS (SELECT 1 FROM PAY.DailyHourMinute WHERE [YEAR] = @1398Year)
BEGIN
	SET @MaxPayrollCalendarID = (SELECT (MAX(PayrollCalendarId) + 1) FROM PAY.PayrollCalendar) 
	INSERT INTO PAY.PayrollCalendar(PayrollCalendarId,
		[Year],
		[Month],
		[Day],
		HourMinute,
		PayrollConfigurationRef)
	SELECT ROW_NUMBER() Over(ORDER BY [Month] ASC) + @MaxPayrollCalendarID,
		@1398Year,
		PC.[Month],
		PC.[Day],
		PC.HourMinute,
		PC.PayrollConfigurationRef
	FROM PAY.PayrollCalendar PC
	WHERE [YEAR] = @1397Year
	ORDER BY [Month]
END

/*** Update Month 12 For Inserted Row Or Existed Row For 1398 ***/
UPDATE PAY.PayrollCalendar
SET [Day] = 29
WHERE [YEAR] = @1398Year AND [Month] = 12	

/*** Insert 1399 PayrollCalendar *******************************/
IF NOT EXISTS (SELECT 1 FROM PAY.PayrollCalendar WHERE [YEAR] = @1399Year) AND
	EXISTS (SELECT 1 FROM PAY.DailyHourMinute WHERE [YEAR] = @1399Year)
BEGIN
	SET @MaxPayrollCalendarID = (SELECT (MAX(PayrollCalendarId) + 1) FROM PAY.PayrollCalendar) 
	INSERT INTO PAY.PayrollCalendar(PayrollCalendarId,
		[Year],
		[Month],
		[Day],
		HourMinute,
		PayrollConfigurationRef)
	SELECT ROW_NUMBER() Over(ORDER BY [Month] ASC) + @MaxPayrollCalendarID,
		@1399Year,
		PC.[Month],
		PC.[Day],
		PC.HourMinute,
		PC.PayrollConfigurationRef
	FROM PAY.PayrollCalendar PC
	WHERE [YEAR] = @1398Year
	ORDER BY [Month]
END

/*** Update Month 12 For Inserted Row Or Existed Row For 1399 ***/
UPDATE PAY.PayrollCalendar
SET [Day] = 30
WHERE [YEAR] = @1399Year AND [Month] = 12	

/*** Insert 1400 PayrollCalendar *******************************/
IF NOT EXISTS (SELECT 1 FROM PAY.PayrollCalendar WHERE [YEAR] = @1400Year) AND
	EXISTS (SELECT 1 FROM PAY.DailyHourMinute WHERE [YEAR] = @1400Year)
BEGIN
	SET @MaxPayrollCalendarID = (SELECT (MAX(PayrollCalendarId) + 1) FROM PAY.PayrollCalendar) 
	INSERT INTO PAY.PayrollCalendar(PayrollCalendarId,
		[Year],
		[Month],
		[Day],
		HourMinute,
		PayrollConfigurationRef)
	SELECT ROW_NUMBER() Over(ORDER BY [Month] ASC) + @MaxPayrollCalendarID,
		@1400Year,
		PC.[Month],
		PC.[Day],
		PC.HourMinute,
		PC.PayrollConfigurationRef
	FROM PAY.PayrollCalendar PC
	WHERE [YEAR] = @1399Year
	ORDER BY [Month]
END

/*** Update Month 12 For Inserted Row Or Existed Row For 1398 ***/
UPDATE PAY.PayrollCalendar
SET [Day] = 29
WHERE [YEAR] = @1400Year AND [Month] = 12	


/*** Insert 1401 PayrollCalendar *******************************/
IF NOT EXISTS (SELECT 1 FROM PAY.PayrollCalendar WHERE [YEAR] = @1401Year) AND
	EXISTS (SELECT 1 FROM PAY.DailyHourMinute WHERE [YEAR] = @1401Year)
BEGIN
	SET @MaxPayrollCalendarID = (SELECT (MAX(PayrollCalendarId) + 1) FROM PAY.PayrollCalendar) 
	INSERT INTO PAY.PayrollCalendar(PayrollCalendarId,
		[Year],
		[Month],
		[Day],
		HourMinute,
		PayrollConfigurationRef)
	SELECT ROW_NUMBER() Over(ORDER BY [Month] ASC) + @MaxPayrollCalendarID,
		@1401Year,
		PC.[Month],
		PC.[Day],
		PC.HourMinute,
		PC.PayrollConfigurationRef
	FROM PAY.PayrollCalendar PC
	WHERE [YEAR] = @1400Year
	ORDER BY [Month]
END

/*** Update Month 12 For Inserted Row Or Existed Row For 1398 ***/
UPDATE PAY.PayrollCalendar
SET [Day] = 29
WHERE [YEAR] = @1401Year AND [Month] = 12

/*** Insert 1402 PayrollCalendar *******************************/
IF NOT EXISTS (SELECT 1 FROM PAY.PayrollCalendar WHERE [YEAR] = @1402Year) AND
	EXISTS (SELECT 1 FROM PAY.DailyHourMinute WHERE [YEAR] = @1402Year)
BEGIN
	SET @MaxPayrollCalendarID = (SELECT (MAX(PayrollCalendarId) + 1) FROM PAY.PayrollCalendar) 
	INSERT INTO PAY.PayrollCalendar(PayrollCalendarId,
		[Year],
		[Month],
		[Day],
		HourMinute,
		PayrollConfigurationRef)
	SELECT ROW_NUMBER() Over(ORDER BY [Month] ASC) + @MaxPayrollCalendarID,
		@1402Year,
		PC.[Month],
		PC.[Day],
		PC.HourMinute,
		PC.PayrollConfigurationRef
	FROM PAY.PayrollCalendar PC
	WHERE [YEAR] = @1401Year
	ORDER BY [Month]
END

/*** Update Month 12 For Inserted Row Or Existed Row For 1398 ***/
UPDATE PAY.PayrollCalendar
SET [Day] = 29
WHERE [YEAR] = @1402Year AND [Month] = 12	

/*** Insert 1403 PayrollCalendar *******************************/
IF NOT EXISTS (SELECT 1 FROM PAY.PayrollCalendar WHERE [YEAR] = @1403Year) AND
	EXISTS (SELECT 1 FROM PAY.DailyHourMinute WHERE [YEAR] = @1403Year)
BEGIN
	SET @MaxPayrollCalendarID = (SELECT (MAX(PayrollCalendarId) + 1) FROM PAY.PayrollCalendar) 
	INSERT INTO PAY.PayrollCalendar(PayrollCalendarId,
		[Year],
		[Month],
		[Day],
		HourMinute,
		PayrollConfigurationRef)
	SELECT ROW_NUMBER() Over(ORDER BY [Month] ASC) + @MaxPayrollCalendarID,
		@1403Year,
		PC.[Month],
		PC.[Day],
		PC.HourMinute,
		PC.PayrollConfigurationRef
	FROM PAY.PayrollCalendar PC
	WHERE [YEAR] = @1402Year
	ORDER BY [Month]
END

/*** Update Month 12 For Inserted Row Or Existed Row For 1398 ***/
UPDATE PAY.PayrollCalendar
SET [Day] = 30
WHERE [YEAR] = @1403Year AND [Month] = 12	

/*** Insert 1404 PayrollCalendar *******************************/
IF NOT EXISTS (SELECT 1 FROM PAY.PayrollCalendar WHERE [YEAR] = @1404Year) AND
	EXISTS (SELECT 1 FROM PAY.DailyHourMinute WHERE [YEAR] = @1404Year)
BEGIN
	SET @MaxPayrollCalendarID = (SELECT (MAX(PayrollCalendarId) + 1) FROM PAY.PayrollCalendar) 
	INSERT INTO PAY.PayrollCalendar(PayrollCalendarId,
		[Year],
		[Month],
		[Day],
		HourMinute,
		PayrollConfigurationRef)
	SELECT ROW_NUMBER() Over(ORDER BY [Month] ASC) + @MaxPayrollCalendarID,
		@1404Year,
		PC.[Month],
		PC.[Day],
		PC.HourMinute,
		PC.PayrollConfigurationRef
	FROM PAY.PayrollCalendar PC
	WHERE [YEAR] = @1403Year
	ORDER BY [Month]
END

/*** Update Month 12 For Inserted Row Or Existed Row For 1404 ***/
UPDATE PAY.PayrollCalendar
SET [Day] = 29
WHERE [YEAR] = @1404Year AND [Month] = 12

/*** Update Max PayrollCalendarID *******************************/
DECLARE @NewMaxPayrollCalendarID INT = (SELECT ISNULL(MAX(PayrollCalendarId), 0) FROM PAY.PayrollCalendar)
IF (@NewMaxPayrollCalendarID > 0)
BEGIN
	EXEC FMK.[spSetLastId] 'PAY.PayrollCalendar', @NewMaxPayrollCalendarID
END
