IF OBJECT_ID('MRP.vwShredItemVersion', 'V') IS NOT NULL
    DROP VIEW MRP.vwShredItemVersion
GO

CREATE VIEW MRP.vwShredItemVersion
AS
    SELECT ShredItemID AS [ID], S.[Version], SI.UsanceDate AS [Date]
    FROM GNR.ShredItem SI
    INNER JOIN GNR.Shred S ON SI.ShredRef = S.ShredID
GO