IF Object_ID('DST.vwUnexecutedActReason') IS NOT NULL
	DROP VIEW DST.vwUnexecutedActReason
GO

CREATE VIEW DST.vwUnexecutedActReason
AS

SELECT
	U.[UnexecutedActReasonId]
	,U.[Title]					
	,U.[Title_En]					
	,U.[IsActive]					
	,U.[Version]					
	,U.[Creator]					
	,U.[CreationDate]				
	,U.[LastModifier]				
	,U.[LastModificationDate]
	,U.[CanUseInOrder]
	,U.[CanUseInDebtCollectionList]
	,U.[CanUseInHotDistribution]
	,U.[CanUseInColdDistribution]
	,U.[CheckLocation]
	,CU.Name CreatorName
    ,MU.Name LastModifierName	
FROM
	[DST].[UnexecutedActReason] U
    INNER JOIN FMk.[User] CU ON U.Creator = CU.UserID
    INNER JOIN FMk.[User] MU ON U.LastModifier = MU.UserID
