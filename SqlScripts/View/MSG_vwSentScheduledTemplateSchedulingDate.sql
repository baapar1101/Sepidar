If Object_ID('MSG.vwSentScheduledTemplateSchedulingDate') Is Not Null
	DROP View MSG.vwSentScheduledTemplateSchedulingDate
GO
CREATE VIEW [MSG].[vwSentScheduledTemplateSchedulingDate]
AS
SELECT  ST.SentScheduledTemplateSchedulingDateID,TS.TemplateRef,ST.TemplateSchedulingRef,ST.SchedulingItemRef
FROM  MSG.SentScheduledTemplateSchedulingDate ST
	INNER JOIN MSG.TemplateScheduling TS ON TS.TemplateSchedulingID = ST.TemplateSchedulingRef