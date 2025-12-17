If Object_ID('FMK.spGetNextId') Is Not Null
	Drop Procedure FMK.spGetNextId
GO
CREATE PROCEDURE FMK.[spGetNextId] @TableName nvarchar(100), @Id int output, @IncValue int = 1
AS
BEGIN
		begin try
				begin tran
				Set @Id = (Select LastId from FMK.IDGeneration where TableName = @TableName)
				if @Id is null
				begin
						Insert into FMK.IDGeneration values(@TableName , @IncValue)
						set @Id = @IncValue
				end
				else
				begin
						Update FMK.IDGeneration with(Rowlock) Set LastId = LastId + @IncValue where TableName = @TableName 
						Set @Id = @Id + @IncValue
				end
				commit tran
		end try
		begin catch
				rollback tran
		end catch
		return @ID
END


