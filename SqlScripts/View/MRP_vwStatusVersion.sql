IF OBJECT_ID('MRP.vwStatusVersion', 'V') IS NOT NULL
    DROP VIEW MRP.vwStatusVersion
GO

CREATE VIEW MRP.vwStatusVersion
AS
    SELECT StatusId AS [ID], [Version], [Date]
    FROM CNT.Status
GO