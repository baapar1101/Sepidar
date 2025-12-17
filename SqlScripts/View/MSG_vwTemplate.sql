If Object_ID('MSG.vwTemplate') Is Not Null
	DROP VIEW MSG.vwTemplate
GO

CREATE VIEW [MSG].[vwTemplate]
AS
SELECT  TemplateID ,TemplateGUID,Title,Body,ShowOutgoingMessage,MessageParameterInfoFullName,
		FilterMedianOperator,IsSystemTemplate,TemplateVersion,
		[Version],Creator,CreationDate,
		LastModifier,LastModificationDate
FROM  MSG.[Template]