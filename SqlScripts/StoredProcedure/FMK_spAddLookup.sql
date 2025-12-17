If Object_ID('FMK.spAddLookup') Is Not Null
	Drop Procedure FMK.spAddLookup
GO
CREATE PROCEDURE Fmk.spAddLookup 
	@LookupType nchar(50), 
	@Code int,
	@Title nvarchar(100),
	@Title_En nvarchar(100),
	@Title_ku nvarchar(100),
	@Title_ar nvarchar(100),
	@SystemName char(3), 
	@DisplayOrder int = 1,
	@Extra nvarchar(100) = ''
AS
BEGIN
	if Exists(Select 1 from Fmk.[lookup] where [Type] = @LookupType and Code = @Code)
	begin
		Delete Fmk.[lookup] where [Type] = @LookupType and Code = @Code
	end

	Insert Into Fmk.[lookup] ([Type], Code, Title, DisplayOrder, Extra, [System])
	Values (@LookupType, @Code, @Title, @DisplayOrder, @Extra, @SystemName)
	DECLARE @id int
	set @id = @@IDENTITY
	Insert Into FMK.[LookupLocale] ([LookupRef], [LocaleName], [Title])
	Values (@id, 'en', @Title_En)
	IF @Title_ku IS NOT NULL AND @Title_ku != ''
	BEGIN
	INSERT INTO FMK.[LookupLocale] ([LookupRef], [LocaleName], [Title])
	Values (@id , 'ku', @Title_ku)
	END
	IF @Title_ar IS NOT NULL AND @Title_ar != ''
	BEGIN
	INSERT INTO FMK.[LookupLocale] ([LookupRef], [LocaleName], [Title])
	Values (@id , 'ar', @Title_ar)
	END
END

