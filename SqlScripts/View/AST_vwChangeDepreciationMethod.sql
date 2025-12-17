IF EXISTS (
		SELECT OBJECT_ID FROM sys.objects O WHERE   O.name LIKE 'vwChangeDepreciationMethod' 
												  AND O.schema_id = (
																	SELECT schema_id FROM sys.schemas sch WHERE sch.name LIKE 'AST'))
DROP VIEW AST.vwChangeDepreciationMethod
GO

CREATE VIEW AST.vwChangeDepreciationMethod
AS
	SELECT  
		 C.[ChangeDepreciationMethodId]
		,C.[Date]
		,C.[Number]
		,C.[AssetRef]
		,A.[PlaqueNumber]
		,A.[Title] As AssetTitle
		,A.[Title_En] As AssetTitle_En
		,C.[AssetTransactionRef]
		,C.[FiscalYearRef]
		,C.[Description]
		,C.[Description_En]
		,CST.[DepreciationMethodType]
		,CST.[DepreciationRate]
		,CST.[UsefulLife]
		,CST.[MaxDepreciableBookValue]
		,CST.[SalvageValue]
		,C.[Version]
		,C.[Creator]
		,C.[CreationDate]
		,C.[LastModifier]
		,C.[LastModificationDate]
		
		,u.Name AS CreatorName
		,u.Name_En AS CreatorName_En
	
	FROM  AST.ChangeDepreciationMethod C 
	LEFT JOIN AST.Asset A on C.AssetRef = A.AssetId
	LEFT JOIN AST.AssetTransaction at on at.AssetTransactionID = C.AssetTransactionRef
	LEFT JOIN AST.Asset AA on AA.AssetId = at.AssetRef
	LEFT JOIN AST.CostPart CST on CST.AssetRef = aa.AssetId AND CST.CostPartType = 1
	LEFT JOIN FMK.[User] u ON u.UserID = C.Creator