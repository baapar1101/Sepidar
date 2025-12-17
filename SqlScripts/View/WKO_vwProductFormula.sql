IF Object_ID('WKO.vwProductFormula') IS NOT NULL
	Drop View WKO.vwProductFormula
GO

CREATE VIEW [WKO].[vwProductFormula]
AS
	SELECT  PF.ProductFormulaID,PF.Code, PF.Title,
			PF.ItemRef, I.Code ItemCode, I.Title ItemTitle,
			I.Title_En ItemTitle_En, PF.ItemUnitRef, U.Title ItemUnitTitle,
			U.Title_En ItemUnitTitle_En, PF.Quantity, PF.IsActive,
			PF.EstimatedLabour, PF.EstimatedOverhead, PF.BaseProductFormula, PF.Creator,
			PF.CreationDate, PF.LastModifier, PF.LastModificationDate, PF.[Version],
			PF.[CostCenterRef] ,CC.DLRef CostCenterDLRef,DL.Title AS CostCenterDLTitle, DL.Title_En AS CostCenterDLTitle_En,DL.Code AS CostCenterDLCode,
            CASE WHEN I.UnitRef = PF.ItemUnitRef THEN 1 ELSE 0 END AS IsBasedOnMainUnit,
            CASE WHEN I.UnitRef = PF.ItemUnitRef THEN 1 ELSE I.UnitsRatio END AS RatioToMainUnit,
			PF.Description,PF.TracingTitle,I.TracingCategoryRef

	FROM WKO.ProductFormula PF
		INNER JOIN INV.Item I ON PF.ItemRef = I.ItemID
		INNER JOIN INV.Unit U ON PF.ItemUnitRef = U.UnitID
		LEFT JOIN GNR.CostCenter CC ON CC.CostCenterId = PF.CostCenterRef		
		LEFT JOIN ACC.DL AS DL ON CC.DLRef = DL.DLId
GO