/* SD.DefineDefaultUser */ /* this line is for dependancey order of scripts*/
DECLARE @Creator INT
SET @Creator = (SELECT UserID FROM FMK.[user] WHERE UserName = 'Admin')
IF (@Creator IS NULL)
BEGIN
	RaisError('There is no Admin User in Database',16, 1 )
END

IF NOT EXISTS (SELECT 1 FROM DST.[AreaAndPath] WHERE AreaAndPathId < 0)
BEGIN
	INSERT INTO [DST].[AreaAndPath]
			   ([AreaAndPathId]
			   ,[Type]
			   ,[Code]
			   ,[Title]
			   ,[Title_En]
			   ,[IsActive]
			   ,[ParentAreaAndPathRef]
			   ,[Version]
			   ,[Creator]
			   ,[CreationDate]
			   ,[LastModifier]
			   ,[LastModificationDate])
		 VALUES
			   (-5
			   , 0
			   , 0
			   , 'منطقه و مسير'
			   , 'Area and Path'
			   , 1
			   , NULL
			   , 0
			   , @Creator
			   , GETDATE()
			   , @Creator
			   , GETDATE())
END
