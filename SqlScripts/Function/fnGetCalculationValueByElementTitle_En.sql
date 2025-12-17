If Object_ID('Pay.fn_GetCalculationValueByElementTitle_En') Is Not Null
	Drop Function Pay.fn_GetCalculationValueByElementTitle_En
GO

If Object_ID('Pay.fnGetCalculationValueByElementTitle_En') Is Not Null
	Drop Function Pay.fnGetCalculationValueByElementTitle_En
GO

CREATE FUNCTION Pay.fnGetCalculationValueByElementTitle_En
(
	@ElementTitle_En nvarchar(200), @PersonnelId int,  @Type int, @YearMonth DateTime
)
RETURNS decimal(24, 4)
AS
BEGIN
	RETURN 
	(SELECT TOP 1 Calc.Value
		FROM PAY.Calculation Calc
			INNER JOIN  PAY.Element E ON Calc.ElementRef = E.ElementId
		 WHERE	Calc.PersonnelRef = @PersonnelId
				AND Calc.[Date] = @yearMonth
				AND Calc.[Type] = @Type
				AND E.Title_En = @ElementTitle_En)
END
