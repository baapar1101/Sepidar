if object_id('fmk.fnCalcCheckSum') is not null
drop function fmk.fnCalcCheckSum
go

CREATE FUNCTION Fmk.fnCalcCheckSum 
(
	@data1 nvarchar(max) = null,
	@data2 nvarchar(max) = null,
	@data3 nvarchar(max) = null,
	@data4 nvarchar(max) = null,
	@data5 nvarchar(max) = null,
	@data6 nvarchar(max) = null,
	@data7 nvarchar(max) = null,
	@data8 nvarchar(max) = null,
	@data9 nvarchar(max) = null
)
RETURNS decimal(34,0)
AS
BEGIN
	DECLARE @Result decimal(34,0)
	Set @result = 0

	if (@data1 is not null)
		Set @Result = @Result + cast(CheckSum(@Data1) as decimal(34,0))
	if (@data2 is not null)
		Set @Result = @Result + cast(CheckSum(@Data2) as decimal(34,0))
	if (@data3 is not null)
		Set @Result = @Result + cast(CheckSum(@Data3) as decimal(34,0))
	if (@data4 is not null)
		Set @Result = @Result + cast(CheckSum(@Data4) as decimal(34,0))
	if (@data5 is not null)
		Set @Result = @Result + cast(CheckSum(@Data5) as decimal(34,0))
	if (@data6 is not null)
		Set @Result = @Result + cast(CheckSum(@Data6) as decimal(34,0))
	if (@data7 is not null)
		Set @Result = @Result + cast(CheckSum(@Data7) as decimal(34,0))
	if (@data8 is not null)
		Set @Result = @Result + cast(CheckSum(@Data8) as decimal(34,0))
	if (@data9 is not null)
		Set @Result = @Result + cast(CheckSum(@Data9) as decimal(34,0))
	RETURN @Result

END
GO
