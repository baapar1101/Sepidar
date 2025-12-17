IF Object_ID('WKO.vwProductOperationItem') IS NOT NULL
	Drop View WKO.vwProductOperationItem
GO

CREATE VIEW [WKO].[vwProductOperationItem]
AS
SELECT 
    POI.ProductOperationItemID,
    POI.ProductOperationRef,
    POI.ParentProductOperationItemRef,
    POI.ProductFormulaRef,
    F.Code AS ProductFormulaCode,
    F.Title AS ProductFormulaTitle,
    POI.ProductFormulaUnitRef,
    FormulaUnit.Title AS ProductFormulaUnitTitle,
    FormulaUnit.Title_En AS ProductFormulaUnitTitle_En,
    POI.CostCenterRef,
    CC.DLRef AS CostCenterDLRef,
    CDL.Title AS CostCenterDLTitle,
    CDL.Title_En AS CostCenterDLTitle_En,
    CDL.Code AS CostCenterDLCode,
    POI.RequiredProductionQuantity,
    POI.ActualFormulaQuantity,
    ISNULL(ISS.StockQuantity, 0) AS StockQuantity,
    POI.ProductRef,
    I.Code AS ProductCode,
    I.Title AS ProductTitle,
    I.Title_En AS ProductTitle_En,
    I.TracingCategoryRef,
    POI.IsAddedManually,
    POI.FormulaBOMItemRef,
    POI.ProductOrderRef,
    POrder.[State] AS RelatedProductOrderState,
    POrder.Number AS ProductOrderNumber,
    POI.ActualFormulaQuantityUnitRef,
    ActualQuantityUnit.Title AS ActualFormulaQuantityUnitTitle,
    ActualQuantityUnit.Title_En AS ActualFormulaQuantityUnitTitle_En,
    POI.BaseProductOrderRef,
    BPO.Number AS BaseProductOrderNumber,
    BPO.CanTransferNextPeriod AS BaseProductOrderCanTransferNextYear,
    ISNULL(FBI.Quantity / ParentFormula.Quantity, 1) AS ProportionToParent,
    ISNULL(ReservedByProdcutOrder.PoReservedQuantity, 0) AS ProductOrderReservedBOMItem,
    F.TracingTitle AS FormulaHeaderTracingTitle,
    FBI.ItemTracingRef AS FormulaItemTracingRef,
    FormulaItemTracing.Title AS FormulaItemTracingTitle

FROM WKO.ProductOperationItem POI
JOIN WKO.ProductOperation PO
    ON PO.ProductOperationID = POI.ProductOperationRef
JOIN INV.Item I
    ON I.ItemID = POI.ProductRef
JOIN INV.Unit ActualQuantityUnit
    ON ActualQuantityUnit.UnitID = POI.ActualFormulaQuantityUnitRef
LEFT JOIN WKO.ProductFormula F
    ON F.ProductFormulaID = POI.ProductFormulaRef
LEFT JOIN INV.Unit UF
    ON UF.UnitID = F.ItemUnitRef
LEFT JOIN GNR.CostCenter CC 
    ON CC.CostCenterId = POI.CostCenterRef
LEFT JOIN ACC.DL CDL
    ON CDL.DLId = CC.DLRef
LEFT JOIN (
    SELECT ISS.ItemRef, ISS.FiscalYearRef, SUM(Quantity) AS StockQuantity 
    FROM INV.ItemStockSummary ISS
    WHERE [Order] = 1
    GROUP BY ISS.ItemRef, ISS.FiscalYearRef
) AS ISS
    ON ISS.ItemRef = POI.ProductRef AND ISS.FiscalYearRef = PO.FiscalYearRef
LEFT JOIN WKO.ProductOrder POrder
    ON POrder.ProductOrderID = POI.ProductOrderRef
LEFT JOIN INV.Unit FormulaUnit
    ON FormulaUnit.UnitID = POI.ProductFormulaUnitRef
LEFT JOIN WKO.ProductOrder BPO
    ON BPO.ProductOrderId = POI.BaseProductOrderRef
LEFT JOIN WKO.FormulaBomItem FBI
    ON FBI.FormulaBomItemID = POI.FormulaBOMItemRef
LEFT JOIN WKO.ProductFormula ParentFormula
    ON ParentFormula.ProductFormulaID = FBI.ProductFormulaRef
LEFT JOIN (
    SELECT 
        I.ItemID,
        CONVERT([decimal](19,4),
            SUM(POBI.StandardConsumptionQuantity) 
            - SUM(POBI.ActualConsumptionQuantity)
            - SUM(POBI.TransferedQuantity)
        ) AS PoReservedQuantity
    FROM INV.Item I
    INNER JOIN WKO.vwProductOrderBOMItem POBI 
        ON POBI.ItemRef = I.ItemID
    INNER JOIN WKO.ProductOrder PO 
        ON PO.ProductOrderID = POBI.ProductOrderRef
    WHERE PO.[State] IN (0, 1) --           ProductOrderState.None , ProductOrderState.UnderProduction;  
    GROUP BY I.ItemID
) AS ReservedByProdcutOrder
    ON ReservedByProdcutOrder.ItemID = POI.ProductRef

LEFT JOIN INV.Tracing FormulaItemTracing
    ON FormulaItemTracing.TracingID = FBI.ItemTracingRef
GO


