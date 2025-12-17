IF OBJECT_ID('SCD.vwScheduling') IS NOT NULL
	DROP VIEW SCD.vwScheduling
GO
CREATE VIEW SCD.vwScheduling
AS
SELECT  SchedulingId,Title,IsActive,StartDate,EndDate,
		(CASE 
			WHEN SchedulingId < 0 THEN 1
			ELSE 0
		 END) IsDefaultScheduling,
		[Version],Creator,CreationDate,LastModifier,LastModificationDate
FROM SCD.Scheduling