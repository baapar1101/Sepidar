IF OBJECT_ID('DST.vwHotDistributionItem') IS NOT NULL
	DROP VIEW DST.vwHotDistributionItem
GO

CREATE VIEW DST.vwHotDistributionItem
AS
SELECT
	HDI.[HotDistributionItemId]
   ,HDI.[HotDistributionRef]
   ,HDI.[ItemRef]
   ,I.[Code]							AS [ItemCode]
   ,I.[Title] 							AS [ItemTitle]
   ,I.[Title_En]						AS [ItemTitle_En]
   ,I.[UnitRef]
   ,U1.[Title]							AS [UnitTitle]
   ,U1.[Title_En]						AS [UnitTitle_En]
   ,I.[SecondaryUnitRef]
   ,U2.[Title]							AS [SecondaryUnitTitle]
   ,U2.[Title_En]						AS [SecondaryUnitTitle_En]
   ,I.[IsUnitRatioConstant]
   ,I.[UnitsRatio]
   ,CASE WHEN I.[TracingCategoryRef] IS NULL THEN 0 ELSE 1 END AS [ItemHasTracing]
   ,HDI.TracingRef
   ,T.Title 							AS [TracingTitle]
   ,ISNULL(HDI.[Quantity] ,0) AS [Quantity]
   ,HDI.[SecondaryQuantity] 
   ,ISNULL(I.[Weight], 0)				AS [ItemWeight]
   ,ISNULL(I.[Volume], 0)				AS [ItemVolume]
   , ISNULL(HDI.[Quantity] ,0) * [I].[Weight]	AS [TotalWeight]
   , ISNULL(HDI.[Quantity] ,0) * [I].[Volume]	AS [TotalVolume]
   ,[HDI].[InputQuantity]
   ,[HDI].[TransferQuantity]
   ,[HDI].[InputSecondaryQuantity]
   ,[HDI].[TransferSecondaryQuantity]
FROM DST.HotDistributionItem AS HDI
	INNER JOIN INV.Item AS I
		ON HDI.ItemRef = I.ItemID
	LEFT JOIN INV.Tracing T
		ON T.TracingID = HDI.TracingRef
	LEFT OUTER JOIN INV.Unit AS U1
		ON I.UnitRef = U1.UnitID
	LEFT OUTER JOIN INV.Unit AS U2
		ON I.SecondaryUnitRef = U2.UnitID 

	