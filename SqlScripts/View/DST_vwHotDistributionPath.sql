IF OBJECT_ID('DST.vwHotDistributionPath') IS NOT NULL
	DROP VIEW DST.vwHotDistributionPath
GO

CREATE VIEW DST.vwHotDistributionPath
AS

SELECT 
	HDP.[HotDistributionPathId]
	, HDP.[HotDistributionRef]
	, HDP.[PathRef]
	, [AAP].[FullCode]	AS [PathCode]
	, [AAP].[Title]		AS [PathTitle]
	, [AAP].[Title_En]	AS [PathTitle_En]
FROM 
	DST.HotDistributionPath AS HDP
		JOIN [DST].[vwAreaAndPath] AS [AAP] ON [HDP].[PathRef] = [AAP].[AreaAndPathId]

