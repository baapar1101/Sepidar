IF OBJECT_ID('PAY.vwPiofyAttendanceFactorMapper') IS NOT NULL
	DROP VIEW PAY.vwPiofyAttendanceFactorMapper
GO
CREATE VIEW PAY.vwPiofyAttendanceFactorMapper
AS
	SELECT
		AFM.[PiofyAttendanceFactorMapperId]
		, AFM.[ElementRef]
		, E.[Title] ElementTitle
		, E.[Title_En] ElementTitle_En
		, E.[Class] ElementClass
		, E.[Type] ElementType
		, E.[IsActive] ElementIsActive
		, E.[DisplayOrder] ElementDisplayOrder
		, AFM.[PiofyAttendanceFactorRef]
		, AF.[Code] PiofyAttendanceFactorCode
		, AF.[Title] PiofyAttendanceFactorTitle
		, AF.[Title_En] PiofyAttendanceFactorTitle_En
		, AF.[MeasurementUnit] PiofyAttendanceFactorMeasurementUnit
		, AFM.[Version]
		, AFM.[Creator]
		, AFM.[CreationDate]
		, AFM.[LastModifier]
		, AFM.[LastModificationDate]
	FROM PAY.PiofyAttendanceFactorMapper AFM
		LEFT JOIN PAY.Element E ON AFM.ElementRef = E.ElementId
		LEFT JOIN PAY.PiofyAttendanceFactor AF ON AFM.PiofyAttendanceFactorRef = AF.PiofyAttendanceFactorId

 


 