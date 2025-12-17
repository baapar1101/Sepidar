If Object_ID('FMK.spAddKeyword') Is Not Null
	Drop Procedure FMK.spAddKeyword
GO
CREATE PROCEDURE Fmk.spAddKeyword 
	@ActionKey nchar(250), 
	@Value_fa nvarchar(500),
	@Value_en nvarchar(500),
	@Value_ku nvarchar(500),
	@Value_ar nvarchar(500)
AS
BEGIN
	if Exists(Select 1 from Fmk.[Keyword] where [ActionKey] = @ActionKey)
	begin
		Delete Fmk.[Keyword] where [ActionKey] = @ActionKey
	end

	Insert Into Fmk.[Keyword] (ActionKey)
	Values (@ActionKey)

	DECLARE @id int
	set @id = @@IDENTITY

	Insert Into FMK.[KeywordLocale] ([KeywordRef], [LocaleName], [Value])
	Values (@id, 'fa', @Value_fa)
	IF @Value_en IS NOT NULL AND @Value_ku != ''
	BEGIN
		Insert Into FMK.[KeywordLocale] ([KeywordRef], [LocaleName], [Value])
		Values (@id, 'en', @Value_en)
	END
	IF @Value_ku IS NOT NULL AND @Value_ku != ''
	BEGIN
		INSERT INTO FMK.[KeywordLocale] ([KeywordRef], [LocaleName], [Value])
		Values (@id , 'ku', @Value_ku)
	END
	IF @Value_ar IS NOT NULL AND @Value_ar != ''
	BEGIN
		INSERT INTO FMK.[KeywordLocale] ([KeywordRef], [LocaleName], [Value])
		Values (@id , 'ar', @Value_ar)
	END
END

