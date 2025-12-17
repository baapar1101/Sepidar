if object_id('fmk.fnSQLServerBackupDir') is not null
drop function fmk.fnSQLServerBackupDir
go

create function fmk.fnSQLServerBackupDir()
returns nvarchar(4000)
as
begin

declare @rc int,
@dir nvarchar(4000)

exec @rc = master.dbo.xp_instance_regread
N'HKEY_LOCAL_MACHINE',N'Software\Microsoft\MSSQLServer\MSSQLServer',N'BackupDirectory',
@dir output, 'no_output'
return @dir

end
go