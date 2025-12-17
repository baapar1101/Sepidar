IF EXISTS (
		SELECT *,OBJECT_ID FROM sys.objects O WHERE   O.name LIKE 'vwAssetGroup' 
												  AND O.schema_id = (
																	SELECT schema_id FROM sys.schemas sch WHERE sch.name LIKE 'AST'))
DROP VIEW AST.vwAssetGroup
GO

CREATE VIEW AST.vwAssetGroup
AS(
	SELECT	AG.[AssetGroupID]
			,AG.[Code]
			,AC.[Code] + AG.[Code] AS FullCode
			,AG.[Title]
			,AG.[Title_En]
			,AG.[DepreciationRate]
			,AG.[UsefulLife]
			,AG.[DepreciationMethod]
			,AG.[SalvageValue]
			,AG.[AssetClassRef]
			,AC.[Code] AS ClassCode
			,AC.[Title] AS ClassTitle 
			,AC.[Title_En] AS ClassTitle_En
			,AC.[AccumulatedDepreciationSLRef]			 
			,AC.[DepreciationSLRef]			 
			,AG.[MaxDepreciableBookValue]
			,AG.[Version]
			,AG.[Creator]
			,AG.[CreationDate] 
			,AG.[LastModifier] 
			,AG.[LastModificationDate]	
	FROM AST.AssetGroup AG
		INNER JOIN AST.AssetClass AC 
		ON AG.[AssetClassRef] = AC.[AssetClassID]
)
