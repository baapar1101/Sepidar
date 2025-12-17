IF OBJECT_ID('FMK.vwUserPhone') Is Not Null
	DROP VIEW FMK.vwUserPhone
GO
CREATE VIEW FMK.vwUserPhone
AS
SELECT UP.UserPhoneId, UP.UserRef, UP.[Type], UP.Phone, UP.IsMain
FROM FMK.UserPhone AS UP
	INNER JOIN FMK.[User] U ON U.UserId = UP.UserRef
WHERE  U.IsDeleted = 0