
IF EXISTS (
		SELECT *,OBJECT_ID FROM sys.objects O WHERE   O.name LIKE 'vwDepreciationRule' 
												  AND O.schema_id = (
																	SELECT schema_id FROM sys.schemas sch WHERE sch.name LIKE 'AST'))
DROP VIEW AST.vwDepreciationRule
GO

CREATE VIEW AST.vwDepreciationRule
AS(
	SELECT	 DR.[DepreciationRuleID]		 
			,DR.[GroupNo]					 
			,DR.[GroupTitle]				 
			,DR.[UsefulLife]				 
			,DR.[DepreciationRate]			 
			,DR.[DepreciationMethod]		 
			,DR.[Description]				 
			,DR.[Version]					 
			,DR.[Creator]					 
			,DR.[CreationDate]				 
			,DR.[LastModifier]				 
		 	,DR.[LastModificationDate]		 
	FROM AST.DepreciationRule DR
		 
) 
