If Object_ID('Pay.fn_GetCalculationValueByElementId') Is Not Null
	Drop Function Pay.fn_GetCalculationValueByElementId
GO


If Object_ID('Pay.fnGetCalculationValueByElementId') Is Not Null
	Drop Function Pay.fnGetCalculationValueByElementId
GO

  
CREATE FUNCTION Pay.fnGetCalculationValueByElementId  
(  
 @ElementId int, @PersonnelId int, @Type int, @YearMonth DateTime  
)  
RETURNS decimal(24, 4)  
AS  
BEGIN  
 RETURN   
 (SELECT Top 1 Value FROM Pay.Calculation 
	WHERE ElementRef = @ElementId 
		and PersonnelRef = @PersonnelId 
		and Date = @yearMonth
		and Type = @Type)  
END  
  
