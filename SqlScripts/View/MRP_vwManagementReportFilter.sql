IF OBJECT_ID('MRP.vwManagementReportFilter') IS NOT NULL
    DROP VIEW MRP.[vwManagementReportFilter]
GO

CREATE VIEW [MRP].[vwManagementReportFilter]
AS

SELECT
    [ManagementReportFilterID],
    [ManagementReportStateRef],
    [LogicalOperator],
    [ColumnName],
    [Operator],
    [PlaceHolder],
    [FilterDefinitionTitle] = ''
FROM MRP.ManagementReportFilter

GO
