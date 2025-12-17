IF EXISTS(	SELECT 1 FROM sys.objects obj
				INNER JOIN sys.schemas sch ON obj.schema_id = sch.schema_id 
			WHERE sch.name = 'FMK' AND obj.name = 'sgfn_DateToShamsiDatePart')
	DROP FUNCTION [FMK].[sgfn_DateToShamsiDatePart]
GO

CREATE FUNCTION [FMK].[sgfn_DateToShamsiDatePart] (@MiDate DateTime , @ADatePart CHAR) RETURNS INT
AS
BEGIN

  Declare @TmpY int, @Leap int

  Declare @Sh_Y int , @Sh_M int , @Sh_D int, @Result int

  if @MiDate is null 

    return 0

  --Declare @Result int

  Set @Result = convert(int, convert(float,@MiDate))

  if @Result <= 78

  begin

    Set @Sh_Y = 1278

    Set @Sh_M = (@Result + 10) / 30 + 10 

    Set @Sh_D = (@Result + 10) % 30 + 1

  end 

  else

  begin

    Set @Result = @Result - 78

    Set @Sh_Y = 1279

    while 1 = 1 

    begin

      Set @TmpY = @Sh_Y + 11

      Set @TmpY = @TmpY - ( @TmpY / 33) * 33

      if  (@TmpY <> 32) and ( (@TmpY / 4) * 4 = @TmpY )

        Set @Leap = 1

      else

        Set @Leap = 0

      if @Result <= (365+@Leap)

        break

      Set @Result = @Result -  (365+@Leap)

      Set @Sh_Y = @Sh_Y + 1

    end

    if @Result <= 31*6

    begin

      Set @Sh_M = (@Result-1) / 31 + 1

      Set @Sh_D = (@Result-1) % 31 + 1

    end

    else

    begin

      Set @Sh_M = ((@Result-1) - 31*6) / 30 + 7

      Set @Sh_D = ((@Result-1) - 31*6) % 30 + 1

    end

  end

  return

    case @ADatePart

      when 'Y' then  @Sh_Y

      when 'M' then @Sh_M

      when 'D' then @Sh_D

    else  0

    end

end