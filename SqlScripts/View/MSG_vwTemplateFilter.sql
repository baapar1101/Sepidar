If Object_ID('MSG.vwTemplateFilter') Is Not Null
	Drop View MSG.vwTemplateFilter
GO
CREATE VIEW [MSG].[vwTemplateFilter]
AS
SELECT  TemplateFilterID,TemplateRef,ParameterName,
	FilterCondition,Value,Operator
FROM  MSG.[TemplateFilter]