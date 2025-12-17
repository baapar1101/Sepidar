IF OBJECT_ID('WKO.vwFormulaBomItem') IS NOT NULL
    DROP VIEW [WKO].[vwFormulaBomItem]
GO
CREATE VIEW [WKO].[vwFormulaBomItem]
AS
SELECT [FBI].[FormulaBomItemID],
       [FBI].[ProductFormulaRef],
       [FBI].[ItemRef],
       [I].[Code] AS [ItemCode],
       [I].[Title] AS [ItemTitle],
       [I].[Title_En] AS [ItemTitle_En],
       [I].[UnitRef] AS [ItemUnitRef],
       [U].[Title] AS [ItemUnitTitle],
       [U].[Title_En] AS [ItemUnitTitle_En],
       [I].[SecondaryUnitRef] AS [ItemSecondaryUnitRef],
       [I].[UnitsRatio],
       [SU].[Title] AS [ItemSecondaryUnitTitle],
       [I].[IsUnitRatioConstant],
       [I].[TracingCategoryRef] AS [ItemTracingCategoryRef],
       [I].[SerialTracking] AS [ItemSerialTracking],
       [FBI].[Quantity],
       [FBI].[SecondaryQuantity],
       [FBI].[Description],
	   [FBI].ItemTracingRef,
	   T.[Title] AS ItemTracingTitle,
       CAST(0 AS BIT) AS [HasOpenPurchaseRequest]
FROM [WKO].[FormulaBomItem] AS [FBI]
    INNER JOIN [INV].[Item] AS [I]
        ON [FBI].[ItemRef] = [I].[ItemID]
    INNER JOIN [INV].[Unit] AS [U]
        ON [I].[UnitRef] = [U].[UnitID]
    LEFT JOIN [INV].[Unit] AS [SU]
        ON [I].[SecondaryUnitRef] = [SU].[UnitID]
	LEFT JOIN INV.Tracing AS T ON [FBI].ItemTracingRef = T.TracingID

GO