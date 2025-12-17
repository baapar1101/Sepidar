If Object_ID('FMK.SpSetVersion') Is Not Null
	Drop Procedure FMK.SpSetVersion
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE Fmk.SpSetVersion @Major int, @Minor int, @Build int , @Revision int, @CheckVersion int = 1
AS
BEGIN
	declare @IsIdentical int 
	set @isIdentical = 0
	if (@CheckVersion = 1)
	begin
		Exec Fmk.SpCheckVersion @Major , @Minor , @Build , @Revision , @IsIdentical output
	end
	if (@IsIdentical = 0)
	begin
		declare @id int
		Exec FMK.spGetNextId 'Fmk.Version',@id output,1
		Insert into Fmk.[Version] (VersionID, Major, Minor, Build, Revision, CreationDate, LastModificationDate, Version) 
			Values (@id,@Major, @Minor, @Build, @Revision, GetDate(), GetDate(), 0)
	end
END

