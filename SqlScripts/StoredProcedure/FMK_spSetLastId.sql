If Object_ID('FMK.spSetLastId') IS NOT NULL
	DROP PROCEDURE FMK.spSetLastId
GO
CREATE PROCEDURE FMK.[spSetLastId] @TableName nvarchar(100), @LastId int
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		IF EXISTS (Select 1 from FMK.IDGeneration where TableName = @TableName)
		BEGIN
			UPDATE FMK.IDGeneration WITH(ROWLOCK) 
			SET LastId = @LastId 
			WHERE TableName = @TableName
		END
		ELSE
		BEGIN
			INSERT INTO FMK.IDGeneration VALUES(@TableName , @LastId)
		END
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
	END CATCH
END
