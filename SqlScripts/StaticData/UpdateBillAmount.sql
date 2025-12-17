UPDATE B
SET Amount = 
       (CASE 
		WHEN B.Type = 1 THEN I.NetPrice --›«ﬂ Ê— ›—Ê‘
		WHEN B.Type = 2 THEN -1 * RI.NetPrice --»—ê‘  ›«ﬂ Ê—

		--«⁄·«„ÌÂ »œÂﬂ«— Ê »” «‰ﬂ«—
		WHEN B.Type = 3 AND BH.Type = 1 THEN (SELECT top 1 DCNI.Amount 
											   FROM  GNR.vwDebitCreditNoteItem DCNI 
											  WHERE DCNI.DebitCreditNoteRef = DCN.DebitCreditNoteID
											   AND	DCNI.DebitDlRef = BH.PartyDlRef
											   AND  DCNI.AmountInBaseCurrency =  B.AmountInBaseCurrency 
											 UNION
											SELECT top 1 -1 * DCNI.Amount 
											   FROM  GNR.vwDebitCreditNoteItem DCNI 
											  WHERE DCNI.DebitCreditNoteRef = DCN.DebitCreditNoteID
											   AND	DCNI.CreditDLRef = BH.PartyDlRef
											   AND  DCNI.AmountInBaseCurrency =  -1 * B.AmountInBaseCurrency 
                                             )

		WHEN B.Type = 3 AND BH.Type = 2 THEN (SELECT top 1 -1 * DCNI.Amount 
											   FROM  GNR.vwDebitCreditNoteItem DCNI 
											  WHERE DCNI.DebitCreditNoteRef = DCN.DebitCreditNoteID
											   AND	DCNI.DebitDlRef = BH.PartyDlRef
											   AND  DCNI.AmountInBaseCurrency =  -1 * B.AmountInBaseCurrency 
											 UNION
											SELECT top 1 DCNI.Amount 
											   FROM  GNR.vwDebitCreditNoteItem DCNI 
											  WHERE DCNI.DebitCreditNoteRef = DCN.DebitCreditNoteID
											   AND	DCNI.CreditDLRef = BH.PartyDlRef
											   AND  DCNI.AmountInBaseCurrency =  B.AmountInBaseCurrency 
                                             )


		WHEN B.Type = 4 THEN B.AmountInBaseCurrency ---—”Ìœ «‰»«—
		WHEN B.Type = 5 THEN B.AmountInBaseCurrency --»—ê‘  —”Ìœ «‰»«—

		WHEN B.Type = 6 AND BH.Type = 1 THEN RH.TotalAmount * -1 ----—”Ìœ œ—Ì«› 
		WHEN B.Type = 6 AND BH.Type = 2 THEN RH.TotalAmount 

 
		WHEN B.Type = 7 AND BH.Type = 1 THEN PH.TotalAmount --- «⁄·«„ÌÂ Å—œ«Œ 
		WHEN B.Type = 7 AND BH.Type = 2 THEN PH.TotalAmount * -1 --- «⁄·«„ÌÂ Å—œ«Œ 

		WHEN B.Type = 8 AND BH.Type = 1 THEN  (SELECT -1 * Sum(RCI.Amount) ---«” —œ«œ çﬂ Å—œ«Œ ‰Ì
												FROM Rpa.vwRefundChequeItem RCI
												WHERE RCI.RefundChequeRef = RC.RefundChequeId)

		WHEN B.Type = 8 AND BH.Type = 2 THEN  (SELECT Sum(RCI.Amount)---«” —œ«œ çﬂ Å—œ«Œ ‰Ì
												FROM Rpa.vwRefundChequeItem RCI
												WHERE RCI.RefundChequeRef = RC.RefundChequeId)

		WHEN B.Type = 9 AND BH.Type = 1 THEN (SELECT Sum(RCI.Amount) ---«” —œ«œ çﬂ œ—Ì«› ‰Ì
												FROM Rpa.vwRefundChequeItem RCI
												WHERE RCI.RefundChequeRef = RC.RefundChequeId)
		WHEN B.Type = 9 AND BH.Type = 1 THEN  (SELECT -1 * Sum(RCI.Amount) ---«” —œ«œ çﬂ œ—Ì«› ‰Ì
												FROM Rpa.vwRefundChequeItem RCI
												WHERE RCI.RefundChequeRef = RC.RefundChequeId)


 
		WHEN B.Type = 10 AND BH.Type = 1 THEN RH.TotalAmount   ---  Œ›Ì›-—”Ìœ œ—Ì«› 
		WHEN B.Type = 10 AND BH.Type = 2 THEN RH.TotalAmount * -1 ---  Œ›Ì›-—”Ìœ œ—Ì«› 

		WHEN B.Type = 11 AND BH.Type = 1 THEN RH.TotalAmount * -1  ---  Œ›Ì›-«⁄·«„ÌÂ Å—œ«Œ 
		WHEN B.Type = 11 AND BH.Type = 2 THEN RH.TotalAmount  ---  Œ›Ì›-«⁄·«„ÌÂ Å—œ«Œ 
		END )

FROM         GNR.BillItem AS B INNER JOIN
  GNR.vwBill BH ON BH.BillID = B.BillREf LEFT OUTER JOIN
  SLS.vwReturnedInvoice AS RI ON B.ReturnedInvoiceRef = RI.ReturnedInvoiceId LEFT OUTER JOIN
  SLS.vwInvoice AS I ON B.InvoiceRef = I.InvoiceId LEFT OUTER JOIN
  RPA.vwReceiptHeader AS RH ON B.ReceiptHeaderRef = RH.ReceiptHeaderId LEFT OUTER JOIN
  RPA.vwPaymentHeader AS PH ON B.PaymentHeaderRef = PH.PaymentHeaderId LEFT OUTER JOIN
  GNR.vwDebitCreditNote AS DCN ON B.DebitCreditNoteRef = DCN.DebitCreditNoteID LEFT OUTER JOIN
  INV.vwInventoryReceipt AS IR ON B.InventoryReceiptRef = IR.InventoryReceiptID LEFT OUTER JOIN
  INV.vwInventoryReceiptReturn AS IRR ON B.InventoryReceiptRef = IRR.InventoryReceiptID LEFT OUTER JOIN
  RPA.vwRefundCheque AS RC ON B.RefundChequeRef = RC.RefundChequeID 
WHERE B.Amount is null



