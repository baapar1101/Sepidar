IF EXISTS(	SELECT 1 FROM sys.objects obj
				INNER JOIN sys.schemas sch ON obj.schema_id = sch.schema_id 
			WHERE sch.name = 'FMK' AND obj.name = 'sgfn_DateToShamsiDate')
	DROP FUNCTION [FMK].[sgfn_DateToShamsiDate]
GO

CREATE FUNCTION [FMK].[sgfn_DateToShamsiDate](@ChirsDate SmallDateTime) returns Char(10)  as

begin

  declare @SolarDate char(10)

  declare @Day  Char(2)

  declare @Mon Char(2)

  declare @SDay  Int

  declare @SMon Int

  declare @SYear Int

  set @SYear = FMK.sgfn_DateToShamsiDatePart(@ChirsDate, 'Y')

  set @SMon = FMK.sgfn_DateToShamsiDatePart(@ChirsDate, 'M')

  set @SDay = FMK.sgfn_DateToShamsiDatePart(@ChirsDate, 'D')


  if @SMon <= 9

    select @Mon = '0'+Convert(Char(1),@SMon)

  else

    select @Mon = Convert(Char(2),@SMon)

  if @SDay <= 9

    select @Day = '0'+Convert(Char(1),@SDay)

  else

    select @Day = Convert(Char(2),@SDay)

  select  @SolarDate = SubString(Convert(Char(4),@SYear),3,2)+'/'+@Mon+'/'+@Day

  return @SolarDate

end

