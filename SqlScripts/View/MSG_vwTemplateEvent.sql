If Object_ID('MSG.vwTemplateEvent') Is Not Null
	Drop View MSG.vwTemplateEvent
GO
CREATE VIEW [MSG].[vwTemplateEvent]
AS
SELECT  [TemplateEventID],[TemplateRef],[EventKey]
FROM  MSG.[TemplateEvent]