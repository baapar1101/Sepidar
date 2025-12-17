If Object_ID('PAY.spGetMatrixDataForMonthlyData') Is Not Null
	Drop Procedure PAY.spGetMatrixDataForMonthlyData
GO
CREATE PROCEDURE [PAY].[spGetMatrixDataForMonthlyData] @PersonnelRef INT , @FromDate DATETIME ,@ToDate DATETIME 
AS
BEGIN
		DECLARE @columns NVARCHAR(MAX) ='', @sql NVARCHAR(MAX) ='' 
		

		SELECT  @columns += '['+ CAST ( M.ElementRef AS VARCHAR(15))+'],'
		FROM Pay.vwMonthlyDataPersonnelelement M
	            LEFT JOIN Pay.Element E ON M.ElementRef = E.ElementId
            WHERE M.ElementRef IS NOT NULL
                AND (M.PersonnelRef = @PersonnelRef OR -1 = @PersonnelRef)
                AND (M.Date >= @FromDate OR -1 = @FromDate)
	            AND (M.Date <= @ToDate OR -1 = @ToDate)
		    GROUP BY M.ElementRef
		   ORDER BY M.ElementRef
				
				IF LEN(@columns)>1
					SET @columns =LEFT (@columns , LEN(@columns)-1) + ',[-1]'
				ELSE
				SET @columns='[-2]'

		SET @sql ='SELECT  '''' YearMonth,
				   [Date],
				   DLCode,
				   DLTitle,
				   DLTitle_En,
				   IdentificationCode,
				   CostCenterTitle,
				   CostCenterTitle_En,
				   WorksiteTitle,
				   WorksiteTitle_En,'+@columns+'

FROM
(
SELECT          M.[Date], M.DLCode, M.DLTitle, M.DLTitle_En DLTitle_En, 
	            C.CostCenterTitle,C.CostCenterTitle_En, M.IdentificationCode, C.WorksiteTitle,C.WorksiteTitle_En,
				ISNULL(M.ElementRef,-1) ElementRef  ,CAST(M.Value AS decimal(24,4)) AS Value

	FROM Pay.vwMonthlyDataPersonnelelement M
	            LEFT JOIN Pay.Element E ON M.ElementRef = E.ElementId
	            LEFT JOIN (SELECT DISTINCT PersonnelRef, Date, ContractRef FROM Pay.Calculation) CL ON M.PersonnelRef = CL.PersonnelRef AND M.Date = CL.Date 
	            LEFT JOIN Pay.vwContract C ON CL.ContractRef = C.ContractId
	WHERE 
		    (M.PersonnelRef IS NOT NULL)
		AND (M.PersonnelRef = '+CAST (@PersonnelRef AS VARCHAR(5))+' OR -1 ='+CAST (@PersonnelRef AS VARCHAR(5))+')
		AND (M.Date >= '+CHAR(39)+CONVERT(varchar(10), @FromDate, 120)+CHAR(39)+' OR '+CHAR(39)+'-1'+CHAR(39) +'='+CHAR(39)+CONVERT(varchar(10), @FromDate, 120)+CHAR(39)+')
		AND (M.Date <= '+CHAR(39)+CONVERT(varchar(10), @ToDate, 120)+CHAR(39)+' OR '+CHAR(39)+'-1'+CHAR(39) +'='+CHAR(39)+CONVERT(varchar(10), @ToDate, 120) +CHAR(39)+')
	) Src
	PIVOT
	(
	  SUM (Value)
	  FOR ElementRef IN ('+@columns+')
	)PVT
	ORDER BY DLCode'
	EXEC (@sql)
END
GO


