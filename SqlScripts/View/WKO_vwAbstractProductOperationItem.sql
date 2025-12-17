IF Object_ID('WKO.vwAbstractProductOperationItem') IS NOT NULL
	Drop View WKO.vwAbstractProductOperationItem
GO

CREATE VIEW [WKO].[vwAbstractProductOperationItem]
AS
SELECT 
    APOI.AbstractProductOperationItemID,
    APOI.AbstractProductOperationRef,
    APOI.ParentAbstractProductOperationItemRef,
    APOI.ProductFormulaRef,
    F.Code AS ProductFormulaCode,
    F.Title AS ProductFormulaTitle,
    F.CostCenterRef,
    F.CostCenterDLRef,
    F.CostCenterDLCode,
    F.CostCenterDLTitle,
    F.CostCenterDLTitle_En,
    APOI.ProductFormulaUnitRef,
    FormulaUnit.Title AS ProductFormulaUnitTitle,
    FormulaUnit.Title_En AS ProductFormulaUnitTitle_En,
    APOI.RequiredProductionQuantity,
    APOI.ProductRef,
    I.Code AS ProductCode,
    I.Title AS ProductTitle,
    I.Title_En AS ProductTitle_En,
    I.TracingCategoryRef,
    APOI.FormulaBOMItemRef,
    APOI.ActualFormulaQuantity,
    APOI.ActualFormulaQuantityUnitRef,
    ActualQuantityUnit.Title AS ActualFormulaQuantityUnitTitle,
    ActualQuantityUnit.Title_En AS ActualFormulaQuantityUnitTitle_En,
    ActualQuantitySecondaryUnit.UnitID AS ActualQuantitySecondaryUnitRef,
    ActualQuantitySecondaryUnit.Title AS ActualQuantitySecondaryUnitTitle,
    ActualQuantitySecondaryUnit.Title_En AS ActualQuantitySecondaryUnitTitle_En,
    I.UnitsRatio AS ItemUnitsRatio,
    I.IsUnitRatioConstant AS IsItemUnitRatioConstant,
    CAST(0 AS BIT) AS HasOpenPurchaseRequest,
    F.TracingTitle AS FormulaHeaderTracingTitle,
    FBI.ItemTracingRef AS FormulaItemTracingRef,
    FormulaItemTracing.Title AS FormulaItemTracingTitle
    

FROM WKO.AbstractProductOperationItem APOI
JOIN WKO.AbstractProductOperation APO
    ON APO.AbstractProductOperationID = APOI.AbstractProductOperationRef
JOIN INV.Item I
    ON I.ItemID = APOI.ProductRef
JOIN INV.Unit ActualQuantityUnit
    ON ActualQuantityUnit.UnitID = APOI.ActualFormulaQuantityUnitRef
LEFT JOIN INV.Unit ActualQuantitySecondaryUnit
    ON ActualQuantitySecondaryUnit.UnitID = I.SecondaryUnitRef
LEFT JOIN WKO.vwProductFormula F
    ON F.ProductFormulaID = APOI.ProductFormulaRef
LEFT JOIN INV.Unit UF
    ON UF.UnitID = F.ItemUnitRef
LEFT JOIN INV.Unit FormulaUnit
    ON FormulaUnit.UnitID = APOI.ProductFormulaUnitRef
LEFT JOIN WKO.FormulaBomItem FBI
    ON FBI.FormulaBomItemID = APOI.FormulaBOMItemRef
LEFT JOIN INV.Tracing FormulaItemTracing
    ON FormulaItemTracing.TracingID = FBI.ItemTracingRef

GO