IF OBJECT_ID('WKO.vwProductOrderBOMItem') IS NOT NULL
    DROP VIEW [WKO].[vwProductOrderBOMItem]
GO
CREATE VIEW [WKO].[vwProductOrderBOMItem]
AS
SELECT [POBOM].[ProductOrderBOMItemID],
       [POBOM].[ProductOrderRef],
       [POBOM].[ItemRef],
       [I].[Code] AS [ItemCode],
       [I].[Title] AS [ItemTitle],
       [I].[Title_En] AS [ItemTitle_En],
       [I].[UnitRef] AS [ItemUnitRef],
       [U].[Title] AS [ItemUnitTitle],
       [U].[Title_En] AS [ItemUnitTitle_En],
       [I].[UnitsRatio] AS [ItemUnitsRatio],
       [I].[IsUnitRatioConstant],
       [I].[TracingCategoryRef] AS [ItemTracingCategoryRef],
       [I].[SecondaryUnitRef] [ItemSecondaryUnitRef],
	   [I].[SerialTracking] AS [ItemSerialTracking],
       [POBOM].[FormulaBOMItemRef],
       ISNULL([ProductOrderBOMActualQuantity].[ActualQuantity], 0) AS [ActualConsumptionQuantity],
       [POBOM].[StandardConsumptionQuantity],
       [POBOM].[RemainingConsumptionQuantity],
       [POBOM].[Description],
       [FBI].[Quantity] AS [FomulaBOMItemQuantity],
       [RemainingBOMCost] = CAST(NULL AS [DECIMAL](19, 4)),
	   [POBOM].ItemTracingRef,
	   T.[Title] AS ItemTracingTitle,
       ISNULL([POBOM].[TransferedQuantity], 0) AS [TransferedQuantity],
       ISNULL([ProductOrderBOMActualQuantity].[RemainingRequestedQuantity], 0) AS [RemainingRequestedQuantity],
       ISNULL([ProductOrderBOMActualQuantity].[RegisteredRequestedQuantity], 0) AS [RegisteredRequestedQuantity]
FROM [WKO].[ProductOrderBOMItem] AS [POBOM]
    INNER JOIN [INV].[Item] AS [I]
        ON [I].[ItemID] = [POBOM].[ItemRef]
    INNER JOIN [INV].[Unit] AS [U]
        ON [U].[UnitID] = [I].[UnitRef]
    LEFT JOIN [WKO].[FormulaBomItem] AS [FBI]
        ON [POBOM].[FormulaBOMItemRef] = [FBI].[FormulaBomItemID]
	LEFT JOIN INV.Tracing AS T ON [POBOM].ItemTracingRef = T.TracingID
    LEFT JOIN
    (
        SELECT [ActualBOM].[ProductOrderBOMItemRef],
               SUM([ActualBOM].[BOMItemConsumptionQuantity]) [ActualQuantity],
               SUM([ActualBOM].[RemainingRequestedQuantity]) [RemainingRequestedQuantity],
               SUM([ActualBOM].[RegisteredRequestedQuantity]) [RegisteredRequestedQuantity]
        FROM [WKO].[vwProductOrderActualBOMConsumption] AS [ActualBOM]
        GROUP BY [ActualBOM].[ProductOrderBOMItemRef]
    ) AS [ProductOrderBOMActualQuantity]
        ON [ProductOrderBOMActualQuantity].[ProductOrderBOMItemRef] = [POBOM].[ProductOrderBOMItemID]
GO