IF OBJECT_ID('FMK.fnGetLastDayOfMonth') IS NOT NULL
	DROP FUNCTION [FMK].[fnGetLastDayOfMonth]
GO
CREATE FUNCTION [FMK].[fnGetLastDayOfMonth](@ChirsDate DateTime) 
RETURNS DateTime
AS
BEGIN
	Declare @Year int, @Month int, @Day int

	SET @Year  = FMK.sgfn_DateToShamsiDatePart (@ChirsDate , 'Y')
	SET @Month = FMK.sgfn_DateToShamsiDatePart (@ChirsDate , 'M')
	SET @Day   = FMK.fnDateDaysOfMonth(0,@Year , @Month)

	RETURN FMK.sgfn_ShamsiDateToDate (@Year, @Month, @Day)
END
GO
