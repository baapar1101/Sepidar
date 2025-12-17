If Object_ID('GNR.vwBillItem') Is Not Null
	Drop View GNR.vwBillItem
GO
CREATE VIEW GNR.vwBillItem
AS
SELECT     B.BillItemID, B.BillRef, B.RowID, B.Type, B.InvoiceRef, B.ReturnedInvoiceRef, B.DebitCreditNoteRef, B.InventoryReceiptRef, B.ServiceInventoryPurchaseInvoiceRef,B.PaymentHeaderRef, B.RefundChequeRef,
                      B.ReceiptHeaderRef, B.ShredRef,B.PurchaseInvoiceRef,B.BillOfLoadingRef,B.InsurancePolicyRef,B.CommercialOrderRef,B.CustomsClearanceRef,
                      CASE WHEN B.Type = 1 THEN I.Number 
							WHEN B.Type = 2 THEN RI.Number 
							WHEN B.Type = 3 THEN DCN.Number 
							WHEN B.Type = 4 THEN IR.Number 
							WHEN B.Type = 5 THEN IRR.Number 
							WHEN B.Type = 6 THEN RH.Number 
							WHEN B.Type = 7 THEN PH.Number 
							WHEN B.Type = 8 OR B.Type = 9  THEN RC.Number 
							WHEN B.Type = 10 THEN RH.Number 
							WHEN B.Type = 11  THEN PH.Number
							WHEN B.Type = 12  THEN  RC.Number
							WHEN B.Type = 13  THEN  SIP.Number
							WHEN B.Type = 14  THEN  SH.Number
							WHEN B.Type = 15 THEN IR.Number
							WHEN B.Type = 17 THEN PI.Number
							WHEN B.Type = 18 THEN BOL.Number
							WHEN B.Type = 19 THEN IP.Number
							WHEN B.Type = 20 THEN CO.Number
							WHEN B.Type = 21 THEN CC.Number
					  END AS Number, 
                      CASE WHEN B.Type = 1 THEN I.Date 
							WHEN B.Type = 2 THEN RI.Date 
							WHEN B.Type = 3 THEN DCN.Date 
							WHEN B.Type = 4 THEN IR.Date 
							WHEN B.Type = 5 THEN IRR.Date 
							WHEN B.Type = 6 THEN RH.Date 
							WHEN B.Type = 7 THEN PH.Date 
							WHEN B.Type = 8  OR B.Type = 9 THEN RC.Date 
							WHEN B.Type = 10 THEN RH.Date 
							WHEN B.Type = 11  THEN PH.Date 
							WHEN B.Type = 12  THEN  RC.Date
							WHEN B.Type = 13  THEN  SIP.Date
							WHEN B.Type = 14  THEN  SH.Date
							WHEN B.Type = 15 THEN IR.Date

							WHEN B.Type = 17 THEN PI.Date
							WHEN B.Type = 18 THEN BOL.Date
							WHEN B.Type = 19 THEN IP.Date
							WHEN B.Type = 20 THEN CO.Date
							WHEN B.Type = 21 THEN CC.Date
					  END AS Date,                       
                      B.AmountInBaseCurrency, B.Amount, 
					 CASE 
							WHEN B.Type = 1 THEN I.CurrencyRef
							WHEN B.Type = 2 THEN RI.CurrencyRef 
							WHEN B.Type = 3 THEN DCN.CurrencyRef 
							WHEN B.Type = 4 THEN null
							WHEN B.Type = 5 THEN null
							WHEN B.Type = 6 THEN RH.CurrencyRef 
							WHEN B.Type = 7 THEN PH.CurrencyRef
							WHEN B.Type = 8 OR B.Type = 9  THEN RC.CurrencyRef
							WHEN B.Type = 10 THEN RH.CurrencyRef
							WHEN B.Type = 11 THEN PH.CurrencyRef
							WHEN B.Type = 12  THEN  RC.CurrencyRef
							WHEN B.Type = 13  THEN  SIP.CurrencyRef
							WHEN B.Type = 14  THEN  SH.CurrencyRef
							WHEN B.Type = 15 THEN null

							WHEN B.Type = 17 THEN PI.CurrencyRef
							WHEN B.Type = 18 THEN BOL.CurrencyRef
							WHEN B.Type = 19 THEN IP.CurrencyRef
							WHEN B.Type = 20 THEN null
							WHEN B.Type = 21 THEN CC.CurrencyRef
					  END AS CurrencyRef,
					 CASE 
							WHEN B.Type = 1 THEN I.CurrencyTitle
							WHEN B.Type = 2 THEN RI.CurrencyTitle 
							WHEN B.Type = 3 THEN DCN.CurrencyTitle 
							WHEN B.Type = 4 THEN null
							WHEN B.Type = 5 THEN null
							WHEN B.Type = 6 THEN RH.CurrencyTitle 
							WHEN B.Type = 7 THEN PH.CurrencyTitle
							WHEN B.Type = 8 OR B.Type = 9  THEN RC.CurrencyTitle
							WHEN B.Type = 10 THEN RH.CurrencyTitle
							WHEN B.Type = 11 THEN PH.CurrencyTitle
							WHEN B.Type = 12  THEN  RC.CurrencyTitle
							WHEN B.Type = 13  THEN  SIP.CurrencyTitle
							WHEN B.Type = 14  THEN  SH.CurrencyTitle
							WHEN B.Type = 15  THEN  null

							WHEN B.Type = 17 THEN PI.CurrencyTitle
							WHEN B.Type = 18 THEN BOL.CurrencyTitle
							WHEN B.Type = 19 THEN IP.CurrencyTitle
							WHEN B.Type = 20 THEN null
							WHEN B.Type = 21 THEN CC.CurrencyTitle
					  END AS CurrencyTitle,
					 CASE 
							WHEN B.Type = 1 THEN I.CurrencyTitle_En
							WHEN B.Type = 2 THEN RI.CurrencyTitle_En 
							WHEN B.Type = 3 THEN DCN.CurrencyTitle_En 
							WHEN B.Type = 4 THEN null
							WHEN B.Type = 5 THEN null
							WHEN B.Type = 6 THEN RH.CurrencyTitle_En 
							WHEN B.Type = 7 THEN PH.CurrencyTitle_En
							WHEN B.Type = 8 OR B.Type = 9  THEN RC.CurrencyTitle_En
							WHEN B.Type = 10 THEN RH.CurrencyTitle_En
							WHEN B.Type = 11 THEN PH.CurrencyTitle_En
							WHEN B.Type = 12 THEN RC.CurrencyTitle_En
							WHEN B.Type = 13  THEN  SIP.CurrencyTitle_En
							WHEN B.Type = 14  THEN  SH.CurrencyTitle_En
							WHEN B.Type = 15  THEN  null

							WHEN B.Type = 17 THEN PI.CurrencyTitle_En
							WHEN B.Type = 18 THEN BOL.CurrencyTitle_En
							WHEN B.Type = 19 THEN IP.CurrencyTitle_En
							WHEN B.Type = 20 THEN null
							WHEN B.Type = 21 THEN CC.CurrencyTitle_En
					  END AS CurrencyTitle_En,
					  B.EntityFullName , 
                      CASE 
							WHEN B.Type = 1 THEN I.VoucherNumber 
							WHEN B.Type = 2 THEN RI.VoucherNumber 
							WHEN B.Type = 3 THEN DCN.VoucherNumber 
							WHEN B.Type = 4 THEN IR.AccountingVoucherNumber 
							WHEN B.Type = 5 THEN IRR.AccountingVoucherNumber	
							WHEN B.Type = 6 THEN RH.VoucherNumber 
							WHEN B.Type = 7 THEN PH.VoucherNumber 
							WHEN B.Type = 8 OR B.Type = 9  THEN RC.VoucherNumber 
							WHEN B.Type = 10 THEN RH.VoucherNumber
							WHEN B.Type = 11 THEN PH.VoucherNumber
							WHEN B.Type = 12 THEN RC.VoucherNumber
							WHEN B.Type = 13  THEN  SIP.AccountingVoucherNumber
							WHEN B.Type = 14  THEN  NULL
							WHEN B.Type = 15 THEN IR.AccountingVoucherNumber 

							WHEN B.Type = 17 THEN NULL
							WHEN B.Type = 18 THEN BOL.VoucherNumber
							WHEN B.Type = 19 THEN IP.VoucherNumber
							WHEN B.Type = 20 THEN CO.VoucherNumber
							WHEN B.Type = 21 THEN CC.VoucherNumber
					  END AS VoucherNum,
                      CASE 
							WHEN B.Type = 1 THEN I.VoucherDate
							WHEN B.Type = 2 THEN RI.VoucherDate
							WHEN B.Type = 3 THEN DCN.VoucherDate
							WHEN B.Type = 4 THEN IR.AccountingVoucherDate
							WHEN B.Type = 5 THEN IRR.AccountingVoucherDate
							WHEN B.Type = 6 THEN RH.VoucherDate
							WHEN B.Type = 7 THEN PH.VoucherDate
							WHEN B.Type = 8 OR B.Type = 9  THEN RC.VoucherDate
							WHEN B.Type = 10 THEN RH.VoucherDate
							WHEN B.Type = 11 THEN PH.VoucherDate
							WHEN B.Type = 12 THEN RC.VoucherDate
							WHEN B.Type = 13  THEN  SIP.AccountingVoucherDate
							WHEN B.Type = 14  THEN  NULL
							WHEN B.Type = 15 THEN IRR.AccountingVoucherDate

							WHEN B.Type = 17 THEN NULL
							WHEN B.Type = 18 THEN BOL.VoucherDate
							WHEN B.Type = 19 THEN IP.VoucherDate
							WHEN B.Type = 20 THEN CO.VoucherDate
							WHEN B.Type = 21 THEN CC.VoucherDate
					  END AS VoucherDate
FROM GNR.BillItem AS B LEFT OUTER JOIN
                      SLS.vwReturnedInvoice AS RI ON B.ReturnedInvoiceRef = RI.ReturnedInvoiceId LEFT OUTER JOIN
                      SLS.vwInvoice AS I ON B.InvoiceRef = I.InvoiceId LEFT OUTER JOIN
                      RPA.vwReceiptHeader AS RH ON B.ReceiptHeaderRef = RH.ReceiptHeaderId LEFT OUTER JOIN
                      INV.vwServiceInventoryPurchaseInvoice AS SIP ON B.ServiceInventoryPurchaseInvoiceRef = SIP.InventoryPurchaseInvoiceID LEFT OUTER JOIN
                      RPA.vwPaymentHeader AS PH ON B.PaymentHeaderRef = PH.PaymentHeaderId LEFT OUTER JOIN
                      GNR.vwDebitCreditNote AS DCN ON B.DebitCreditNoteRef = DCN.DebitCreditNoteID LEFT OUTER JOIN
                      INV.vwInventoryReceipt AS IR ON B.InventoryReceiptRef = IR.InventoryReceiptID LEFT OUTER JOIN
                      INV.vwInventoryReceiptReturn AS IRR ON B.InventoryReceiptRef = IRR.InventoryReceiptID LEFT OUTER JOIN
                      RPA.vwRefundCheque AS RC ON B.RefundChequeRef = RC.RefundChequeID LEFT OUTER JOIN
                      GNR.vwShred AS SH ON B.ShredRef = SH.ShredID
					  LEFT OUTER JOIN
                      POM.vwPurchaseInvoice AS PI ON B.PurchaseInvoiceRef = PI.PurchaseInvoiceID
					  LEFT OUTER JOIN
                      POM.vwBillOfLoading AS BOL ON B.BillOfLoadingRef = BOL.BillOfLoadingID
					  LEFT OUTER JOIN
                      POM.vwInsurancePolicy AS IP ON B.InsurancePolicyRef = IP.InsurancePolicyID
					  LEFT OUTER JOIN
                      POM.vwCommercialOrder AS CO ON B.CommercialOrderRef = CO.CommercialOrderID
					  LEFT OUTER JOIN
                      POM.vwCustomsClearance AS CC ON B.CustomsClearanceRef = CC.CustomsClearanceID








