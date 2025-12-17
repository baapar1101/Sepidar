IF OBJECT_ID('MSG.vwTemplateScheduling') IS NOT NULL
	DROP VIEW MSG.vwTemplateScheduling
GO

CREATE VIEW MSG.vwTemplateScheduling
AS
SELECT TemplateSchedulingID,TemplateRef,SchedulingRef,S.Title SchedulingTitle,
		S.StartDate SchedulingStartDate,S.EndDate SchedulingEndDate
FROM MSG.TemplateScheduling TS
	INNER JOIN SCD.Scheduling S ON S.SchedulingId = TS.SchedulingRef