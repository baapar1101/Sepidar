If Object_ID('SLS.vwInvoiceItemSerial') Is Not Null
	Drop View SLS.vwInvoiceItemSerial
GO
CREATE VIEW SLS.vwInvoiceItemSerial
AS
SELECT    A.VoucherItemTrackingID  
		 ,A.Serial
		 ,A.InvoiceItemRef
		 ,A.ItemRef 

FROM      INV.vwVoucherItemTracking    A
LEFT JOIN SLS.InvoiceItem           BI  ON A.InvoiceItemRef = BI.InvoiceItemID

WHERE A.InvoiceItemRef IS NOT NULL
	