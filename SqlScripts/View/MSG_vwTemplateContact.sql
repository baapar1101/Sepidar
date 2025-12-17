
IF OBJECT_ID('MSG.vwTemplateContact') IS NOT NULL
	DROP VIEW MSG.vwTemplateContact
GO

CREATE VIEW [MSG].[vwTemplateContact]
AS
SELECT  TemplateContactID,TemplateRef,Phone,ContactPhoneRef,ContactType,ParameterName
FROM  MSG.[TemplateContact]