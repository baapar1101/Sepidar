IF Object_ID('FMK.AddImportTemplate') Is Not Null
	DROP PROCEDURE FMK.AddImportTemplate
GO
CREATE PROCEDURE FMK.AddImportTemplate(@PersianTitle nvarchar(255), @EnglishTitle nvarchar(255), 
	@Template NVARCHAR(MAX), @GUID uniqueidentifier, @Type nvarchar(MAX))
AS
	EXEC FMK.AddTemplate @PersianTitle, @EnglishTitle, @Template, @GUID, @Type, 1

