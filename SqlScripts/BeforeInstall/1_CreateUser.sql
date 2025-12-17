if (not Exists(select * from sys.sysusers u join sys.syslogins l on u.sid = l.sid 
where l.name = 'damavand')) 
CREATE USER damavand FOR LOGIN damavand WITH DEFAULT_SCHEMA = dbo