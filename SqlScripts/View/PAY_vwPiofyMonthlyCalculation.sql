IF OBJECT_ID('PAY.vwPiofyMonthlyCalculation') IS NOT NULL
	DROP VIEW PAY.vwPiofyMonthlyCalculation
GO
CREATE VIEW PAY.vwPiofyMonthlyCalculation
AS
	SELECT
		PMC.[PiofyMonthlyCalculationId]
		, PMC.[YMCode]
		, PMC.[EmployeeID]
		, PEM.[PersonnelCode] PersonnelCode
		, PEM.[PersonnelDLTitle] PersonnelDLTitle
		, PEM.[PesonnelDLTitle_En] PersonnelDLTitle_En
		, PEM.[PersonnelFirstName] PersonnelFirstName
		, PEM.[PersonnelFirstName_En] PersonnelFirstName_En
		, PEM.[PersonnelLastName] PersonnelLastName
		, PEM.[PersonnelLastName_En] PersonnelLastName_En
		, PMC.[FactorCode]
		, PAF.[Title] FactorTitle
		, PAF.[Title_En] FactorTitle_En
		, PAF.[MeasurementUnit] FactorMeasurementUnit
		, PMC.[DayValue]
		, PMC.[HourValue]
		, PMC.[MinuteValue]
		, PMC.[State]
		, PMC.[Version]
		, PMC.[Creator]
		, PMC.[CreationDate]
		, PMC.[LastModifier]
		, PMC.[LastModificationDate]
	FROM PAY.PiofyMonthlyCalculation PMC LEFT JOIN
		PAY.PiofyAttendanceFactor PAF ON PMC.[FactorCode] = PAF.[Code] LEFT JOIN
		GNR.vwPiofyEmployeeMapper PEM ON PMC.[EmployeeID] = PEM.[PiofyEmployeeID]
 