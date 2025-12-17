UPDATE WKO.ProductOrder
SET ProductFormulaUnitRef =
(
    SELECT TOP 1 PF.ItemUnitRef
    FROM WKO.ProductFormula PF
    WHERE PF.ProductFormulaID = WKO.ProductOrder.ProductFormulaRef
)
WHERE ProductFormulaUnitRef IS NULL