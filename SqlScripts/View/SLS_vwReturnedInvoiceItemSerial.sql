If Object_ID('SLS.vwReturnedInvoiceItemSerial') Is Not Null
	Drop View SLS.vwReturnedInvoiceItemSerial
GO
CREATE VIEW SLS.vwReturnedInvoiceItemSerial
AS
SELECT    tracking.VoucherItemTrackingID  
		 ,tracking.Serial
		 ,tracking.ReturnedInvoiceItemRef
		 ,tracking.ItemRef 

FROM      INV.vwVoucherItemTracking    tracking
LEFT JOIN SLS.ReturnedInvoiceItem           BI  ON tracking.InvoiceItemRef = BI.ReturnedInvoiceItemID

WHERE tracking.ReturnedInvoiceItemRef IS NOT NULL
	