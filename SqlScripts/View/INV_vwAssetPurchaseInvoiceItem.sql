IF OBJECT_ID('INV.vwAssetPurchaseInvoiceItem') IS NOT NULL
	DROP VIEW INV.[vwAssetPurchaseInvoiceItem]
GO

CREATE VIEW [INV].[vwAssetPurchaseInvoiceItem]
AS
SELECT  IPI.InventoryPurchaseInvoiceItemID
	, IPI.InventoryPurchaseInvoiceRef
    , IPI.PurchaseOrderItemRef , POI.PurchaseOrderNumber , IP.PurchaseOrderRef
	, IPI.RowNumber
	, IPI.ItemRef
	, It.Code AS ItemCode 
	, It.BarCode AS BarCode
	, It.Title AS ItemTitle
	, It.Title_En AS ItemTitle_En
	, It.UnitRef, It.SecondaryUnitRef
	, It.IsUnitRatioConstant
	, It.UnitsRatio
	, IPI.Quantity
	, IPI.SecondaryQuantity
	, IPI.CurrencyRate
	, IP.CurrencyRef
	, IP.CurrencyTitle
	, IP.CurrencyTitle_En
	, IPI.Fee
	, IPI.FeeInBaseCurrency
	, IPI.Price
	, IPI.PriceInBaseCurrency
	, IPI.Discount
	, IPI.DiscountInBaseCurrentcy
	, IPI.Tax 
	, IPI.TaxInBaseCurrency
	, IPI.Duty
	, IPI.DutyInBaseCurrency
	, IPI.NetPrice
	, IPI.NetPriceInBaseCurrency
	, IPI.[Description]
	, IPI.Description_En
	, IPI.[Version]
	, IP.Number AS InventoryPurchaseInvoiceNumber
	, IP.[Date] AS InventoryPurchaseInvoiceDate
	, IPI.[CostServiceAccountSLRef]
	, A.Title  CostServiceAccountTitle
	, A.Code CostServiceAccountCode
	, IPI.[InsuranceAmount] 
	, IPI.[WithHoldingTaxAmount] 
	, It.TracingCategoryRef
	, It.TaxExemptPurchase AS TaxExempt
	, GR.CalculationFormulaRef AS CalculationFormulaRef
	, IPI.Addition
	, IPI.AdditionInBaseCurrency
	, IPI.InsuranceAmountInBaseCurrency
	, IPI.WithHoldingTaxAmountInBaseCurrency
	, It.Type As ItemType
	, ISNULL(Used.UsedPrice   , 0) UsedPrice
	, ISNULL(Used.UsedQuantity, 0) UsedQuantity
	, ISNULL(IPI.Price   , 0) - ISNULL(Used.UsedPrice   , 0) RemainingPrice
	, ISNULL(IPI.Quantity, 0) - ISNULL(Used.UsedQuantity, 0) RemainingQuantity
FROM INV.InventoryPurchaseInvoiceItem AS IPI 
	INNER JOIN INV.vwAssetPurchaseInvoice AS IP ON IPI.InventoryPurchaseInvoiceRef = IP.InventoryPurchaseInvoiceID	
	INNER JOIN INV.Item AS It ON It.ItemID = IPI.ItemRef 
	LEFT OUTER JOIN GNR.[Grouping] GR ON It.PurchaseGroupRef=GR.GroupingID
	LEFT OUTER JOIN ACC.Account A ON A.AccountId = IPI.[CostServiceAccountSLRef]	
	LEFT OUTER JOIN POM.[vwPurchaseOrderItem] AS POI ON [IPI].[PurchaseOrderItemRef] = POI.PurchaseOrderItemID 
	LEFT JOIN 
	(
		SELECT 
                  ISNULL(SUM(ARPI.Price), 0) UsedPrice
                , ISNULL(Count(ARPI.AssetRelatedPurchaseInvoiceId), 0) UsedQuantity 
                , AssetPurchaseInvoiceItemRef

        FROM  [AST].[AssetRelatedPurchaseInvoice] ARPI
			INNER JOIN  AST.AcquisitionReceiptItem ACQI ON ARPI.AcquisitionReceiptItemRef = ACQI.AcquisitionReceiptItemID
		    INNER JOIN  AST.AcquisitionReceipt     ACQ  ON ACQI.AcquisitionReceiptRef     = ACQ.AcquisitionReceiptID
		WHERE ACQ.Type <> 5 /*ImportPurchase*/
        GROUP BY AssetPurchaseInvoiceItemRef

	)Used on Used.AssetPurchaseInvoiceItemRef = IPI.InventoryPurchaseInvoiceItemID

WHERE IP.[Type] = 3 /* InventoryPurchaseInvoiceType.AssetPurchase = 3*/
GO
