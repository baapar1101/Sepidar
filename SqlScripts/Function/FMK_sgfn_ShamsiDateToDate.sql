IF OBJECT_ID('FMK.sgfn_ShamsiDateToDate') IS NOT NULL
	DROP FUNCTION [FMK].[sgfn_ShamsiDateToDate]
GO
CREATE function [FMK].[sgfn_ShamsiDateToDate] (@Sh_Y int, @Sh_M int, @Sh_D int) 
returns  datetime AS
begin
  declare @I int, @TmpY int, @Leap int, @D_of_Y int

  Declare @Result DateTime

  if @Sh_Y < 100
  BEGIN
    --TODO:MahdiMo for 1400 
    if @Sh_Y > 20 
		Set @Sh_Y = @Sh_Y + 1300
	else
		Set @Sh_Y = @Sh_Y + 1400
  END

  if @Sh_M >= 7
    Set @D_of_Y = 31 * 6 + (@Sh_M-7) * 30 + @Sh_D
  else
    Set @D_of_Y = (@Sh_M-1) * 31 + @Sh_D

 

  if @Sh_Y = 1278
  begin
    Set @Result = @D_of_Y-(31*6 + 3*30+11)
  end  
  else
  begin
    Set @Result = 365 - (31*6 + 3*30+11) + 1
    Set @I = 1279

    while @I < @Sh_Y
    begin
      Set @TmpY = @I + 11
      Set @TmpY = @TmpY - ( @TmpY / 33) * 33
      if  (@TmpY <> 32) and ( (@TmpY / 4) * 4 = @TmpY )
        Set @Leap = 1
      else
        Set @Leap = 0
      if @Leap = 1
        Set @Result = @Result + 366
      else
        Set @Result = @Result + 365
      Set @I = @I + 1
    end

    Set @Result = @Result + @D_of_Y - 1 
  end
  return @Result
end

GO
