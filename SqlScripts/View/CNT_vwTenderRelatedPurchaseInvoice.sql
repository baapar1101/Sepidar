IF OBJECT_ID('CNT.vwTenderRelatedPurchaseInvoice') IS NOT NULL
	DROP VIEW CNT.vwTenderRelatedPurchaseInvoice
GO

CREATE VIEW CNT.vwTenderRelatedPurchaseInvoice
AS
	SELECT 
		  CRP.[ContractRelatedPurchaseInvoiceId]		
		, CRP.[PurchaseInvoiceRef]
		, CRP.[TenderRef]
		, T.[Date] TenderDate
		, T.[DocumentNumber] TenderNumber
		, T.[DLCode] TenderDLCode
		, SPI.TotalNetPrice
		, SPI.TotalNetPriceInBaseCurrency
		, SPI.TotalPrice
		, SPI.TotalPriceInBaseCurrency
		, SPI.[Date] InvoiceDate
		, SPI.[InvoiceNumber]
		, SPI.[DLCode] InvoiceDLCode
	FROM CNT.ContractRelatedPurchaseInvoice CRP
	INNER JOIN INV.vwServiceInventoryPurchaseInvoice SPI on SPI.InventoryPurchaseInvoiceID = CRP.PurchaseInvoiceRef
	INNER JOIN CNT.vwTender T on T.TenderID = CRP.TenderRef
	
GO	 
	 
 

 
  