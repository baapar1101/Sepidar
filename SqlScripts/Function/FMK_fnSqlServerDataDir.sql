if object_id('fmk.fnSQLServerDataDir') is not null
drop function fmk.fnSQLServerDataDir
go

create function fmk.fnSQLServerDataDir()
returns nvarchar(4000)
as
begin

declare @rc int,
@dir nvarchar(4000)
exec @rc = master.dbo.xp_instance_regread
N'HKEY_LOCAL_MACHINE',N'Software\Microsoft\MSSQLServer\MSSQLServer',N'DefaultData',
@dir output, 'no_output'

if (@dir is null)
begin
exec @rc = master.dbo.xp_instance_regread
N'HKEY_LOCAL_MACHINE',N'Software\Microsoft\MSSQLServer\Setup',N'SQLDataRoot',
@dir output, 'no_output'
select @dir = @dir + N'\Data'
end

return @dir

end
go
