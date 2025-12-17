IF EXISTS (
		SELECT OBJECT_ID FROM sys.objects O WHERE   O.name LIKE 'vwAssetClass' 
												  AND O.schema_id = (
																	SELECT schema_id FROM sys.schemas sch WHERE sch.name LIKE 'AST'))
DROP VIEW AST.vwAssetClass
GO

CREATE VIEW AST.vwAssetClass
AS(
	SELECT	 AC.[AssetClassID]
			,AC.[Code]
			,AC.[Code] AS  FullCode
			,AC.[Title]
			,AC.[Title_En]
			,AC.[AssetSLRef]
			,ACCAS.FullCode  AS AssetSLCode
			,ACCAS.[Title]	AS AssetSLTitle
			,ACCAS.[Title_En] AS AssetSLTitle_En
			,AC.[DepreciationSLRef]
			,ACCDep.FullCode  AS DepreciationSLCode
			,ACCDep.[Title]	AS DepreciationSLTitle
			,ACCDep.[Title_En] AS DepreciationSLTitle_En
			,AC.[AccumulatedDepreciationSLRef]
			,ACCAD.FullCode  AS AccumulatedDepreciationSLCode
			,ACCAD.[Title]	AS AccumulatedDepreciationSLTitle
			,ACCAD.[Title_En] AS AccumulatedDepreciationSLTitle_En
			,AC.[AssetClassRef]
			,AC.[Version]
			,AC.[Creator]
			,AC.[CreationDate]
			,AC.[LastModifier]
			,AC.[LastModificationDate]	
	FROM AST.[AssetClass] AC
		LEFT JOIN ACC.[vwAccount] ACCAS
		ON AC.[AssetSLRef] = ACCAS.AccountId
		LEFT JOIN ACC.[vwAccount] ACCDep
		ON AC.[DepreciationSLRef] = ACCDep.AccountId
		LEFT JOIN ACC.[vwAccount] ACCAD
		ON AC.[AccumulatedDepreciationSLRef] = ACCAD.AccountId
		
)
GO
