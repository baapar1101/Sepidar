If Object_ID('FMK.SpCheckVersion') Is Not Null
	Drop Procedure FMK.SpCheckVersion
GO

CREATE PROCEDURE Fmk.SpCheckVersion @Major int, @Minor int, @Build int , @Revision int, @isIdentical int output
AS
BEGIN
	declare @CurrentMajor int, @CurrentMinor int, @CurrentBuild int , @CurrentRevision int
	Exec Fmk.SpGetVersion @CurrentMajor output, @CurrentMinor output, @CurrentBuild output, @CurrentRevision output
	set @isIdentical = 0
	if (@CurrentMajor > @Major)
	begin
		raiserror('Major version conflict', 16, 1 );
	end
	else if (@CurrentMajor = @Major)
	begin
		if (@CurrentMinor > @Minor)
		begin
			raiserror('Minor version conflict', 16, 1 );
		end
		else if (@CurrentMinor = @Minor)
		begin
			if (@CurrentBuild > @Build)
				raiserror('Build version conflict', 16, 1 );
		end
	end

	if (@CurrentMajor = @Major and @CurrentMinor = @Minor and @CurrentBuild = @Build)
		set @isIdentical = 1
END

