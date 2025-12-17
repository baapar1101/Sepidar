
/****** Object:  View [INV].[vwServiceInventoryPurchaseInvoiceItem]    Script Date: 04/23/2009 17:11:24 ******/
IF OBJECT_ID('INV.vwServiceInventoryPurchaseInvoiceItem') IS NOT NULL
	DROP VIEW INV.[vwServiceInventoryPurchaseInvoiceItem]
GO
CREATE VIEW [INV].[vwServiceInventoryPurchaseInvoiceItem]
AS
SELECT  IPI.InventoryPurchaseInvoiceItemID, IPI.InventoryPurchaseInvoiceRef, IPI.RowNumber, IPI.ItemRef, It.Code AS ItemCode,   
  IPI.PurchaseOrderItemRef , POI.PurchaseOrderNumber,
  It.BarCode AS BarCode, It.Title AS ItemTitle, It.Title_En AS ItemTitle_En, It.UnitRef, It.SecondaryUnitRef,   
  It.IsUnitRatioConstant, It.UnitsRatio, IPI.Quantity, IPI.SecondaryQuantity, IPI.CurrencyRate, IPI.Fee,   
  IPI.FeeInBaseCurrency, IPI.Price, IPI.PriceInBaseCurrency,
  IPI.Discount, IPI.DiscountInBaseCurrentcy, IPI.Tax,   
  IPI.TaxInBaseCurrency, IPI.Duty, IPI.DutyInBaseCurrency, IPI.NetPrice, IPI.NetPriceInBaseCurrency,   
  IPI.[Description], IPI.Description_En, IPI.[Version], IP.Number AS InventoryPurchaseInvoiceNumber,   
  IP.[Date] AS InventoryPurchaseInvoiceDate,
  IP.CostCenterRef AS ServiceInventoryPurchaseInvoiceCostCenterDlRef ,DL.Code AS ServiceInventoryPurchaseInvoiceCostCenterDlCode , dl.Title AS ServiceInventoryPurchaseInvoiceCostCenterDlTitle , dl.Title_En AS ServiceInventoryPurchaseInvoiceCostCenterDlTitle_En ,
  IPI.[CostServiceAccountSLRef],A.Title  CostServiceAccountTitle,A.Code CostServiceAccountCode,A.FullCode CostServiceAccountFullCode, A.HasDL AS CostServiceAccountSLHasDL ,
  IPI.[InsuranceAmount] ,IPI.[WithHoldingTaxAmount] ,  
  It.TracingCategoryRef, It.TaxExemptPurchase AS TaxExempt,  
  GR.CalculationFormulaRef AS CalculationFormulaRef,IPI.Addition, IPI.AdditionInBaseCurrency, IPI.InsuranceAmountInBaseCurrency,
  IPI.WithHoldingTaxAmountInBaseCurrency,
  (ISNULL(IPI.PriceInBaseCurrency, 0) + ISNULL(IPI.AdditionInBaseCurrency, 0) - ISNULL(IPI.DiscountInBaseCurrentcy, 0) - ISNULL(OC.UsedAmountInBaseCurrency, 0)) AS RemainingAmountInBaseCurrency
  ,ISNULL(OC.UsedAmountInBaseCurrency, 0) AS UsedAmountInBaseCurrency
FROM INV.Item AS It  
 INNER JOIN INV.InventoryPurchaseInvoiceItem AS IPI ON It.ItemID = IPI.ItemRef   
 INNER JOIN INV.InventoryPurchaseInvoice AS IP ON IPI.InventoryPurchaseInvoiceRef = IP.InventoryPurchaseInvoiceID
 LEFT JOIN ACC.DL AS DL ON IP.CostCenterRef = DL.DLId
 LEFT OUTER JOIN GNR.[Grouping] GR ON It.PurchaseGroupRef=GR.GroupingID  
 LEFT OUTER JOIN ACC.vwAccount A ON A.AccountId = IPI.[CostServiceAccountSLRef]
 LEFT OUTER JOIN INV.vwServicePurchaseInvoiceItemOtherCostedQuantities AS OC ON IPI.InventoryPurchaseInvoiceItemID = OC.InventoryPurchaseInvoiceItemID
 LEFT OUTER JOIN POM.[vwPurchaseOrderItem] AS POI ON [IPI].[PurchaseOrderItemRef] = POI.PurchaseOrderItemID 
WHERE IP.[Type] = 2 /* InventoryPurchaseInvoiceType.Service = 2*/  
GO