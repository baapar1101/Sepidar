/* SD.DefineDefaultUser */ /* this line is for dependancey order of scripts*/
IF NOT EXISTS (SELECT 1 FROM INV.TracingCategory WHERE Title = N'رديابي پيش فرض')
BEGIN
	DECLARE @id INT
	declare @Creator int
	DECLARE @RC int
	Set @Creator = (Select UserID from Fmk.[user] where UserName = 'Admin')
	if (@Creator is null)
	begin
		RaisError('There is no Admin User in Database',16, 1 )
	end


	EXECUTE  [FMK].[spGetNextId] 'INV.TracingCategory', @id OUTPUT, 1
	INSERT INTO INV.TracingCategory
		(TracingCategoryID,Title, Title_En, IsFixed, Creator, CreationDate, LastModifier, LastModificationDate, Version)
		VALUES
		(@id,N'رديابي پيش فرض', 'Default Tracing',0,@Creator,GETDATE(),@Creator, GETDATE(), 0 )
END



