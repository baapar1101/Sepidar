IF OBJECT_ID('MRP.vwManagementReportState') IS NOT NULL
    DROP VIEW MRP.[vwManagementReportState]
GO

CREATE VIEW [MRP].[vwManagementReportState]
AS

SELECT
    [ManagementReportStateID],
    [Title],
    [ReportGuid],
    [IsDefault],
    [FromDate],
    [ToDate],
    [RowCountLimit],
    [CalculationBasis],
    [ChartType],
    [Creator],
    [CreationDate],
    [LastModifier],
    [LastModificationDate],
    [Version]
FROM MRP.ManagementReportState

GO
