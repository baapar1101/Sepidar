DECLARE @key AS NVARCHAR(50), @value AS NVARCHAR(MAX)
SET @key = 'IsValueAddedDLTypeParty'

SELECT @value=[Value] FROM FMK.Configuration WHERE [Key]=@key

IF @value IS NULL OR @value=''
BEGIN
	exec FMK.spSetConfiguration @key,'FALSE'
END