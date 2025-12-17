IF OBJECT_ID('AST.vwAcquisitionRelatedPurchaseInvoice') IS NOT NULL
	DROP VIEW AST.vwAcquisitionRelatedPurchaseInvoice
GO

CREATE VIEW AST.vwAcquisitionRelatedPurchaseInvoice
AS
	SELECT 
		  RPI.[AssetRelatedPurchaseInvoiceId]
		, RPI.[AssetPurchaseInvoiceItemRef]
		, RPI.[AssetPurchaseInvoiceRef]
		, RPI.[PurchaseInvoiceItemRef]
		, RPI.[PurchaseInvoiceRef]
		, RPI.[AcquisitionReceiptItemRef]
		, RPI.[AcquisitionReceiptRef]
		, RPI.[AcquisitionAccountingVoucherRef]
		, RPI.[AcquisitionDate] 
		, RPI.[AcquisitionUtilizationDate]
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
		, RPI.PurchaseOrderNumber
		, RPI.PurchaseOrderRef
	FROM AST.vwAssetRelatedPurchaseInvoice RPI
	WHERE AcquisitionReceiptItemRef  IS NOT NULL 
GO