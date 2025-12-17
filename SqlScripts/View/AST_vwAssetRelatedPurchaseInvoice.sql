If Object_ID('AST.vwAssetRelatedPurchaseInvoice') Is Not Null
	Drop View AST.vwAssetRelatedPurchaseInvoice
GO
CREATE VIEW AST.vwAssetRelatedPurchaseInvoice
AS

SELECT 
	  ARPI.[AssetRelatedPurchaseInvoiceId]
	, ARPI.[AssetPurchaseInvoiceItemRef]
	, PII.[InventoryPurchaseInvoiceRef] AS AssetPurchaseInvoiceRef
	, ISNULL (PI.PurchaseOrderRef,PIM.PurchaseOrderRef) AS PurchaseOrderRef
	, ISNULL (PII.PurchaseOrderNumber,PIM.PurchaseOrderNumber) AS PurchaseOrderNumber
	, ARPI.PurchaseInvoiceItemRef
	, PIIM.PurchaseInvoiceRef
	, ARPI.[AcquisitionReceiptItemRef]
	, ACQI.[AcquisitionReceiptRef]
	, [AcquisitionAccountingVoucherRef] = ACQ.VoucherRef 
	, [AcquisitionDate] = ACQ.Date
	, AcquisitionUtilizationDate = ACQI.[UtilizationDate]
	, ARPI.[RepairItemRef]
	, RPRI.[RepairRef]
	, [RepairAccountingVoucherRef] = RPR.VoucherRef 
	, [RepairEffectiveDate] = RPRI.EffectiveDate
	, CASE 
			WHEN RepairItemRef IS     NULL AND AcquisitionReceiptItemRef IS NOT NULL THEN 1 
			WHEN RepairItemRef IS NOT NULL AND AcquisitionReceiptItemRef IS     NULL THEN 2
			ELSE 0 
	  END AS AssetRelatedItemType
	, ISNULL(PII.CurrencyRef, PIIM.CurrencyRef) AS PurchaseInvoiceCurrencyRef
	, ISNULL(PII.CurrencyRate, PIIM.CurrencyRate) AS PurchaseInvoiceCurrencyRate
	, ISNULL(PII.CurrencyTitle, PIIM.CurrencyTitle) AS PurchaseInvoiceCurrencyTitle
	, ISNULL(PII.currencyTitle_En, PIIM.CurrencyTitle_En) AS PurchaseInvoiceCurrencyTitle_En
	, ARPI.[Price]
	, ISNULL(ARPI.PriceInBaseCurrency, 0) PriceInBaseCurrency
	, 0 RemainedInventoryPurchaseInvoicePrice
	, ISNULL(PI.[Date], PIIM.PurchaseInvoiceDate) AS InvoiceDate
	, ISNULL(PI.[Number], PIIM.PurchaseInvoiceNumber) AS InvoiceNumber 
	, ISNULL(PII.ItemRef, PIIM.ItemRef) AS ItemRef
	, ISNULL(PII.ItemType, PIIM.ItemType) AS ItemType
	, ISNULL(PII.ItemCode, PIIM.ItemCode) AS ItemCode
	, ISNULL(PII.ItemTitle, PIIM.ItemTitle) AS ItemTitle
	, ISNULL(PII.ItemTitle_En, PIIM.ItemTitle_En) AS ItemTitle_En
	, ISNULL(PII.Price, PIIM.Price) AS AssetPurchaseInvoiceItemPrice
	, ISNULL(PII.Quantity, PIIM.Quantity) AS AssetPurchaseInvoiceItemQuantity
	, ACQ.Type AS AcquisitionReceiptType
	, CASE 
		WHEN ARPI.AssetPurchaseInvoiceItemRef IS NOT NULL THEN 1 
		WHEN ARPI.PurchaseInvoiceItemRef IS NOT NULL THEN 2
		ELSE NULL
	  END AS PurchaseType
FROM AST.AssetRelatedPurchaseInvoice ARPI
	 LEFT JOIN  AST.AcquisitionReceiptItem ACQI ON ARPI.AcquisitionReceiptItemRef = ACQI.AcquisitionReceiptItemID
	 LEFT JOIN  AST.Asset                  ASST ON ACQI.AssetRef                  = ASST.AssetId
	 LEFT JOIN  AST.AcquisitionReceipt     ACQ  ON ACQI.AcquisitionReceiptRef     = ACQ.AcquisitionReceiptID
	 LEFT JOIN  AST.vwRepairItem             RPRI ON ARPI.RepairItemRef             = RPRI.RepairItemID
	 LEFT JOIN  AST.Repair                 RPR  ON RPRI.RepairRef                 = RPR.RepairID
	 LEFT JOIN INV.vwAssetPurchaseInvoiceItem PII ON PII.InventoryPurchaseInvoiceItemID = ARPI.AssetPurchaseInvoiceItemRef 
	 LEFT JOIN INV.vwAssetPurchaseInvoice PI on PI.InventoryPurchaseInvoiceID = PII.InventoryPurchaseInvoiceRef
	 LEFT JOIN POM.vwPurchaseInvoiceItem AS PIIM ON  PIIM.PurchaseInvoiceItemID = ARPI.PurchaseInvoiceItemRef
	 LEFT JOIN POM.vwPurchaseInvoice AS PIM ON  PIM.PurchaseInvoiceID = PIIM.PurchaseInvoiceRef
 GO


 