If Object_ID('FMK.SpGetVersionAsString') Is Not Null
	Drop Procedure FMK.SpGetVersionAsString
GO
CREATE PROCEDURE  Fmk.SpGetVersionAsString 
AS
BEGIN
	declare @version varchar(30)
	declare @CurrentMajor int, @CurrentMinor int, @CurrentBuild int , @CurrentRevision int
	Exec Fmk.SpGetVersion @CurrentMajor output, @CurrentMinor output, @CurrentBuild output, @CurrentRevision output
	Set @version = (cast(@CurrentMajor as varchar)+'.'+cast(@CurrentMinor as varchar)+'.'+cast(@CurrentBuild as varchar)+'.'+cast(@CurrentRevision as varchar))
	Select @Version as 'Version'
	
END

