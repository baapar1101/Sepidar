IF Object_ID('RPA.vwPartyAccountSettlementDebitItem') IS NOT NULL
	Drop View RPA.vwPartyAccountSettlementDebitItem
GO
Create View RPA.vwPartyAccountSettlementDebitItem
AS
SELECT        PSI.PartyAccountSettlementItemID , PSI.PartyAccountSettlementRef, PSI.DebitEntityType, PSI.DebitEntityRef, 
						CASE	WHEN PSI.DebitEntityType = 1 THEN I.Number
								WHEN PSI.DebitEntityType = 2 THEN PH.Number
								WHEN PSI.DebitEntityType = 6 THEN DCN.Number
								WHEN PSI.DebitEntityType = 7 THEN RC.Number
								WHEN PSI.DebitEntityType = 8 THEN ShredInvoiceInterestPenalty.Number
								WHEN PSI.DebitEntityType = 9 THEN ShredRemainingPersonelLoan.Number
								WHEN PSI.DebitEntityType = 10 THEN ShredRemainingOtherReceivable.Number 
								ELSE NULL 
						END AS DebitDocumentNumber, 
						CASE	WHEN PSI.DebitEntityType = 1 THEN I.Date
								WHEN PSI.DebitEntityType = 2 THEN PH.Date
								WHEN PSI.DebitEntityType = 6 THEN DCN.Date
								WHEN PSI.DebitEntityType = 7 THEN RC.Date
								WHEN PSI.DebitEntityType = 8 THEN ShredInvoiceInterestPenalty.[Date]
								WHEN PSI.DebitEntityType = 9 THEN ShredRemainingPersonelLoan.[Date]
								WHEN PSI.DebitEntityType = 10 THEN ShredRemainingOtherReceivable.[Date] 
								ELSE NULL 
						END AS DebitDocumentDate, 
                        CASE	WHEN PSI.DebitEntityType = 1 THEN I.NetPrice 
								WHEN PSI.DebitEntityType = 2 THEN PH.PaymentAmount 
								WHEN PSI.DebitEntityType = 5 THEN POB.OpeningBalance 
								WHEN PSI.DebitEntityType = 6 THEN DCN.SumAmount
								WHEN PSI.DebitEntityType = 8 THEN ShredInvoiceInterestPenalty.InterestPenaltyTotalAmount	
								WHEN PSI.DebitEntityType = 9 THEN ShredRemainingPersonelLoan.ShredTotalAmount
								WHEN PSI.DebitEntityType = 10 THEN ShredRemainingOtherReceivable.ShredTotalAmount 			
								ELSE NULL 
						END AS DebitDocumentAmount, 
						CASE	WHEN PSI.DebitEntityType = 1 THEN I.NetPriceInBaseCurrency
								WHEN PSI.DebitEntityType = 2 THEN [GNR].[fnCalcAmountInBaseCurrency](PH.PaymentAmount, PH.Rate)
								WHEN PSI.DebitEntityType = 5 THEN POB.OpeningBalance
								WHEN PSI.DebitEntityType = 6 THEN DCN.SumAmountinbasecurrency
								WHEN PSI.DebitEntityType = 8 THEN ShredInvoiceInterestPenalty.InterestPenaltyTotalAmount
								WHEN PSI.DebitEntityType = 9 THEN ShredRemainingPersonelLoan.ShredTotalAmount
								WHEN PSI.DebitEntityType = 10 THEN ShredRemainingOtherReceivable.ShredTotalAmount 								
								ELSE NULL 
						END AS DebitDocumentAmountInBaseCurrency, 
                        CASE	WHEN PSI.DebitEntityType = 1 THEN I.Rate 
								WHEN PSI.DebitEntityType = 2 THEN PH.Rate 
								WHEN PSI.DebitEntityType = 6 THEN DCN.Rate
								ELSE NULL 
						END AS DebitDocumentRate, 
                        CASE	WHEN PSI.DebitEntityType = 1 THEN I.slRef
								WHEN PSI.DebitEntityType = 2 THEN PH.AccountSlRef
								ELSE NULL 
						END AS DebitDocumentSlRef, 
                        CASE	WHEN PSI.DebitEntityType = 1 THEN I.SlCode 
								WHEN PSI.DebitEntityType = 2 THEN PH.AccountCode
								WHEN PSI.DebitEntityType = 6 THEN DCN.DebitSLCode 
								ELSE NULL 
						END AS DebitDocumentSlCode, 
                        CASE	WHEN PSI.DebitEntityType = 1 THEN I.slTitle 
								WHEN PSI.DebitEntityType = 2 THEN PH.AccountTitle 
								WHEN PSI.DebitEntityType = 6 THEN DCN.DebitSLTitle
								ELSE NULL 
						END AS DebitDocumentSlTilte, 
						CASE	WHEN PSI.DebitEntityType = 1 THEN I.TotalReceivedAmount
								WHEN PSI.DebitEntityType = 2 THEN PayRemaining.TotalReceivedAmount								
								WHEN PSI.DebitEntityType = 5 THEN (CASE	WHEN PS.PartyAccountSettlementType = 1 THEN DebitOpeningBalanceRemainingCustomer.TotalReceivedAmount 
																		WHEN PS.PartyAccountSettlementType = 2 THEN DebitOpeningBalanceRemainingBroker.TotalReceivedAmount 
																		WHEN PS.PartyAccountSettlementType = 3 THEN DebitOpeningBalanceRemainingVendor.TotalReceivedAmount
																		ELSE NULL 
																	 END)
								WHEN PSI.DebitEntityType = 6 THEN (CASE		WHEN PS.PartyAccountSettlementType = 1 THEN DebitNoteRemainingCustomer.TotalReceivedAmount 
																			WHEN PS.PartyAccountSettlementType = 2 THEN DebitNoteRemainingBroker.TotalReceivedAmount 
																			ELSE DebitNoteRemainingVendor.TotalReceivedAmount 
																   END)								
								WHEN PSI.DebitEntityType = 7 THEN (CASE		WHEN PS.PartyAccountSettlementType = 1 THEN RefundReceiptChequeRemainingCustomer.TotalReceivedAmount 
																			WHEN PS.PartyAccountSettlementType = 2 THEN RefundReceiptChequeRemainingBroker.TotalReceivedAmount 
																			ELSE RefundReceiptChequeRemainingVendor.TotalReceivedAmount 
																   END)
								WHEN PSI.DebitEntityType = 8 THEN ShredInvoiceInterestPenalty.InterestPenaltyTotalReceivedAmount
								WHEN PSI.DebitEntityType = 9 THEN ShredRemainingPersonelLoan.ShredTotalReceivedAmount
								WHEN PSI.DebitEntityType = 10 THEN  ShredRemainingOtherReceivable.ShredTotalReceivedAmount
								ELSE NULL 
						END AS SettlementedAmount, 
						CASE	WHEN PSI.DebitEntityType = 1 THEN I.RemainingAmount
								WHEN PSI.DebitEntityType = 2 THEN PayRemaining.RemainingAmount								
								WHEN PSI.DebitEntityType = 5 THEN (CASE	WHEN PS.PartyAccountSettlementType = 1 THEN DebitOpeningBalanceRemainingCustomer.RemainingAmount 
																		WHEN PS.PartyAccountSettlementType = 2 THEN DebitOpeningBalanceRemainingBroker.RemainingAmount 
																		WHEN PS.PartyAccountSettlementType = 3 THEN DebitOpeningBalanceRemainingVendor.RemainingAmount 
																		ELSE NULL 
																	 END)								
								WHEN PSI.DebitEntityType = 6 THEN (CASE		WHEN PS.PartyAccountSettlementType = 1 THEN DebitNoteRemainingCustomer.RemainingAmount 
																			WHEN PS.PartyAccountSettlementType = 2 THEN DebitNoteRemainingBroker.RemainingAmount 
																			ELSE DebitNoteRemainingVendor.RemainingAmount 
																   END)									
								WHEN PSI.DebitEntityType = 7 THEN (CASE		WHEN PS.PartyAccountSettlementType = 1 THEN RefundReceiptChequeRemainingCustomer.RemainingAmount 
																			WHEN PS.PartyAccountSettlementType = 2 THEN RefundReceiptChequeRemainingBroker.RemainingAmount 
																			ELSE RefundReceiptChequeRemainingVendor.RemainingAmount 
																   END)
								WHEN PSI.DebitEntityType = 8 THEN 	ShredInvoiceInterestPenalty.InterestPenaltyRemainingAmount		
								WHEN PSI.DebitEntityType = 9 THEN ShredRemainingPersonelLoan.ShredRemainingAmount
								WHEN PSI.DebitEntityType = 10 THEN  ShredRemainingOtherReceivable.ShredRemainingAmount			
								ELSE NULL 
						END AS UnSettlementedAmount, 
						PSI.Amount,  PSI.IsSettled,
						PSI.CurrencyRef, C.Title AS CurrencyTitle, C.Title_En AS CurrencyTitle_En
FROM            RPA.PartyAccountSettlementItem AS PSI INNER JOIN
                         RPA.vwPartyAccountSettlement AS PS ON PSI.PartyAccountSettlementRef = PS.PartyAccountSettlementID INNER JOIN
                         GNR.Currency AS C ON PSI.CurrencyRef = C.CurrencyID LEFT OUTER JOIN
                         SLS.vwInvoice AS I ON PSI.DebitEntityRef = I.InvoiceId AND PSI.DebitEntityType = 1 LEFT OUTER JOIN						 
                         RPA.vwPaymentHeader AS PH ON PSI.DebitEntityRef = PH.PaymentHeaderId AND PSI.DebitEntityType = 2 LEFT OUTER JOIN	
						 RPA.fnPaymentRemaining() PayRemaining ON PayRemaining.PaymentHeaderId = PH.PaymentHeaderId LEFT OUTER JOIN	
						 GNR.vwDebitCreditNote DCN ON PSI.DebitEntityRef = DCN.DebitCreditNoteID AND PSI.DebitEntityType = 6 	
						 OUTER APPLY	
						 ( 
						     SELECT * FROM GNR.fnDebitNoteRemaining(PS.PartyDlRef,2) DebitNoteRemainingCustomer 
						     WHERE DebitNoteRemainingCustomer.DebitCreditNoteID = DCN.DebitCreditNoteID 
						 ) DebitNoteRemainingCustomer
						 OUTER APPLY
						 (
						     SELECT * FROM GNR.fnDebitNoteRemaining(PS.PartyDlRef,4) DebitNoteRemainingBroker 
						     WHERE DebitNoteRemainingBroker.DebitCreditNoteID = DCN.DebitCreditNoteID 
						 ) DebitNoteRemainingBroker
						 OUTER APPLY	
						 (
						     SELECT * FROM GNR.fnDebitNoteRemaining(PS.PartyDlRef,1) DebitNoteRemainingVendor 
						     WHERE DebitNoteRemainingVendor.DebitCreditNoteID = DCN.DebitCreditNoteID 	
						 )DebitNoteRemainingVendor
						LEFT OUTER JOIN
						RPA.vwRefundCheque RC ON PSI.DebitEntityRef = RC.RefundChequeId AND PSI.DebitEntityType = 7 AND RC.Type = 1 LEFT OUTER JOIN
						 RPA.fnRefundReceiptChequeRemaining(1) RefundReceiptChequeRemainingCustomer ON RefundReceiptChequeRemainingCustomer.RefundChequeId = RC.RefundChequeId LEFT OUTER JOIN
						 RPA.fnRefundReceiptChequeRemaining(8) RefundReceiptChequeRemainingBroker ON RefundReceiptChequeRemainingBroker.RefundChequeId = RC.RefundChequeId LEFT OUTER JOIN
						 RPA.fnRefundReceiptChequeRemaining(16) RefundReceiptChequeRemainingVendor ON RefundReceiptChequeRemainingVendor.RefundChequeId = RC.RefundChequeId LEFT OUTER JOIN
						 GNR.PartyOpeningBalance POB ON PSI.DebitEntityRef = POB.PartyOpeningBalanceID AND PSI.DebitEntityType = 5 AND OpeningBalanceType = 1 LEFT OUTER JOIN
						 GNR.fnDebitOpeningBalanceRemaining(0) DebitOpeningBalanceRemainingCustomer ON DebitOpeningBalanceRemainingCustomer.PartyOpeningBalanceID = POB.PartyOpeningBalanceID LEFT OUTER JOIN
						 GNR.fnDebitOpeningBalanceRemaining(1) DebitOpeningBalanceRemainingVendor ON DebitOpeningBalanceRemainingVendor.PartyOpeningBalanceID = POB.PartyOpeningBalanceID LEFT OUTER JOIN
						 GNR.fnDebitOpeningBalanceRemaining(2) DebitOpeningBalanceRemainingBroker ON DebitOpeningBalanceRemainingBroker.PartyOpeningBalanceID = POB.PartyOpeningBalanceID LEFT OUTER JOIN						 
						 GNR.vwShredRemaining ShredInvoiceInterestPenalty ON ShredInvoiceInterestPenalty.ShredID = PSI.DebitEntityRef AND PSI.DebitEntityType = 8 LEFT JOIN
						 GNR.vwShredRemaining ShredRemainingPersonelLoan ON ShredRemainingPersonelLoan.ShredID = PSI.DebitEntityRef AND PSI.DebitEntityType = 9 LEFT JOIN
						 GNR.vwShredRemaining ShredRemainingOtherReceivable ON ShredRemainingOtherReceivable.ShredID = PSI.DebitEntityRef AND PSI.DebitEntityType = 10
						 
WHERE CreditEntityType IS NULL