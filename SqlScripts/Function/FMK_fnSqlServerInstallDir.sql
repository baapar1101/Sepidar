if object_id('fmk.fnSQLServerInstallDir') is not null
drop function fmk.fnSQLServerInstallDir
go

create function fmk.fnSQLServerInstallDir()
returns nvarchar(4000)
as
begin

declare @rc int,
@dir nvarchar(4000)

exec @rc = master.dbo.xp_instance_regread
N'HKEY_LOCAL_MACHINE',N'Software\Microsoft\MSSQLServer\Setup',N'SQLPath',
@dir output, 'no_output'
return @dir

end
go
