IF OBJECT_ID('MRP.vwManagementReportGrouping') IS NOT NULL
    DROP VIEW MRP.[vwManagementReportGrouping]
GO

CREATE VIEW [MRP].[vwManagementReportGrouping]
AS

SELECT
    [ManagementReportGroupingID],
    [ManagementReportStateRef],
    [RowNumber],
    [GroupingName],
    [Value],
    '' [PlaceHolder]
FROM MRP.ManagementReportGrouping

GO
