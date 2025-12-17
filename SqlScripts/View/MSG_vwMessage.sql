If Object_ID('MSG.vwMessage') IS NOT NULL
	DROP VIEW MSG.vwMessage
GO
CREATE VIEW [MSG].[vwMessage]
AS
SELECT  M.MessageID,M.Body,M.[Date],M.TemplateRef,M.IsDraft,T.Title TemplateTitle,T.MessageParameterInfoFullName,
	M.[Version],M.Creator,M.CreationDate,M.LastModifier,M.LastModificationDate
FROM  MSG.[Message] M
	LEFT OUTER JOIN MSG.Template T ON T.TemplateID = M.TemplateRef