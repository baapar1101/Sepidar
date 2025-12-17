IF Object_ID('WKO.vwProductOperation') IS NOT NULL
	Drop View WKO.vwProductOperation
GO

CREATE VIEW [WKO].[vwProductOperation]
AS
SELECT 
    PO.ProductOperationID,
    PO.ProductRef,
    I.Code AS ProductCode,
    I.Title AS ProductTitle,
    I.Title_En AS ProductTitle_En,
    PO.CustomerPartyRef,
    PDL.Code AS CustomerPartyDLCode,
    PDL.Title AS CustomerPartyDLTitle,
    PDL.Title_En AS CustomerPartyTitle_En,
    PO.Number,
    PO.[Date],
    PO.BaseProductOperationRef,
    BasePO.Number AS BaseProductOperationNumber,
    PO.Quantity,
    PO.FiscalYearRef,
    PO.BaseQuotationItemRef,
    PO.ItemUnitRef,
    U.Title AS ItemUnitTitle,
    U.Title_En AS ItemUnitTitle_En,
    QOT.Number AS BaseQuotationNumber,
    PO.AbstractProductOperationRef,
    APO.Title AS AbstractProductOperationTitle,
    APO.Code AS AbstractProductOperationCode,
    CASE WHEN EXISTS 
    (
        SELECT TOP 1 1 
        FROM WKO.ProductOperationItem POI
        JOIN WKO.ProductOrder POrder
            ON Porder.ProductOrderID = POI.ProductOrderRef
        WHERE POI.ProductOperationRef = PO.ProductOperationID 
    ) 
    THEN 1
    ELSE 0
    END AS ThereIsRelatedProductOrder,
    PO.Creator,
    PO.CreationDate,
    PO.LastModifier,
    PO.LastModificationDate,
    PO.Version

FROM WKO.ProductOperation PO
JOIN INV.Item I
    ON I.ItemID = PO.ProductRef
JOIN INV.Unit U
    ON U.UnitID = PO.ItemUnitRef
LEFT JOIN GNR.Party P 
    ON PO.CustomerPartyRef = P.PartyId 
LEFT JOIN ACC.DL AS PDL 
    ON P.DLRef = PDL.DLId 
LEFT JOIN WKO.ProductOperation BasePO
    ON BasePO.ProductOperationID = PO.BaseProductOperationRef
LEFT JOIN SLS.QuotationItem QIT 
    ON QIT.QuotationItemID = PO.BaseQuotationItemRef
LEFT JOIN SLS.Quotation QOT 
    ON QOT.QuotationID = QIT.QuotationRef
LEFT JOIN WKO.AbstractProductOperation APO
    ON APO.AbstractProductOperationID = PO.AbstractProductOperationRef
GO