/*
Declare 
  @UserName varchar(100),
  @GUID varchar(1001)
 
declare MyUserCR cursor for
select Name from sysUsers
where Name not in ('public' , 'Sys' , 'DBO' , 'Information_Schema','Guest')

OPEN MyUserCR 

FETCH NEXT FROM  MyUserCR Into @UserName 
while @@Fetch_Status = 0 
begin 
  set @GUID = NewId()
  exec sp_change_users_login 'Auto_fix' ,@UserName,Null,@GUID
  FETCH NEXT FROM MyUserCR Into @UserName 
end

Close MyUserCR 
deallocate MyUserCR 


*/