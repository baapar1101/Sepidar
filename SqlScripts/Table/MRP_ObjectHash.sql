IF OBJECT_ID('MRP.ObjectHash', 'U') IS NULL
CREATE TABLE MRP.ObjectHash(
    ObjectName      VARCHAR(100) NOT NULL,
    StartDate       Date NULL,
    EndDate         Date NULL,
    GatheringID     INT,
    BaseFactTableName  VARCHAR(100) NULL,
    [Hash]          BINARY(64)
)
GO
