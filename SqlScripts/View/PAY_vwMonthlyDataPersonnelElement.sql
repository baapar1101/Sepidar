If Object_ID('PAY.vwMonthlyDataPersonnelElement') Is Not Null
	Drop View PAY.vwMonthlyDataPersonnelElement
GO
CREATE VIEW PAY.vwMonthlyDataPersonnelElement
AS
SELECT
	MDPE.MonthlyDataPersonnelElementlId,
	MDPE.MonthlyDataPersonnelRef, 
	MDPE.Type, 
	MDPE.ElementRef,
	MDPE.Value, MDP.PersonnelRef, 
	MD.Date, 
	PERS.DLCode, 
	PERS.DLTitle_En,
	PERS.DLTitle,
	PERS.IdentificationCode,
	E.Class ElementClass,
	E.Type ElementType
	,CostCenterTitle = 
      (
			SELECT TOP 1 c.CostCenterTitle 
			FROM PAY.vwContract C
			WHERE C.PersonnelRef = MDP.PersonnelRef 
			AND (C.EndDate    >= MD.Date OR C.EndDate IS NULL)
			AND (C.IssueDate  <= FMK.fnGetLastDayOfMonth(Date))
		    ORDER BY c.IssueDate Desc
    )
	
FROM PAY.MonthlyDataPersonnelElement AS MDPE 
	INNER JOIN PAY.MonthlyDataPersonnel AS MDP ON MDPE.MonthlyDataPersonnelRef = MDP.MonthlyDataPersonnelId 
	INNER JOIN PAY.vwPersonnel AS PERS ON MDP.PersonnelRef = PERS.PersonnelId 
	INNER JOIN PAY.MonthlyData AS MD ON MDP.MonthlyDataRef = MD.MonthlyDataId 
	LEFT  JOIN Pay.Element E ON MDPE.ElementRef = E.ElementId
GO
