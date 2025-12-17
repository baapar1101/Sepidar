If Object_ID('FMK.vwUser') Is Not Null
	Drop View [FMK].[vwUser]
GO
CREATE VIEW [FMK].[vwUser]
AS
SELECT 
	UserID, Name, Name_En, UserName, Password, Status, Creator, LastModifier, CreationDate, 
	LastModificationDate, IsDeleted, CanChangeAdminConfiguration, CanLoginAsAPIServer, [Version]
FROM FMK.[User]
WHERE IsDeleted = 0
