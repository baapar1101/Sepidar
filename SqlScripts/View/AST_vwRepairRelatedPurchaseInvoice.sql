IF OBJECT_ID('AST.vwRepairRelatedPurchaseInvoice') IS NOT NULL
	DROP VIEW AST.vwRepairRelatedPurchaseInvoice
GO

CREATE VIEW AST.vwRepairRelatedPurchaseInvoice
AS
	SELECT 
		  RPI.[AssetRelatedPurchaseInvoiceId]
		, RPI.[AssetPurchaseInvoiceItemRef]
		, RPI.[AssetPurchaseInvoiceRef]
		, RPI.[PurchaseInvoiceItemRef]
		, RPI.[PurchaseInvoiceRef]
		, RPI.[RepairItemRef]
		, RPI.[RepairRef]
		, RPI.[RepairAccountingVoucherRef]
		, RPI.[RepairEffectiveDate] 
		, RPI.[AssetRelatedItemType]
		, RPI.[PurchaseInvoiceCurrencyRef]
		, RPI.[PurchaseInvoiceCurrencyRate]
		, RPI.[PurchaseInvoiceCurrencyTitle]
		, RPI.[PurchaseInvoiceCurrencyTitle_En]
		, RPI.[Price]
		, RPI.[PriceInBaseCurrency]
		, RPI.[RemainedInventoryPurchaseInvoicePrice]
		, RPI.[InvoiceDate]
		, RPI.[InvoiceNumber]
		, RPI.[ItemRef]
		, RPI.[ItemType]
		, RPI.[ItemCode]
		, RPI.[ItemTitle]
		, RPI.[ItemTitle_En]
		, RPI.[AssetPurchaseInvoiceItemPrice]
		, RPI.[AssetPurchaseInvoiceItemQuantity]
		, RPI.[AcquisitionReceiptType]
		, RPI.PurchaseType
	FROM AST.vwAssetRelatedPurchaseInvoice RPI
	WHERE RPI.RepairItemRef IS NOT NULL
GO	 
	 
 

 
  