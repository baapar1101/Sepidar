-- ///////// CREATE FUNCTION '[FMK].[fnDateDaysOfMonths]' /////////////
IF Object_ID('FMK.fnDateDaysOfMonths') IS NOT NULL
	DROP FUNCTION [FMK].[fnDateDaysOfMonths]
GO

CREATE FUNCTION [FMK].[fnDateDaysOfMonths] (@type SMALLINT, @month SMALLINT) 
	RETURNS SMALLINT AS
BEGIN 

	DECLARE @array_s VARCHAR(38) -- shamsi month days
	DECLARE @array_g VARCHAR(38) -- gregorian month days
	DECLARE @result SMALLINT

	SET @array_s = '00,31,31,31,31,31,31,30,30,30,30,30,29'
	SET @array_g = '00,31,28,31,30,31,30,31,31,30,31,30,31'

	IF ( @type = 0 )
		SET @result = CAST(SUBSTRING(@array_s, @month*2+@month+1, 2) AS SMALLINT)
	ELSE
		SET @result = CAST(SUBSTRING(@array_g, @month*2+@month+1, 2) AS SMALLINT)

	RETURN @result

END
GO

-- ///////// CREATE FUNCTION '[FMK].[fnDateDaysToMonth]' /////////////
IF Object_ID('FMK.fnDateDaysToMonth') IS NOT NULL
	DROP FUNCTION [FMK].[fnDateDaysToMonth]
GO

CREATE FUNCTION [FMK].[fnDateDaysToMonth] (@type SMALLINT, @month SMALLINT) 
RETURNS SMALLINT AS
BEGIN 

	DECLARE @array_s VARCHAR(55) -- shamsi month days
	DECLARE @array_g VARCHAR(55) -- gregorian month days
	DECLARE @result SMALLINT

	SET @array_s = '000,000,031,062,093,124,155,186,216,246,276,306,336,365'
	SET @array_g = '000,000,031,059,090,120,151,181,212,243,273,304,334,365'

	IF ( @type = 0 )
		SET @result = CAST(SUBSTRING(@array_s, @month*3+@month+1, 3) AS SMALLINT)
	ELSE
		SET @result = CAST(SUBSTRING(@array_g, @month*3+@month+1, 3) AS SMALLINT)


RETURN @result

END
GO
-- ///////// CREATE FUNCTION '[FMK].[fnDateLeapMonth]' /////////////
IF Object_ID('FMK.fnDateLeapMonth') IS NOT NULL
	DROP FUNCTION [FMK].[fnDateLeapMonth]
GO

CREATE FUNCTION [FMK].[fnDateLeapMonth] (@type SMALLINT) 
RETURNS SMALLINT AS
BEGIN 

	DECLARE @array VARCHAR(5)
	DECLARE @result SMALLINT

	SET @array = '12,02' -- esfand, february
	SET @result = CAST(SUBSTRING(@array, @type*2+@type+1, 2) AS SMALLINT)

RETURN @result

END
GO
-- ///////// CREATE FUNCTION '[FMK].[fnDateIsLeapYear]' /////////////
IF Object_ID('FMK.fnDateIsLeapYear') IS NOT NULL
	DROP FUNCTION [FMK].[fnDateIsLeapYear]
GO

CREATE FUNCTION [FMK].[fnDateIsLeapYear] (@type SMALLINT, @year SMALLINT) 
RETURNS BIT AS
BEGIN 

	DECLARE @result BIT

	IF ( @type = 0 )
		BEGIN
			IF ( ((((@year + 38) * 31) % 128) <= 30) )
				SET @result = 1
			ELSE
				SET @result = 0
		END
	ELSE
		BEGIN
			IF ( ((@year%4) = 0) and (((@year%100) != 0) or ((@year%400) = 0)) )
				SET @result = 1
			ELSE
				SET @result = 0
		END

RETURN @result

END
GO
-- ///////// CREATE FUNCTION '[FMK].[fnDateDaysOfMonth]' /////////////
IF Object_ID('FMK.fnDateDaysOfMonth') IS NOT NULL
	DROP FUNCTION [FMK].[fnDateDaysOfMonth]
GO

CREATE FUNCTION [FMK].[fnDateDaysOfMonth] (@type SMALLINT, @year SMALLINT, @month SMALLINT) 
RETURNS SMALLINT AS
	BEGIN 
		DECLARE @result SMALLINT
		IF ( (@year != 0) AND (@month >= 1 AND @month <= 12) )
			BEGIN
				SET @result = FMK.fnDateDaysOfMonths(@type, @month)
				IF ( (@month = FMK.fnDateLeapMonth(@type)) AND (FMK.fnDateIsLeapYear(@type, @year)=1) )
					SET @result = @result+1
			END 
		ELSE
			SET @result = 0

	RETURN @result
	END
GO
-- ///////// CREATE FUNCTION '[FMK].[fnDateIsDateValid]' /////////////
IF Object_ID('FMK.fnDateIsDateValid') IS NOT NULL
	DROP FUNCTION [FMK].[fnDateIsDateValid]
GO

CREATE FUNCTION [FMK].[fnDateIsDateValid] (@type SMALLINT, @year SMALLINT, @month SMALLINT, @day SMALLINT) 
RETURNS BIT AS
	BEGIN 

		DECLARE @result BIT

		IF ( (@year != 0) AND (@month >= 1) AND (@month <= 12) AND
					(@day >= 1) AND (@day <= FMK.fnDateDaysOfMonth(@type, @year, @month)) )
			SET @result = 1
		ELSE
			SET @result = 0

		RETURN @result

	END
GO
-- ///////// CREATE FUNCTION '[FMK].[fnDateDaysToDate]' /////////////
IF Object_ID('FMK.fnDateDaysToDate') IS NOT NULL
	DROP FUNCTION [FMK].[fnDateDaysToDate]
GO

CREATE FUNCTION [FMK].[fnDateDaysToDate] (@type SMALLINT, @year SMALLINT, @month SMALLINT, @day SMALLINT) 
RETURNS SMALLINT AS
BEGIN 

	DECLARE @result SMALLINT

	IF ( FMK.fnDateIsDateValid(@type, @year, @month, @day) = 1)
		BEGIN
			SET @result = FMK.fnDateDaysToMonth(@type, @month) + @day
			IF ( (@month > FMK.fnDateLeapMonth(@type)) AND (FMK.fnDateIsLeapYear(@type, @year) = 1) )
				SET @result = @result+1
		END
	ELSE
		SET @result = 0

RETURN @result

END
GO

-- ///////// CREATE FUNCTION '[FMK].[spDateDateOfDay]' /////////////
IF Object_ID('FMK.spDateDateOfDay') IS NOT NULL
	DROP PROC [FMK].[spDateDateOfDay]
GO

CREATE PROC [FMK].[spDateDateOfDay] @type SMALLINT, @days SMALLINT, @year SMALLINT, @month SMALLINT OUTPUT, @day SMALLINT OUTPUT, @result BIT OUTPUT
AS

	DECLARE @leapday SMALLINT
	DECLARE @m SMALLINT

	SET @leapday = 0
	SET @month = 0
	SET @day = 0
	SET @m = 2

	WHILE (@m <= 13)
		BEGIN
			IF ( (@m > FMK.fnDateLeapMonth(@type)) AND (FMK.fnDateIsLeapYear(@type, @year) = 1) )
				SET @leapday = 1
			IF ( @days <= (FMK.fnDateDaysToMonth(@type, @m) + @leapday) )
			BEGIN
				SET @month = @m - 1
				IF ( @month <= FMK.fnDateLeapMonth(@type) ) 
					SET @leapday = 0
				SET @day = @days - (FMK.fnDateDaysToMonth(@type, @month) + @leapday)
				BREAK
			END

			SET @m = @m+1
		END
	SET @result = FMK.fnDateIsDateValid(@type, @year, @month, @day)
GO

-- ///////// CREATE FUNCTION '[FMK].[spDateShamsiToMiladi]' /////////////
IF Object_ID('FMK.spDateShamsiToMiladi') IS NOT NULL
	DROP PROC [FMK].[spDateShamsiToMiladi]
GO

CREATE PROC [FMK].[spDateShamsiToMiladi] @year SMALLINT OUTPUT, @month SMALLINT OUTPUT, @day SMALLINT OUTPUT, @result BIT OUTPUT
	AS
	DECLARE @leapday SMALLINT
	DECLARE @days SMALLINT
	DECLARE @prevsolarleap BIT

	IF ( FMK.fnDateIsDateValid(0, @year, @month, @day) = 1 )
		BEGIN
			SET @prevsolarleap= FMK.fnDateIsLeapYear(0, @year-1)
			SET @days = FMK.fnDateDaysToDate(0, @year, @month, @day)
			SET @year = @year + 621
			IF ( FMK.fnDateIsLeapYear(1, @year) = 1 )
				SET @leapday = 1
			ELSE
				SET @leapday = 0
			IF ( (@prevsolarleap = 1) AND (@leapday = 1) )
				SET @days = @days + 80
			ELSE
				SET @days = @days + 79
			IF ( @days > (365 + @leapday) )
				BEGIN
					SET @year = @year+1
					SET @days = @days - (365 + @leapday)
				END
					EXEC FMK.spDateDateOfDay 1, @days, @year, @month OUT, @day OUT, @result OUT
		END
	ELSE
		SET @result = 0

GO