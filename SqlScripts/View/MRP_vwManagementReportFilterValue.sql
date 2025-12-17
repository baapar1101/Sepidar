IF OBJECT_ID('MRP.vwManagementReportFilterValue') IS NOT NULL
    DROP VIEW MRP.[vwManagementReportFilterValue]
GO

CREATE VIEW [MRP].[vwManagementReportFilterValue]
AS

SELECT
    [ManagementReportFilterValueID],
    [ManagementReportFilterRef],
    [StringValue],
    [IntValue],
    [DecimalValue],
    [BitValue],
    [DatetimeValue]
FROM [MRP].[ManagementReportFilterValue]

GO
