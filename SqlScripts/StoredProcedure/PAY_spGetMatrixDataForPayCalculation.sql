If Object_ID('PAY.spGetMatrixDataForPayCalculation') Is Not Null
	Drop Procedure PAY.spGetMatrixDataForPayCalculation
GO
CREATE PROCEDURE [PAY].[spGetMatrixDataForPayCalculation] @PersonnelRef INT , @FromDate DATETIME ,@ToDate DATETIME ,
	@CalculationTypes AS Pay.PayrollCalculationTypeTable READONLY
	WITH RECOMPILE  
AS
BEGIN
		DECLARE @columns NVARCHAR(MAX) ='', @sql NVARCHAR(MAX) ='' 
		--,@columns2 NVARCHAR(MAX) =''
		

		SELECT  @columns += '['+ CAST ( C.ElementRef AS VARCHAR(15))+'],'
		FROM Pay.Calculation C
			LEFT JOIN Pay.Element E ON C.ElementRef = E.ElementId
		WHERE 
			--C.PersonnelRef IS NOT NULL  --no branch result
			(E.Type > 3 OR C.ElementRef < 0)  --Contract, Calculated, ManualEntry and No WorkingElement
			AND (C.PersonnelRef = @PersonnelRef OR -1 = @PersonnelRef)
			AND (C.Date >= @FromDate OR -1 = @FromDate)
			AND (C.Date <= @ToDate OR -1 = @ToDate)
			AND C.Type IN (SELECT * FROM  @CalculationTypes)
		  GROUP BY C.ElementRef
		   ORDER BY C.ElementRef
				
				IF LEN(@columns)>1
					SET @columns =LEFT (@columns , LEN(@columns)-1)
				ELSE
				SET @columns='[-1]'

			DECLARE @CalcTypes NVARCHAR(MAX)=''

		SELECT @CalcTypes +=  CAST ( CalculationType AS VARCHAR(5))+','
		FROM  @CalculationTypes
		SET @CalcTypes =LEFT (@CalcTypes , LEN(@CalcTypes)-1)

				SET @sql ='SELECT  '''' YearMonth,
				   DLCode,
				   DLTitle,
				   DLTitle_En,
				   IdentificationCode,
				   CostCenterTitle,
				   WorksiteTitle,
				   TaxBranchTitle,
				   InsuranceBranchTitle,
				   TaxBranchTitle_En,
				   [Date],
				    InsuranceBranchTitle_En,'+@columns+'

FROM
(
SELECT  DLCode,
				   DLTitle,
				   DLTitle_En,
				   IdentificationCode,
				   CostCenterTitle,
				   WorksiteTitle,
				   B1.BranchTitle TaxBranchTitle,
				   B2.BranchTitle InsuranceBranchTitle,
				   B1.BranchTitle TaxBranchTitle_En,
				   B2.BranchTitle InsuranceBranchTitle_En,
				   C.[Date] ,
				   C.ElementRef , CAST(C.Value AS decimal(24,4)) AS Value
	FROM Pay.vwCalculation C
		LEFT JOIN Pay.Element E ON C.ElementRef = E.ElementId
		LEFT JOIN Pay.vwContract CT ON C.ContractRef = CT.ContractId
		LEFT JOIN Pay.vwBranch B1 ON CT.TaxBranchRef = B1.BranchId
		LEFT JOIN Pay.vwBranch B2 ON CT.InsuranceBranchRef = B2.BranchId
	WHERE C.Type IN ('+@CalcTypes+')
		AND (E.IsActive = 1) --active elements only --5397
		AND (C.ElementType > 3 OR C.ElementRef < 0)  --Contract, Calculated, ManualEntry and No WorkingElement
		AND (C.PersonnelRef IS NOT NULL)
		AND (C.PersonnelRef = '+CAST (@PersonnelRef AS VARCHAR(5))+' OR -1 ='+CAST (@PersonnelRef AS VARCHAR(5))+')
		AND (C.Date >= '+CHAR(39)+CONVERT(varchar(10), @FromDate, 120)+CHAR(39)+' OR '+CHAR(39)+'-1'+CHAR(39) +'='+CHAR(39)+CONVERT(varchar(10), @FromDate, 120)+CHAR(39)+')
		AND (C.Date <= '+CHAR(39)+CONVERT(varchar(10), @ToDate, 120)+CHAR(39)+' OR '+CHAR(39)+'-1'+CHAR(39) +'='+CHAR(39)+CONVERT(varchar(10), @ToDate, 120) +CHAR(39)+')
	) Src
	PIVOT
	(
	  SUM (Value)
	  FOR ElementRef IN ('+@columns+')
	)PVT
	ORDER BY [Date]'
	EXEC (@sql)
END
GO


