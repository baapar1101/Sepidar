
----IF Object_ID('FMK.Sp_ImplicitTransactionsOff') IS NOT NULL
----	DROP PROCEDURE FMK.Sp_ImplicitTransactionsOff
----GO
----CREATE PROCEDURE [FMK].[Sp_ImplicitTransactionsOff]
----AS

----BEGIN
----	declare @id int = DB_ID();
----	declare @sqlalter nvarchar(128) = N'';
----	select @sqlalter += N'alter database' + QUOTENAME(db_name(@id)) + 'SET RESTRICTED_USER WITH ROLLBACK IMMEDIATE;'+char(10)
----	SET IMPLICIT_TRANSACTIONS OFF
----	EXEC sp_sqlexec @sqlalter
----END
----GO

----IF Object_ID('FMK.Sp_ExecuteSqlText') IS NOT NULL
----	DROP PROCEDURE FMK.Sp_ExecuteSqlText
----GO
----CREATE PROCEDURE [FMK].[Sp_ExecuteSqlText] @sqlText nvarchar(max)
----AS

----BEGIN
----	EXEC sp_sqlexec @sqlText
----END
----GO 

	



----set nocount on
--declare @sqlIncrease nvarchar(max) = N''

--declare @id int = DB_ID();
--declare @dbName nvarchar (max) = QUOTENAME(db_name(@id));  

--select  @sqlIncrease += N'alter database '+QUOTENAME(db_name(@id)) + ' modify file (name = N'''+name+''', maxsize = 1GB);'+char(10)
--                    from sys.master_files
--                    where database_id = @id 
--                    and state_desc = 'ONLINE'
--                    and type_desc = 'LOG' -- since we only want to change log files

                                          
--if( (select size from sys.database_files
--	 	where type = 1 
--	 		  and file_id = (select min(file_id) from sys.database_files where type = 1))/128 < 1000 ) -- GET LOG SIZE 
--Begin
--Begin tran	 		  
--	--exec FMK.Sp_ImplicitTransactionsOff
	
--	EXEC sp_sqlexec @sqlIncrease
--	commit tran
--end

--GO
	
