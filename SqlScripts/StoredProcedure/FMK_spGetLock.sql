IF Object_ID('FMK.spGetLock') Is Not Null
	Drop Procedure FMK.spGetLock
GO

CREATE PROCEDURE FMK.spGetLock @spResource nvarchar(255)
AS
	DECLARE @Resource nvarchar(255) 
	EXEC sp_getapplock @Resource = @spResource, @LockMode = 'Exclusive', @LockOwner = 'Transaction', @LockTimeout = @@LOCK_TIMEOUT
GO

IF Object_ID('FMK.spGetSharedLock') Is Not Null
	Drop Procedure FMK.spGetSharedLock
GO

CREATE PROCEDURE FMK.spGetSharedLock @spResource nvarchar(255)
AS
	DECLARE @Resource nvarchar(255) 
	EXEC sp_getapplock @Resource = @spResource, @LockMode = 'Shared', @LockOwner = 'Transaction', @LockTimeout = @@LOCK_TIMEOUT
GO 