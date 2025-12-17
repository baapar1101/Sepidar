IF OBJECT_ID('MRP.ObjectDependency', 'U') IS  NULL
CREATE TABLE MRP.ObjectDependency(
    FactTableName      VARCHAR(100) NOT NULL,
    DependentView   NVARCHAR(100) NOT NULL,
    DateBased       BIT DEFAULT 1 NOT NULL
)
GO
