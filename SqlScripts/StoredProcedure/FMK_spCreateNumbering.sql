If Object_ID('FMK.spCreateNumbering') Is Not Null
	Drop Procedure FMK.spCreateNumbering
GO
CREATE PROCEDURE Fmk.spCreateNumbering 
	@EntityFullName varchar(800), 
	@Method int, 
	@StartValue BigInt, 
	@FinishValue BigInt , 
	@ApplyProperty1 bit, 
	@ApplyProperty2 bit, 
	@ApplyProperty3 bit , 
	@ApplyPorperty4 bit
AS
BEGIN
	if not Exists(select 1 from FMK.NumberedEntity Where EntityFullName = @EntityFullName)
	begin
			declare @ID int
			declare @Creator int
			Set @Creator = (Select UserID from Fmk.[user] where UserName = 'Admin')
			if (@Creator is null)
			begin
				RaisError('There is no Admin User in Database',16, 1 )
			end
			if (@@error = 0)
			begin
	
				Exec FMK.spGetNextId 'FMK.NumberedEntity',@id output,1
				Insert into FMK.NumberedEntity 
				(NumberedEntityID, 
				EntityFullName, 
				Method, 
				StartValue, 
				FinishValue, 
				ApplyProperty1, 
				ApplyProperty2, 
				ApplyProperty3, 
				ApplyPorperty4, 
				Creator, 
				CreationDate, 
				LastModifier, 
				LastModificationDate, 
				Version)
				Values 
				(
				@id,
				@EntityFullName,
				@Method, 
				@StartValue, 
				@FinishValue, 
				@ApplyProperty1, 
				@ApplyProperty2, 
				@ApplyProperty3, 
				@ApplyPorperty4, 
				@Creator, 
				GetDate(), 
				@Creator, 
				GetDate(), 
				1)
			end
	end
END

