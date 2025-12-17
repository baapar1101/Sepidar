IF Object_ID('WKO.vwAbstractProductOperation') IS NOT NULL
	Drop View WKO.vwAbstractProductOperation
GO

CREATE VIEW [WKO].[vwAbstractProductOperation]
AS
SELECT 
    APO.AbstractProductOperationID,
    APO.ProductRef,
    I.Code AS ProductCode,
    I.Title AS ProductTitle,
    I.Title_En AS ProductTitle_En,
    APO.Code,
    APO.Title,
    APO.Quantity,
    APO.IsActive,
    APO.Creator,
    APO.CreationDate,
    APO.LastModifier,
    APO.LastModificationDate,
    APO.Version

FROM WKO.AbstractProductOperation APO
JOIN INV.Item I
    ON I.ItemID = APO.ProductRef
GO