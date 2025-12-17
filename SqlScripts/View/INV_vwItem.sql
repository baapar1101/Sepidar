IF OBJECT_ID('INV.vwItem') IS NOT NULL
	DROP VIEW INV.vwItem
GO
CREATE VIEW INV.vwItem
AS
SELECT
	I.ItemID
   ,I.Type
   ,I.Code
   ,I.Title
   ,I.Title_En
   ,I.BarCode
   ,I.UnitRef
   ,u1.Title AS UnitTitle
   ,u1.Title_En AS UnitTitle_En
   ,I.SecondaryUnitRef
   ,u2.Title AS SecondaryUnitTitle
   ,u2.Title_En AS SecondaryUnitTitle_En
   ,I.SaleUnitRef
   ,I.IsUnitRatioConstant
   ,I.UnitsRatio
   ,I.MinimumAmount
   ,I.MaximumAmount
   ,I.CanHaveTracing
   ,I.TracingCategoryRef
   ,tc.Title AS TracingCategoryTitle
   ,tc.Title_En AS TracingCategoryTitle_En
   ,I.IsPricingBasedOnTracing
   ,I.TaxExempt
   ,I.TaxExemptPurchase
   ,I.Sellable
   ,I.DefaultStockRef
   ,I.Creator
   ,I.CreationDate
   ,I.LastModifier
   ,I.Version
   ,I.LastModificationDate
   ,I.IranCode
   ,I.PurchaseGroupRef
   ,GR1.fullCode AS PurchaseGroupCode
   ,GR1.Title AS PurchaseGroupTitle
   ,GR1.Title_En AS PurchaseGroupTitle_En
   ,GR1.CalculationFormulaRef AS PurchaseFormulaRef
   ,I.SaleGroupRef
   ,GR2.fullCode AS SaleGroupCode
   ,GR2.Title AS SaleGroupTitle
   ,GR2.Title_En AS SaleGroupTitle_En
   ,GR2.CalculationFormulaRef AS SaleFormulaRef
   ,I.CompoundBarcodeRef
   ,I.TaxRate
   ,I.DutyRate
   ,CB.Code AS CompoundBarcodeCode
   ,CB.Title AS CompoundBarcodeTitle
   ,CB.ItemIdentifier AS CompoundBarcodeItemIdentifier
   ,CB.TracingStart AS CompoundBarcodeTracingStart
   ,I.ItemCategoryRef
   ,IC.Code AS ItemCategoryCode
   ,IC.Title AS ItemCategoryTitle
   ,I.IsActive
   ,INV.Stock.Code AS DefaultStockCode
   ,INV.Stock.Title AS DefaultStockTitle
   ,INV.Stock.Title_En AS DefaultStockTitle_En
   ,I.AccountSLRef
   ,ACC.Title AS AccountSLTitle
   ,ACC.Title_En AS AccountSLTitle_En
   ,I.CodingGroupRef
   ,g.FullCode AS CodingGroupCode
   ,g.Title AS CodingGroupTitle
   ,g.Title_En AS CodingGroupTitle_En
   ,I.SerialTracking
   ,I.Weight
   ,I.Volume
   ,I.ConsumerFee
   ,IPA.PropertyAmount1
   ,IPA.PropertyAmount2
   ,IPA.PropertyAmount3
   ,IPA.PropertyAmount4
   ,IPA.PropertyAmount5
   ,IPA.PropertyAmount6
   ,IPA.PropertyAmount7
   ,IPA.PropertyAmount8
   ,IPA.PropertyAmount9
   ,IPA.PropertyAmount10
   ,PropertyAmounts =
	CASE
		WHEN IPA.PropertyAmount1 = '' THEN ''
		WHEN IPA.PropertyAmount1 IS NULL THEN ''
		ELSE IPA.PropertyAmount1 + ' '
	END
	+
	CASE
		WHEN IPA.PropertyAmount2 = '' THEN ''
		WHEN IPA.PropertyAmount2 IS NULL THEN ''
		ELSE IPA.PropertyAmount2 + ' '
	END
	+
	CASE
		WHEN IPA.PropertyAmount3 = '' THEN ''
		WHEN IPA.PropertyAmount3 IS NULL THEN ''
		ELSE IPA.PropertyAmount3 + ' '
	END
	+
	CASE
		WHEN IPA.PropertyAmount4 = '' THEN ''
		WHEN IPA.PropertyAmount4 IS NULL THEN ''
		ELSE IPA.PropertyAmount4 + ' '
	END
	+
	CASE
		WHEN IPA.PropertyAmount5 = '' THEN ''
		WHEN IPA.PropertyAmount5 IS NULL THEN ''
		ELSE IPA.PropertyAmount5 + ' '
	END
	+
	CASE
		WHEN IPA.PropertyAmount6 = '' THEN ''
		WHEN IPA.PropertyAmount6 IS NULL THEN ''
		ELSE IPA.PropertyAmount6 + ' '
	END
	+
	CASE
		WHEN IPA.PropertyAmount7 = '' THEN ''
		WHEN IPA.PropertyAmount7 IS NULL THEN ''
		ELSE IPA.PropertyAmount7 + ' '
	END
	+
	CASE
		WHEN IPA.PropertyAmount8 = '' THEN ''
		WHEN IPA.PropertyAmount8 IS NULL THEN ''
		ELSE IPA.PropertyAmount8 + ' '
	END
	+
	CASE
		WHEN IPA.PropertyAmount9 = '' THEN ''
		WHEN IPA.PropertyAmount9 IS NULL THEN ''
		ELSE IPA.PropertyAmount9 + ' '
	END
	+
	CASE
		WHEN IPA.PropertyAmount10 = '' THEN ''
		WHEN IPA.PropertyAmount10 IS NULL THEN ''
		ELSE IPA.PropertyAmount10 + ' '
	END


FROM INV.Item AS I
LEFT OUTER JOIN INV.Stock
	ON I.DefaultStockRef = INV.Stock.StockID
LEFT OUTER JOIN INV.Unit AS u1
	ON I.UnitRef = u1.UnitID
LEFT OUTER JOIN INV.TracingCategory tc
	ON I.TracingCategoryRef = tc.TracingCategoryID
LEFT OUTER JOIN INV.Unit AS u2
	ON I.SecondaryUnitRef = u2.UnitID
LEFT OUTER JOIN ACC.Account ACC
	ON ACC.AccountId = I.AccountSLRef
LEFT JOIN GNR.[vwGrouping] GR1
	ON I.PurchaseGroupRef = GR1.GroupingID
LEFT JOIN GNR.[vwGrouping] GR2
	ON I.SaleGroupRef = GR2.GroupingID
LEFT JOIN INV.CompoundBarcode CB
	ON I.CompoundBarcodeRef = CB.CompoundBarcodeID
LEFT JOIN INV.ItemCategory IC
	ON I.ItemCategoryRef = IC.ItemCategoryID
LEFT JOIN Gnr.vwGrouping g
	ON g.GroupingId = I.CodingGroupRef
LEFT JOIN INV.ItemPropertyAmount IPA
	ON IPA.ItemRef = I.ItemID