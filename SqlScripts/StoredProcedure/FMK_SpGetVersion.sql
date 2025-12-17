If Object_ID('FMK.SpGetVersion') Is Not Null
	Drop Procedure FMK.SpGetVersion
GO
CREATE PROCEDURE Fmk.SpGetVersion @Major int output, @Minor int output, @Build int output, @Revision int output
AS
BEGIN
	Select top 1 @Major = Major , @Minor = Minor , @Build = Build , @Revision = Revision from fmk.[Version]
	order by Major Desc, Minor Desc, Build Desc, Revision Desc
	if (@Major is null)
		Set @Major = 0
	if (@Minor is null)
		Set @Minor = 0
	if (@Build is null)
		Set @Build = 0
	if (@Revision is null)
		Set @Revision = 0
END

