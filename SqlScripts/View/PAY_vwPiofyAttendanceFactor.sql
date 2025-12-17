IF OBJECT_ID('PAY.vwPiofyAttendanceFactor') IS NOT NULL
	DROP VIEW PAY.vwPiofyAttendanceFactor
GO
CREATE VIEW PAY.vwPiofyAttendanceFactor
AS
	SELECT
		AF.[PiofyAttendanceFactorId]
		, AF.[Code]
		, AF.[Title]
		, AF.[Title_En]
		, AF.[MeasurementUnit]
		, AF.[Version]
		, AF.[Creator]
		, AF.[CreationDate]
		, AF.[LastModifier]
		, AF.[LastModificationDate]
	FROM PAY.PiofyAttendanceFactor AF

 


 