IF Object_ID('DST.vwAreaAndPath') IS NOT NULL
	DROP VIEW DST.vwAreaAndPath
GO

CREATE VIEW DST.vwAreaAndPath
AS

SELECT 
	S.[AreaAndPathId]
	, S.[ParentAreaAndPathRef]
	, S.[Type]
	, S.[Code]
	, S.[Title]
	, S.[Title_En]
	, S.[IsActive]
	, S.[AreaCode]
	, S.[AreaTitle]
	, S.[AreaTitle_En]
	, CASE S.[Type] 
			WHEN 1 THEN S.[Code]
			WHEN 2 THEN (S.[AreaCode] + S.[Code])
		END AS FullCode
	, S.[Version]
	, S.[Creator]
	, S.[CreationDate]
	, S.[LastModifier]
	, S.[LastModificationDate]
FROM 
	(SELECT 
		A.[AreaAndPathId]
		, A.[ParentAreaAndPathRef]
		, A.[Type]
		, A.[Code]
		, A.[Title]
		, A.[Title_En]
		, A.[IsActive]
		, A.[Version]
		, A.[Creator]
		, A.[CreationDate]
		, A.[LastModifier]
		, A.[LastModificationDate]
		, (SELECT A1.[Code] FROM DST.[AreaAndPath] A1 WHERE A.[ParentAreaAndPathRef] = A1.[AreaAndPathId] AND A.[Type] = 2) AS AreaCode
		, (SELECT A1.[Title] FROM DST.[AreaAndPath] A1 WHERE A.[ParentAreaAndPathRef] = A1.[AreaAndPathId] AND A.[Type] = 2) AS AreaTitle
		, (SELECT A1.[Title_En] FROM DST.[AreaAndPath] A1 WHERE A.[ParentAreaAndPathRef] = A1.AreaAndPathId AND A.[Type] = 2) AS AreaTitle_En
	FROM DST.AreaAndPath AS A) AS S


