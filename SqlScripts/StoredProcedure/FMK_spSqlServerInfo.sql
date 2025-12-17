
If Object_ID('FMK.spSqlServerInfo') IS NOT NULL
	DROP PROCEDURE FMK.spSqlServerInfo
GO
CREATE PROCEDURE FMK.spSqlServerInfo @ProperyName nvarchar(100)
AS
BEGIN
	SELECT
            SERVERPROPERTY(@ProperyName)
END