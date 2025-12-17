IF Object_ID('FMK.AddExportTemplate') Is Not Null
	DROP PROCEDURE FMK.AddExportTemplate
GO
CREATE PROCEDURE FMK.AddExportTemplate(@PersianTitle nvarchar(255), @EnglishTitle nvarchar(255), 
	@Template NVARCHAR(MAX), @GUID uniqueidentifier, @Type nvarchar(MAX))
AS
	EXEC FMK.AddTemplate @PersianTitle, @EnglishTitle, @Template, @GUID, @Type, 0

