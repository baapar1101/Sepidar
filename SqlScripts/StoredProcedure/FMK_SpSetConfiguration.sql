If Object_ID('FMK.spSetConfiguration') Is Not Null
	Drop Procedure FMK.spSetConfiguration
GO
Create PROCEDURE [FMK].[spSetConfiguration] 
	@Key nchar(50), 
	@Value nvarchar(max)
AS
BEGIN
	declare @id int
	Select @ID = ConfigurationID from Fmk.[Configuration] where [key] = @Key
	if (@id is null)
	begin
		Exec Fmk.SpGetNextID 'Fmk.Configuration',@id output,1
		Insert into Fmk.[Configuration] (ConfigurationID, [Key], [Value], Version)
		Values(@id, @Key, @Value, 0)
	end
	else
	begin
		Update Fmk.[Configuration] Set [Value] = @Value where [Key] = @Key
	end

END
GO