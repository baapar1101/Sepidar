declare @DbName nvARCHAR (100)
If Object_ID('master.dbo.ClearDBUsers') Is Not Null
begin
	select @DbName = db_nAME()
	DECLARE @SQL NVARCHAR(MAX)
	Set @SQL = N'USE master '+
       '; DROP PROCEDURE [dbo].ClearDBUsers;' 
	   EXEC (@SQL)
END
Go

declare @DbName nvARCHAR (100)
	DECLARE @SQL NVARCHAR(MAX)

select @DbName = db_nAME()


set @SQL = N' CREATE PROCEDURE dbo.ClearDBUsers 
			@dbName SYSNAME 
				AS 
				BEGIN 
					SET NOCOUNT ON 
 
					DECLARE @spid INT, 
						@cnt INT, 
						@sql VARCHAR(255) 
 
					SELECT @spid = MIN(spid), @cnt = COUNT(*) 
						FROM master..sysprocesses 
						WHERE dbid = DB_ID(@dbname) 
						AND spid != @@SPID 
     
					WHILE @spid IS NOT NULL 
					BEGIN 
						SET @sql = ''''KILL ''''+RTRIM(@spid) 
						EXEC(@sql) 
 
						SELECT @spid = MIN(spid), @cnt = COUNT(*) 
							FROM master..sysprocesses 
							WHERE dbid = DB_ID(@dbname) 
							AND spid != @@SPID 
 				
					END 
				END '
SET @sql = 'USE master; EXEC ('' ' + @SQL + ''');'

EXEC (@SQL)

Set @SQL = 'USE ' + QUOTENAME(@DbName) 
EXEC (@SQL)

GO
