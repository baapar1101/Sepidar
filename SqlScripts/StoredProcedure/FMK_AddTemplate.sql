IF Object_ID('FMK.AddTemplate') Is Not Null
	DROP PROCEDURE FMK.AddTemplate
GO
CREATE PROCEDURE FMK.AddTemplate(@PersianTitle nvarchar(255), @EnglishTitle nvarchar(255), 
	@Template NVARCHAR(MAX), @GUID uniqueidentifier, @Type nvarchar(MAX), @IsImprot bit)
AS
IF EXISTS (SELECT * FROM Fmk.ImportExportTemplate WHERE GUID = @GUID)
	UPDATE FMK.ImportExportTemplate
	SET PersianTitle= @PersianTitle, 
		EnglishTitle= @EnglishTitle, 
		Template= CAST(@Template AS VARBINARY(MAX)),
		[Type]= @Type
	WHERE GUID= @GUID AND isImport = @IsImprot
ELSE 
BEGIN
	DECLARE @ID INT
	EXEC [FMK].[spGetNextId] 'FMK.ImportExportTemplate' , @ID out , 1
	INSERT INTO FMK.ImportExportTemplate
		(ImportExportTemplateID, 
		 PersianTitle, 
		 EnglishTitle, 
		 Template,
		 GUID,
		 [Type], 
		 IsImport)
	 Values
		(@ID, 
		 @PersianTitle, 
		 @EnglishTitle, 
		 CAST(@Template AS VARBINARY(MAX)),
		 @GUID,	 
		 @Type, 
		 @IsImprot)
END	
