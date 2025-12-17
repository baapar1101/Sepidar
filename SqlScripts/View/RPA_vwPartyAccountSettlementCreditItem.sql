IF Object_ID('RPA.vwPartyAccountSettlementCreditItem') IS NOT NULL
	Drop View RPA.vwPartyAccountSettlementCreditItem
GO
Create View RPA.vwPartyAccountSettlementCreditItem
AS
SELECT        PSI.PartyAccountSettlementItemID , PSI.PartyAccountSettlementRef , PSI.CreditEntityType, PSI.CreditEntityRef,
						CASE	WHEN PSI.CreditEntityType = 22 THEN RI.Number
								WHEN PSI.CreditEntityType = 23 THEN RH.Number
								WHEN PSI.CreditEntityType = 25 THEN DCN.Number
								WHEN PSI.CreditEntityType = 26 THEN RC.Number
								WHEN PSI.CreditEntityType = 27 THEN RCO.Number								
								ELSE NULL 
						END AS CreditDocumentNumber, 
						CASE	WHEN PSI.CreditEntityType = 21 THEN CC.ToDate 
								WHEN PSI.CreditEntityType = 22 THEN RI.Date 
								WHEN PSI.CreditEntityType = 23 THEN RH.Date
								WHEN PSI.CreditEntityType = 25 THEN DCN.Date 
								WHEN PSI.CreditEntityType = 26 THEN RC.Date 
								WHEN PSI.CreditEntityType = 27 THEN RCO.Date 						   								
								ELSE NULL 
						END AS CreditDocumentDate, 
                        CASE	WHEN PSI.CreditEntityType = 21 THEN CC.Amount 
								WHEN PSI.CreditEntityType = 22 THEN RI.NetPrice 
								WHEN PSI.CreditEntityType = 23 THEN RH.ReceiptAmount 
								WHEN PSI.CreditEntityType = 21 THEN CC.Amount 
								WHEN PSI.CreditEntityType = 24 THEN POB.OpeningBalance
								WHEN PSI.CreditEntityType = 25 THEN DCN.SumAmount 
								WHEN PSI.CreditEntityType = 26 THEN RC.TotalAmount 
								WHEN PSI.CreditEntityType = 27 THEN RCO.TotalAmount 
								ELSE NULL 
						END AS CreditDocumentAmount, 
						CASE	WHEN PSI.CreditEntityType = 21 THEN CC.Amount 
								WHEN PSI.CreditEntityType = 22 THEN RI.NetPriceInBaseCurrency 
								WHEN PSI.CreditEntityType = 23 THEN [GNR].[fnCalcAmountInBaseCurrency](RH.ReceiptAmount, RH.Rate) 
								WHEN PSI.CreditEntityType = 21 THEN CC.Amount 
								WHEN PSI.CreditEntityType = 24 THEN POB.OpeningBalance 						   
								WHEN PSI.CreditEntityType = 25 THEN DCN.SumAmountInBaseCurrency 
								WHEN PSI.CreditEntityType = 26 THEN RC.TotalAmount 
								WHEN PSI.CreditEntityType = 27 THEN RCO.TotalAmount 
								ELSE NULL 
						END AS CreditDocumentAmountInBaseCurrency, 						 
                        CASE	WHEN PSI.CreditEntityType = 22 THEN RI.Rate 
								WHEN PSI.CreditEntityType = 23 THEN RH.Rate 
								WHEN PSI.CreditEntityType = 25 THEN DCN.Rate  
								ELSE NULL 
						END AS CreditDocumentRate, 
                        CASE	WHEN PSI.CreditEntityType = 22 THEN RI.SLRef 
								WHEN PSI.CreditEntityType = 23 THEN RH.AccountSlRef 						   
								ELSE NULL 
						END AS CreditDocumentSlRef, 
                        CASE	WHEN PSI.CreditEntityType = 22 THEN RI.SLCode 
								WHEN PSI.CreditEntityType = 23 THEN RH.AccountCode 
								WHEN PSI.CreditEntityType = 25 THEN DCN.CreditSLCode 	 
								ELSE NULL 
						END AS CreditDocumentSlCode, 
                        CASE	WHEN PSI.CreditEntityType = 22 THEN RI.SLTitle 
								WHEN PSI.CreditEntityType = 23 THEN RH.AccountTitle 
								WHEN PSI.CreditEntityType = 25 THEN DCN.CreditSLTitle 
								ELSE NULL 
						END AS CreditDocumentSlTilte, 
						CASE	WHEN PSI.CreditEntityType = 21 THEN CommissionCalculationRemaining.TotalReceivedAmount 
								WHEN PSI.CreditEntityType = 22 THEN RIRemaining.TotalReceivedAmount 
								WHEN PSI.CreditEntityType = 23 THEN ReceiptRemaining.TotalReceivedAmount 
								WHEN PSI.CreditEntityType = 24 THEN (CASE	WHEN PS.PartyAccountSettlementType = 1 THEN CreditOpeningBalanceRemainingCustomer.TotalReceivedAmount 
																			WHEN PS.PartyAccountSettlementType = 2 THEN CreditOpeningBalanceRemainingBroker.TotalReceivedAmount 
																			WHEN PS.PartyAccountSettlementType = 3 THEN CreditOpeningBalanceRemainingVendor.TotalReceivedAmount 
																			ELSE NULL 
																	 END)
								WHEN PSI.CreditEntityType = 25 THEN (CASE	WHEN PS.PartyAccountSettlementType = 1 THEN CreditNoteRemainingCustomer.TotalReceivedAmount 
																			WHEN PS.PartyAccountSettlementType = 2 THEN CreditNoteRemainingBroker.TotalReceivedAmount 
																			ELSE CreditNoteRemainingVendor.TotalReceivedAmount 
																	 END)
								WHEN PSI.CreditEntityType = 26 THEN (CASE	WHEN PS.PartyAccountSettlementType = 1 THEN RefundPaymentChequeRemainingCustomer.TotalReceivedAmount 
																			WHEN PS.PartyAccountSettlementType = 2 THEN RefundPaymentChequeRemainingBroker.TotalReceivedAmount 
																			ELSE RefundPaymentChequeRemainingVendor.TotalReceivedAmount 
																	 END)
								WHEN PSI.CreditEntityType = 27 THEN (CASE	WHEN PS.PartyAccountSettlementType = 1 THEN ReturnChequeOtherRemainingCustomer.TotalReceivedAmount 
																			WHEN PS.PartyAccountSettlementType = 2 THEN ReturnChequeOtherRemainingBroker.TotalReceivedAmount 
																			ELSE ReturnChequeOtherRemainingVendor.TotalReceivedAmount 
																	 END) 								
								ELSE NULL 
						END AS SettlementedAmount, 
						CASE	WHEN PSI.CreditEntityType = 21 THEN CommissionCalculationRemaining.RemainingAmount 
								WHEN PSI.CreditEntityType = 22 THEN RIRemaining.RemainingAmount 
								WHEN PSI.CreditEntityType = 23 THEN ReceiptRemaining.RemainingAmount 
								WHEN PSI.CreditEntityType = 24 THEN (CASE	WHEN PS.PartyAccountSettlementType = 1 THEN CreditOpeningBalanceRemainingCustomer.RemainingAmount 
																			WHEN PS.PartyAccountSettlementType = 2 THEN CreditOpeningBalanceRemainingBroker.RemainingAmount 
																			WHEN PS.PartyAccountSettlementType = 3 THEN CreditOpeningBalanceRemainingVendor.RemainingAmount 
																			ELSE NULL 
																	 END)								
								WHEN PSI.CreditEntityType = 25 THEN (CASE	WHEN PS.PartyAccountSettlementType = 1 THEN CreditNoteRemainingCustomer.RemainingAmount 
																			WHEN PS.PartyAccountSettlementType = 2 THEN CreditNoteRemainingBroker.RemainingAmount 
																			ELSE CreditNoteRemainingVendor.RemainingAmount 
																	 END)
								WHEN PSI.CreditEntityType = 26 THEN (CASE	WHEN PS.PartyAccountSettlementType = 1 THEN RefundPaymentChequeRemainingCustomer.RemainingAmount 
																			WHEN PS.PartyAccountSettlementType = 2 THEN RefundPaymentChequeRemainingBroker.RemainingAmount 
																			ELSE RefundPaymentChequeRemainingVendor.RemainingAmount 
																	 END)
								WHEN PSI.CreditEntityType = 27 THEN (CASE	WHEN PS.PartyAccountSettlementType = 1 THEN ReturnChequeOtherRemainingCustomer.RemainingAmount 
																			WHEN PS.PartyAccountSettlementType = 2 THEN ReturnChequeOtherRemainingBroker.RemainingAmount 
																			ELSE ReturnChequeOtherRemainingVendor.RemainingAmount 
																	 END)																							
								ELSE NULL 
						END AS UnSettlementedAmount, 						 
						PSI.Amount,  PSI.IsSettled,
						PSI.CurrencyRef , C.Title AS CurrencyTitle, C.Title_En AS CurrencyTitle_En, 
						PS.PartyAccountSettlementType
FROM            RPA.PartyAccountSettlementItem AS PSI INNER JOIN
                         RPA.vwPartyAccountSettlement AS PS 
						 ON PSI.PartyAccountSettlementRef = PS.PartyAccountSettlementID 
						 INNER JOIN
                         GNR.Currency AS C
						 ON PSI.CurrencyRef = C.CurrencyID 
						 LEFT OUTER JOIN
                         SLS.vwReturnedInvoice RI 
						 ON PSI.CreditEntityRef = RI.ReturnedInvoiceId and PSI.CreditEntityType = 22 
						 LEFT OUTER JOIN
						 SLS.fnReturnedInvoiceRemaining() RIRemaining 
						 ON RIRemaining.ReturnedInvoiceId = RI.ReturnedInvoiceId
						 LEFT OUTER JOIN						 
                         RPA.vwReceiptHeader AS RH 
						 ON PSI.CreditEntityRef = RH.ReceiptHeaderId AND PSI.CreditEntityType = 23 LEFT OUTER JOIN
						 RPA.fnReceiptRemaining() ReceiptRemaining 
						 ON ReceiptRemaining.ReceiptHeaderId = RH.ReceiptHeaderId
						 LEFT OUTER JOIN
						 GNR.PartyOpeningBalance POB 
						 ON PSI.CreditEntityRef = POB.PartyOpeningBalanceID AND PSI.CreditEntityType = 24 AND OpeningBalanceType = 2 
						 LEFT OUTER JOIN						 
						 GNR.fnCreditOpeningBalanceRemaining(0) CreditOpeningBalanceRemainingCustomer 
						 ON CreditOpeningBalanceRemainingCustomer.PartyOpeningBalanceID = POB.PartyOpeningBalanceID
						 LEFT OUTER JOIN
						 GNR.fnCreditOpeningBalanceRemaining(1) CreditOpeningBalanceRemainingVendor 
						 ON CreditOpeningBalanceRemainingVendor.PartyOpeningBalanceID = POB.PartyOpeningBalanceID
						 LEFT OUTER JOIN
						 GNR.fnCreditOpeningBalanceRemaining(2) CreditOpeningBalanceRemainingBroker 
						 ON CreditOpeningBalanceRemainingBroker.PartyOpeningBalanceID = POB.PartyOpeningBalanceID 
						 LEFT OUTER JOIN
						 GNR.vwDebitCreditNote DCN 
						 ON PSI.CreditEntityRef = DCN.DebitCreditNoteID AND PSI.CreditEntityType = 25 
						 OUTER apply	
						( 
							SELECT * FROM GNR.fnCreditNoteRemaining(PS.PartyDlRef,2)  CreditNoteRemainingCustomer
						    WHERE CreditNoteRemainingCustomer.DebitCreditNoteID = DCN.DebitCreditNoteID
						 ) AS CreditNoteRemainingCustomer
						 OUTER apply	
						 (
							SELECT * FROM GNR.fnCreditNoteRemaining(PS.PartyDlRef,4)  CreditNoteRemainingBroker
						    WHERE CreditNoteRemainingBroker.DebitCreditNoteID = DCN.DebitCreditNoteID 
						 ) AS CreditNoteRemainingBroker
						 OUTER apply
						 (
						    SELECT * FROM GNR.fnCreditNoteRemaining(PS.PartyDlRef,1) CreditNoteRemainingVendor 
						    WHERE CreditNoteRemainingVendor.DebitCreditNoteID = DCN.DebitCreditNoteID 
						 ) AS CreditNoteRemainingVendor
						 LEFT OUTER JOIN	
						 RPA.vwRefundCheque RC ON PSI.CreditEntityRef = RC.RefundChequeId AND PSI.CreditEntityType = 26 AND RC.Type = 2 LEFT OUTER JOIN
						 RPA.fnRefundPaymentChequeRemaining(1) RefundPaymentChequeRemainingCustomer 
						 ON RefundPaymentChequeRemainingCustomer.RefundChequeId = RC.RefundChequeId 
						 LEFT OUTER JOIN
						 RPA.fnRefundPaymentChequeRemaining(128) RefundPaymentChequeRemainingBroker 
						 ON RefundPaymentChequeRemainingBroker.RefundChequeId = RC.RefundChequeId 
						 LEFT OUTER JOIN
						 RPA.fnRefundPaymentChequeRemaining(256) RefundPaymentChequeRemainingVendor 
						 ON RefundPaymentChequeRemainingVendor.RefundChequeId = RC.RefundChequeId 
						 LEFT OUTER JOIN
						 RPA.vwRefundCheque RCO 
						 ON PSI.CreditEntityRef = RCO.RefundChequeId AND PSI.CreditEntityType = 27 AND RC.Type = 4
						 LEFT OUTER JOIN
						 RPA.fnReturnChequeOtherRemaining(1) ReturnChequeOtherRemainingCustomer 
						 ON ReturnChequeOtherRemainingCustomer.RefundChequeId = RCO.RefundChequeId
						 LEFT OUTER JOIN
						 RPA.fnReturnChequeOtherRemaining(8) ReturnChequeOtherRemainingBroker 
						 ON ReturnChequeOtherRemainingBroker.RefundChequeId = RCO.RefundChequeId 
						 LEFT OUTER JOIN
						 RPA.fnReturnChequeOtherRemaining(16) ReturnChequeOtherRemainingVendor 
						 ON ReturnChequeOtherRemainingVendor.RefundChequeId = RCO.RefundChequeId
						 LEFT OUTER JOIN						 
						 SLS.vwCommissionCalculation CC 
						 ON PSI.CreditEntityRef = CC.CommissionCalculationID and PSI.CreditEntityType = 21 
						 LEFT OUTER JOIN
						 SLS.fnCommissionCalculationRemaining() CommissionCalculationRemaining 
						 ON CommissionCalculationRemaining.CommissionCalculationID = CC.CommissionCalculationID
						 where DebitEntityType IS NULL

						 