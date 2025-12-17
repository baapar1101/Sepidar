/****** Object:  View [POM].[vwCustomsClearanceItem] ******/

IF OBJECT_ID('POM.vwCustomsClearanceItem') IS NOT NULL
	DROP VIEW POM.[vwCustomsClearanceItem]
GO
CREATE VIEW [POM].[vwCustomsClearanceItem]
AS
    With Clearance
	AS
	(
	  SELECT PurchaseInvoiceItemRef, Sum(Quantity) AS Q
	  FROM pom.CustomsClearanceItem
      GROUP BY PurchaseInvoiceItemRef
	)
	SELECT [CustomsClearanceItemID]
      , CCI.[CustomsClearanceRef]
      , CCI.[PurchaseInvoiceItemRef], CCI.RowNumber
	  , P.Number AS PurchaseInvoiceNumber
	  , P.VendorDLRef AS PurchaseInvoiceVendorDLRef
	  , P.VendorDLCode AS PurchaseInvoiceVendorDLCode
	  , P.VendorDLTitle AS PurchaseInvoiceVendorDLTitle
	  , P.VendorDLTitle_En AS PurchaseInvoiceVendorDLTitle_En
	  , P.[Date] AS PurchaseInvoiceDate
	  , p.CurrencyRef AS PurchaseInvoiceCurrencyRef
	  , p.CurrencyTitle AS PurchaseInvoiceCurrencyTitle
	  , p.CurrencyTitle_En AS PurchaseInvoiceCurrencyTitle_En
	  , P.CurrencyRate AS  PurchaseInvoiceCurrencyRate
	  , p.CurrencyPrecisionCount PurchaseInvoiceCurrencyPrecisionCount
	  , PII.ItemRef 
	  , I.Code AS ItemCode
	  , I.BarCode AS BarCode
	  , I.Title AS ItemTitle
	  , I.Title_En AS ItemTitle_En
	  , I.UnitRef
	  , I.SecondaryUnitRef 
	  , I.IsUnitRatioConstant
	  , I.UnitsRatio	
	  , I.[Type] AS ItemType
	  , CASE WHEN ((ISNULL(CCI.Tax, 0) + ISNULL(CCI.Duty, 0)) = 0) THEN 1 ELSE 0 END AS TaxExempt
	  , PII.TracingRef
	  , I.TracingCategoryRef
	  , T.Title AS TracingTitle
	  , GR.CalculationFormulaRef AS CalculationFormulaRef
      , CCI.[CurrencyRef]
      , CCI.[Currencyrate]
	  , C.Title AS CurrencyTitle
	  , C.Title_En AS CurrencyTitle_En
	  , C.PrecisionCount AS CurrencyPrecisionCount
	  , CCI.[Quantity] 
	  , PII.[Quantity]-ISNULL(CL.Q,0) As PurchaseInvoiceQuantity 
	  , CCI.[SecondaryQuantity] 
      , CCI.[Amount]
      , CCI.[AmountInBaseCurrency]
      , CCI.[CustomsCost]
      , CCI.[Tax]
      , CCI.[Duty]
	  , PII.Quantity AS PurchaseInvoiceItemQuantity
	  , PII.NetPrice AS PurchaseInvoiceNetPrice
	  , PII.NetPriceInBaseCurrency AS PurchaseInvoiceNetPriceInBaseCurrency
	  ,  PII.PurchaseInvoiceRef
	  , CCI.PurchaseInvoiceItemNetPrice
	  , CCI.PurchaseInvoiceItemNetPriceInBaseCurrency
	  , CC.AssessCustomsCode
	  , CC.InCustomsCode
  FROM [POM].[CustomsClearanceItem] CCI
	INNER JOIN POM.vwCustomsClearance AS CC ON CCI.CustomsClearanceRef = CC.CustomsClearanceID
	INNER JOIN POM.vwPurchaseInvoiceItem PII On CCI.PurchaseInvoiceItemRef = PII.purchaseInvoiceItemID
	INNER JOIN POM.vwPurchaseInvoice P On PII.purchaseInvoiceRef = P.purchaseInvoiceID
	INNER JOIN INV.vwItem AS I ON PII.ItemRef = I.ItemID
	INNER JOIN GNR.Currency C ON CCI.CurrencyRef = C.CurrencyID
	LEFT OUTER JOIN INV.TracingCategory AS TC ON I.TracingCategoryRef = TC.TracingCategoryID
	LEFT OUTER JOIN INV.Tracing AS T ON PII.TracingRef = T.TracingID AND TC.TracingCategoryID = T.TracingCategoryRef
	LEFT OUTER JOIN Clearance CL ON CL.PurchaseInvoiceItemRef=PII.PurchaseInvoiceItemID
	LEFT OUTER JOIN GNR.[Grouping] GR ON I.PurchaseGroupRef = GR.GroupingID
GO