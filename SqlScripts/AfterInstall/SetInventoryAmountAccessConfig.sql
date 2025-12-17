if not exists( SELECT * FROM FMK.[Configuration]  where [KEY] = N'InventoryAmountAccess')
         AND  not exists( SELECT * FROM [FMK].[UserAccess]  WHERE HasAccess = 1)
BEGIN
	DECLARE @id int
	EXEC [FMK].[spGetNextId] 'FMK.Configuration', @id output, 1

	INSERT INTO FMK.[Configuration] ([ConfigurationID], [Key], [Value], [Version]) 
	VALUES (@id , N'InventoryAmountAccess', N'True', 1)
END