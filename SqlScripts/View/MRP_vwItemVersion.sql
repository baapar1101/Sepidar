IF OBJECT_ID('MRP.vwItemVersion', 'V') IS NOT NULL
    DROP VIEW MRP.vwItemVersion
GO

CREATE VIEW MRP.vwItemVersion
AS
SELECT ItemID AS [ID]
      ,[Version]
FROM INV.[Item]
GO