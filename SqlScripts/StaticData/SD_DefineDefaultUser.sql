if not Exists(select 1 from fmk.[user] where UserName='Admin')
begin
	declare @id int
	exec Fmk.spGetNextID 'FMK.User',@id out,1
	insert into fmk.[user] (userID,[Name],Name_En,UserName,[Password],[status],[Creator],[CreationDate],LastModifier,LastModificationDate,IsDeleted,CanChangeAdminConfiguration, CanLoginAsAPIServer, Version)
	values (@id,'سرپرست','Supervisor','Admin','212-29-140-217-143-0-178-4-233-128-9-152-236-248-66',1,@id,GetDate(),@id,GetDate(),0,1,1,1)
end
