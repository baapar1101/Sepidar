
IF OBJECT_ID('POM.vwPurchaseInvoiceItem') IS NOT NULL
  DROP VIEW POM.[vwPurchaseInvoiceItem]
GO
CREATE VIEW [POM].[vwPurchaseInvoiceItem]
AS
SELECT
  PII.PurchaseInvoiceItemID
 ,PII.PurchaseInvoiceRef
 ,PII.RowNumber
 ,PII.ItemRef
 ,PII.PurchaseOrderItemRef, POI.PurchaseOrderNumber AS BasePurchaseOrderNumber, POI.PurchaseOrderRef AS BasePurchaseOrderRef
 ,I.Code AS ItemCode
 ,I.BarCode AS BarCode
 ,I.Title AS ItemTitle
 ,I.Title_En AS ItemTitle_En
 ,I.[Type] AS ItemType
 ,I.UnitRef
 ,I.SecondaryUnitRef
 ,I.IsUnitRatioConstant
 ,I.UnitsRatio
 ,I.SerialTracking
 ,I.PropertyAmounts
 ,I.TaxExemptPurchase AS TaxExempt
 ,I.UnitTitle
 ,I.UnitTitle_En
 ,I.SecondaryUnitTitle
 ,I.SecondaryUnitTitle_En
 ,CASE
    WHEN I.TracingCategoryRef IS NULL THEN 0
    ELSE 1
  END AS ItemHasTracing
 ,GR.CalculationFormulaRef AS CalculationFormulaRef
 ,PII.Quantity
 ,PII.SecondaryQuantity
 ,I.Weight AS ItemWeight
 ,(PII.Quantity * I.Weight) AS TotalWeight
 ,CASE 
	WHEN I.type = 1 /*Product*/ THEN ISNULL(InventoryReceiptUsedQuantity.UsedQuantity, 0)
	WHEN I.Type = 3 /*AssetProduct*/ THEN ISNULL(UsedAsset.UsedQuantity, 0)
  END AS UsedQuantity
 ,CASE 
	WHEN I.type = 1 /*Product*/ THEN (PII.Quantity - ISNULL(InventoryReceiptUsedQuantity.UsedQuantity, 0))
	WHEN I.Type = 3 /*AssetProduct*/ THEN (PII.Quantity - ISNULL(UsedAsset.UsedQuantity, 0))
  END AS RemainingQuantity
  ,CASE 
	WHEN I.type = 1 /*Product*/ THEN InventoryReceiptUsedQuantity.UsedSecondaryQuantity
	ELSE NULL
  END AS UsedSecondaryQuantity
 ,CASE 
	WHEN PII.SecondaryQuantity IS NULL THEN NULL
	WHEN I.type = 1 /*Product*/ THEN (PII.SecondaryQuantity - ISNULL(InventoryReceiptUsedQuantity.UsedSecondaryQuantity, 0))
	ELSE NULL
  END AS RemainingSecondaryQuantity
  ,CASE 
	WHEN I.Type = 1 /*Product*/ THEN ISNULL(InventoryReceiptUsedQuantity.UsedPrice, 0)
	WHEN I.Type = 3 /*AssetProduct*/ THEN ISNULL(UsedAsset.UsedPrice, 0)
	ELSE NULL
  END AS UsedPrice
  ,CASE 
	WHEN I.Type = 1 /*Product*/ THEN (ISNULL(PCI.NetPriceInBaseCurrency, 0) - ISNULL(InventoryReceiptUsedQuantity.UsedPrice, 0))
	WHEN I.Type = 3 /*AssetProduct*/ THEN (ISNULL(PCI.NetPriceInBaseCurrency, 0) - ISNULL(UsedAsset.UsedPrice, 0))
	ELSE NULL
  END AS RemainingPrice
 ,(PII.Quantity - ISNULL(CC.CustomsClearancedQuantity, 0)) AS RemainingCustomsClearanceQuantity
 ,(PII.SecondaryQuantity - ISNULL(CC.CustomsClearancedSecondaryQuantity, 0)) AS RemainingCustomsClearanceSecondaryQuantity
 ,PII.Fee
 ,PII.FeeInBaseCurrency
 ,PII.Price
 ,PII.PriceInBaseCurrency
 ,PII.Discount
 ,PII.DiscountInBaseCurrency
 ,PII.Addition
 ,PII.AdditionInBaseCurrency
 ,PII.NetPrice
 ,PII.NetPriceInBaseCurrency
 ,PII.BaseInvoiceCalculatedPriceNoteInBaseCurrency
 ,PII.[Description]
 ,PII.Description_En
 ,PII.[Version]
 ,PII.TracingRef
 ,I.TracingCategoryRef
 ,T.Title AS TracingTitle
 ,IP.Number AS PurchaseInvoiceNumber
 ,IP.Date PurchaseInvoiceDate
 ,IP.DLRef PurchaseInvoiceDLRef
 ,IP.CurrencyRate
 ,IP.CurrencyPrecisionCount
 ,IP.CurrencyRef
 ,IP.CurrencyTitle
 ,IP.CurrencyTitle_En
 ,IP.DLTitle
 ,ISNULL(PCI.FinalFeeInBaseCurrency, 0) AS FinalFeeInBaseCurrency
 ,ISNULL(PCI.NetPriceInBaseCurrency, 0) AS CalculatedNetPriceInBaseCurrency
FROM POM.PurchaseInvoiceItem AS PII
LEFT OUTER JOIN POM.[vwPurchaseOrderItem] AS POI ON PII.[PurchaseOrderItemRef] = POI.PurchaseOrderItemID 
LEFT JOIN (SELECT
    SUM(ISNULL(iri.Quantity, 0)) AS UsedQuantity,
	SUM(IRI.SecondaryQuantity) AS UsedSecondaryQuantity,
	SUM(iri.Price) UsedPrice
   ,iri.BaseImportPurchaseInvoiceItemRef
  FROM INV.InventoryReceiptItem iri
  WHERE BaseImportPurchaseInvoiceItemRef IS NOT NULL
  GROUP BY iri.BaseImportPurchaseInvoiceItemRef) 
  InventoryReceiptUsedQuantity
  ON InventoryReceiptUsedQuantity.BaseImportPurchaseInvoiceItemRef = PII.PurchaseInvoiceItemID
LEFT JOIN (SELECT
	ISNULL(SUM(ARPI.Price), 0) UsedPrice
   ,ISNULL(Count(ARPI.AssetRelatedPurchaseInvoiceId), 0) AS UsedQuantity
   ,ARPI.PurchaseInvoiceItemRef
  FROM  [AST].[AssetRelatedPurchaseInvoice] ARPI
  GROUP BY ARPI.PurchaseInvoiceItemRef) AS UsedAsset
  ON UsedAsset.PurchaseInvoiceItemRef = PII.PurchaseInvoiceItemID
INNER JOIN POM.vwPurchaseInvoice AS IP
  ON PII.PurchaseInvoiceRef = IP.PurchaseInvoiceID
INNER JOIN INV.vwItem AS I
  ON PII.ItemRef = I.ItemID
LEFT OUTER JOIN INV.TracingCategory AS TC
  ON I.TracingCategoryRef = TC.TracingCategoryID
LEFT OUTER JOIN INV.Tracing AS T
  ON PII.TracingRef = T.TracingID
    AND TC.TracingCategoryID = T.TracingCategoryRef
LEFT OUTER JOIN GNR.[Grouping] GR
  ON I.PurchaseGroupRef = GR.GroupingID
LEFT OUTER JOIN POM.PurchaseCostItem AS PCI
	ON PII.PurchaseInvoiceItemID = PCI.PurchaseInvoiceItemRef
LEFT JOIN 
(
  SELECT PurchaseInvoiceItemRef, Sum(Quantity) AS CustomsClearancedQuantity, Sum(SecondaryQuantity) AS CustomsClearancedSecondaryQuantity
   FROM POM.CustomsClearanceItem
   GROUP BY PurchaseInvoiceItemRef
) AS CC
ON PII.PurchaseInvoiceItemID = CC.PurchaseInvoiceItemRef
GO