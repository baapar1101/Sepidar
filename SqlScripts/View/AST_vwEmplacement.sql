If Object_ID('AST.vwEmplacement') Is Not Null
	Drop View AST.vwEmplacement
GO

CREATE VIEW AST.vwEmplacement
AS
SELECT 
		 C.[EmplacementId]
		,C.[Code]
		,C.[Title]
		,C.[Title_EN]
		,C.[ParentRef]
		,C.[Description]
		,C.[Description_EN]
		,C.[Code] + ' - ' + C.[Title] As FullTitle
		,C.[Code] + ' - ' + C.[Title_En] As FullTitle_En
		,C.[Code] + P.[Code] As FullCode
		,P.[Code] As ParentCode
		,P.[Title] As ParentTitle
		,P.[Title_En] As ParentTitle_En
		,C.[Version]
		,C.[Creator]
		,C.[CreationDate]
		,C.[LastModifier]
		,C.[LastModificationDate]
FROM AST.Emplacement C
	 LEFT Join AST.Emplacement P on C.ParentRef = P.EmplacementId

GO