
/****** Object:  View [INV].[vwInventoryReceiptOtherCostItem] ******/
IF OBJECT_ID('INV.vwInventoryReceiptOtherCostItem') IS NOT NULL
	DROP VIEW INV.[vwInventoryReceiptOtherCostItem]
GO
CREATE VIEW [INV].[vwInventoryReceiptOtherCostItem]
AS
SELECT POCI.InventoryReceiptOtherCostItemID
	,POCI.InventoryReceiptRef
	,POCI.RowNumber
	,POCI.ServiceInventoryPurchaseInvoiceItemRef
	,SPII.InventoryPurchaseInvoiceNumber AS ServiceInventoryPurchaseInvoiceNumber
	,SPII.InventoryPurchaseInvoiceRef AS ServiceInventoryPurchaseInvoiceRef
	,SPII.InventoryPurchaseInvoiceDate AS ServiceInventoryPurchaseInvoiceDate
	,POCI.CostServiceAccountSLRef
	,POCI.CostCenterDlRef , Dl.Code AS CostCenterDlCode , Dl.Title AS CostCenterDlTitle , Dl.Title_En AS CostCenterDlTitle_En
	,A.Title  CostServiceAccountTitle
	,A.Code CostServiceAccountCode
	,A.FullCode CostServiceAccountFullCode
	,A.HasDL AS CostServiceAccountSLHasDL
	,SPII.ItemRef
	,SPII.ItemCode
	,SPII.ItemTitle
	,SPII.ItemTitle_En
	,(SPII.PriceInBaseCurrency + ISNULL(SPII.AdditionInBaseCurrency,0) - ISNULL(SPII.DiscountInBaseCurrentcy,0) ) AS AmountInBaseCurrency
	,(ISNULL(SPII.PriceInBaseCurrency, 0) + ISNULL(SPII.AdditionInBaseCurrency, 0) - ISNULL(SPII.DiscountInBaseCurrentcy, 0) - ISNULL(OC.UsedAmountInBaseCurrency, 0)) AS ServiceInventoryPurchaseInvoiceItemRemainingAmount
	,POCI.EffectiveAmountInBaseCurrency
	,POCI.AllotmentType
FROM INV.InventoryReceiptOtherCostItem AS POCI
	INNER JOIN INV.vwServiceInventoryPurchaseInvoiceItem AS SPII ON POCI.ServiceInventoryPurchaseInvoiceItemRef = SPII.InventoryPurchaseInvoiceItemID
	LEFT JOIN ACC.vwAccount A ON A.AccountId = POCI.CostServiceAccountSLRef
	LEFT JOIN ACC.DL DL ON DL.DLId = POCI.CostCenterDlRef
	LEFT OUTER JOIN INV.vwServicePurchaseInvoiceItemOtherCostedQuantities AS OC ON SPII.InventoryPurchaseInvoiceItemID = OC.InventoryPurchaseInvoiceItemID
GO