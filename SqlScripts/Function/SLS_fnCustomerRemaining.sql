
IF Object_ID('SLS.fnCustomerRemaining') IS NOT NULL
	DROP FUNCTION [SLS].[fnCustomerRemaining]
GO


CREATE FUNCTION SLS.fnCustomerRemaining (
    @FiscalYearRef INT
   ,@FromDate DATETIME
   ,@ToDate DATETIME
   ,@ItemId INT = -1
   ,@StockId INT = -1
   ,@TracingId INT = -1
   ,@QuotationId INT = -1
   ,@InvoiceBrockerPartyId INT = -1
  )
RETURNS TABLE
AS
RETURN  
 

SELECT Party.PartyId, Party.DLRef, Party.DLCode, Party.DlTitle, DlTitle_En,
       Party.MaximumCredit, 
	   Party.MaximumQuantityCredit,
       Party.CustomerGroupingTitle, Party.CustomerGroupingTitle_En, Party.CustomerGroupingCode,
       FirstAmount = CASE WHEN(Party.CustomerOpeningBalanceType=1) 
                          THEN ISNULL(Party.CustomerOpeningBalance, 0) 
                          ELSE -1*ISNULL(Party.CustomerOpeningBalance, 0)
                     END  
                         + ISNULL(Invoice.FirstInvoiceNetPrice,0)
                         - ISNULL(ReturnedInvoice.FirstReturnedInvoiceNetPrice, 0) 
                         -(ISNULL(Receipt.FirstReceiptPrice, 0) 
                             + ISNULL(Receipt.FirstReceiptDiscountPrice, 0) 
                             - ISNULL(FirstPaymentPrice, 0)
                             - ISNULL(FirstPaymentDiscountPrice,0) 
                             - ISNULL(Refund.FirstRefundAmount, 0) 
                             + ISNULL(PaymentRefund.FirstPaymentRefundAmount, 0)) 
                         +(ISNULL(DebitItem.FirstDebitPrice, 0)
                         -ISNULL(CreditItem.FirstCreditPrice, 0)),
       InvoiceNetPrice = ISNULL(Invoice.InvoiceNetPrice, 0),
       ReturnedInvoiceNetPrice = -ISNULL(ReturnedInvoice.ReturnedInvoiceNetPrice, 0) ,
       ReceiptPrice = -(ISNULL(Receipt.ReceiptPrice, 0) 
		                + ISNULL(PaymentRefund.PaymentRefundAmount, 0) 
						+ ISNULL(Receipt.ReceiptDiscountPrice, 0)),
       PaymentPrice = (ISNULL(RefundAmount, 0)
	                   + ISNULL(Payment.PaymentPrice, 0) 
					   + ISNULL(Payment.PaymentDiscountPrice, 0)),
       Transfer = ISNULL(DebitItem.DebitPrice, 0)
	              - ISNULL(CreditItem.CreditPrice, 0),
       ShredInterestPenalty = ISNULL(Shred.ShredInterestPenalty,0),
       Remain = CASE WHEN (Party.CustomerOpeningBalanceType=1) 
				     THEN ISNULL(Party.CustomerOpeningBalance, 0) 
					 ELSE -1 * ISNULL(Party.CustomerOpeningBalance, 0)
			    END 
                + ISNULL(Invoice.FirstInvoiceNetPrice,0)
				- ISNULL(ReturnedInvoice.FirstReturnedInvoiceNetPrice, 0) 
                - (ISNULL(Receipt.FirstReceiptPrice, 0) 
				   + ISNULL(Receipt.FirstReceiptDiscountPrice, 0) 
				   - ISNULL(FirstPaymentPrice, 0)
				   - ISNULL(FirstPaymentDiscountPrice,0)
				   - ISNULL(Refund.FirstRefundAmount, 0) 
				   + ISNULL(PaymentRefund.FirstPaymentRefundAmount, 0)) 
                + (ISNULL(DebitItem.FirstDebitPrice, 0)
				   - ISNULL(CreditItem.FirstCreditPrice, 0)) 
                + (ISNULL(Invoice.InvoiceNetPrice, 0)
				   - ISNULL(ReturnedInvoice.ReturnedInvoiceNetPrice, 0))
                - (ISNULL(Receipt.ReceiptPrice, 0) 
				   + ISNULL(Receipt.ReceiptDiscountPrice, 0) 
				   + ISNULL(PaymentRefund.PaymentRefundAmount, 0)
				   - ISNULL(RefundAmount, 0)
				   - ISNULL(Payment.PaymentPrice, 0)
				   - ISNULL(Payment.PaymentDiscountPrice, 0))
                + (ISNULL(DebitItem.DebitPrice, 0)
				   - ISNULL(CreditItem.CreditPrice, 0)
                   + ISNULL(Shred.ShredInterestPenalty,0)) 
FROM 
     (
	  SELECT poc.OpeningBalance CustomerOpeningBalance,
             poc.OpeningBalanceType CustomerOpeningBalanceType,
             pov.OpeningBalance VendorOpeningBalance,
             pov.OpeningBalanceType VendorOpeningBalanceType,
             p.* 
	  
	  FROM        GNR.[vwParty] p 
      LEFT JOIN 
		          GNR.PartyOpeningBalance poc 
		  ON p.PartyID = poc.PartyRef  
		     AND poc.Type = 0 
			 AND poc.FiscalYearRef = @FiscalYearRef
      LEFT JOIN 
	              GNR.PartyOpeningBalance pov 
		  ON p.PartyID = pov.PartyRef  
		     AND pov.Type = 1 
			 AND pov.FiscalYearRef = @FiscalYearRef) Party 
	  LEFT OUTER JOIN
                  (
				    SELECT Invoice.CustomerPartyRef,  
                           FirstInvoiceNetPrice = ISNULL(SUM(CASE WHEN Invoice.Date < @FromDate 
					 	                                          THEN InvoiceItem.NetPriceInBaseCurrency 
					 					                          ELSE 0 
					 				                         END), 0),
                           InvoiceNetPrice = ISNULL(SUM(CASE WHEN @FromDate <= Invoice.Date AND Invoice.Date < @ToDate 
					 	                                     THEN InvoiceItem.NetPriceInBaseCurrency 
					 					                     ELSE 0 
					 			                        END), 0),
                           InvoicePrice = ISNULL(SUM(CASE WHEN @FromDate <= Invoice.Date AND Invoice.Date < @ToDate 
					 	                                  THEN InvoiceItem.PriceInBaseCurrency 
					 					                  ELSE 0 
					 			                     END), 0) 
                    
					FROM   SLS.[Invoice] Invoice 
				    JOIN   SLS.InvoiceItem InvoiceItem 
				      ON Invoice.InvoiceID = InvoiceItem.InvoiceRef
                    
					WHERE Invoice.State <> 2 
				          AND Invoice.FiscalYearRef = @FiscalYearRef 
					 	  AND (InvoiceItem.ItemRef = @ItemId OR @ItemId = -1)
                    
					GROUP BY Invoice.CustomerPartyRef
                   ) Invoice 
		   ON Party.PartyID = Invoice.CustomerPartyRef 
	   LEFT OUTER JOIN
                     SLS.[Invoice] Invoice2 
		   ON Invoice2.CustomerPartyRef = Party.PartyID 
		      AND Invoice2.FiscalYearRef = @FiscalYearRef 
	   LEFT OUTER JOIN
                    (
					 SELECT ReturnedInvoice.CustomerPartyRef,
                            FirstReturnedInvoiceNetPrice = ISNULL(SUM(CASE WHEN ReturnedInvoice.Date < @FromDate 
								             THEN ReturnedInvoiceItem.NetPriceInBaseCurrency 
											 ELSE 0 
										END), 0) ,
                            ReturnedInvoiceNetPrice = ISNULL(SUM(CASE WHEN @FromDate <= ReturnedInvoice.Date AND ReturnedInvoice.Date < @ToDate 
							                 THEN ReturnedInvoiceItem.NetPriceInBaseCurrency 
											 ELSE 0 
									    END), 0) 
                     
					 FROM 
					        SLS.ReturnedInvoice ReturnedInvoice 
					 JOIN 
					        SLS.ReturnedInvoiceItem ReturnedInvoiceItem 
						ON ReturnedInvoice.ReturnedInvoiceID = ReturnedInvoiceItem.ReturnedInvoiceRef
                     
					 WHERE FiscalYearRef = @FiscalYearRef 
					       AND (ReturnedInvoiceItem.ItemRef = @ItemId OR @ItemId = -1)
                     
					 GROUP BY ReturnedInvoice.CustomerPartyRef
                    ) ReturnedInvoice 
		 ON Party.PartyID = ReturnedInvoice.CustomerPartyRef 
	   LEFT OUTER JOIN
                    (
					 SELECT DlRef,
                           FirstReceiptPrice = ISNULL(SUM(CASE WHEN Receipt.Date < @FromDate 
						                                       THEN Receipt.TotalAmountInBaseCurrency 
															   ELSE 0 
														  END), 0),
                           ReceiptPrice = ISNULL(SUM(CASE WHEN @FromDate <= Receipt.Date AND Receipt.Date < @ToDate 
						                                  THEN Receipt.TotalAmountInBaseCurrency 
														  ELSE 0 
													 END), 0),
                           FirstReceiptDiscountPrice = ISNULL(SUM(CASE WHEN Receipt.Date < @FromDate 
						                                               THEN Receipt.DiscountInBaseCurrency 
																	   ELSE 0 
																  END), 0) ,
                           ReceiptDiscountPrice = ISNULL(SUM(CASE WHEN @FromDate <= Receipt.Date AND Receipt.Date < @ToDate 
						                                          THEN Receipt.DiscountInBaseCurrency 
																  ELSE 0 END), 0) 
                      
					  FROM RPA.ReceiptHeader  Receipt 
                      
					  WHERE Receipt.Type = 1 
					        AND State  <> 4 
							AND FiscalYearRef = @FiscalYearRef
                    
					  GROUP BY Receipt.DlRef 
                    )Receipt 
		   ON Receipt.DlRef = Party.DlRef 
	   LEFT OUTER JOIN
                      (
					   SELECT DlRef,
                               FirstPaymentPrice = ISNULL(SUM(CASE WHEN Payment.Date < @FromDate 
					 		                                      THEN Payment.TotalAmountInBaseCurrency 
					 											  ELSE 0 
					 										 END), 0),
                               PaymentPrice = ISNULL(SUM(CASE WHEN @FromDate <= Payment.Date AND Payment.Date < @ToDate 
					 		                                 THEN Payment.TotalAmountInBaseCurrency 
					 										 ELSE 0 
					 								    END), 0),
	                           FirstPaymentDiscountPrice = ISNULL(SUM(CASE WHEN Payment.Date < @FromDate 
					 		                                              THEN Payment.DiscountInBaseCurrency 
					 													  ELSE 0 
					 												 END), 0) ,
                               PaymentDiscountPrice = ISNULL(SUM(CASE WHEN @FromDate <= Payment.Date AND Payment.Date < @ToDate 
					 		                                         THEN Payment.DiscountInBaseCurrency 
					 												 ELSE 0 
					 											END), 0) 
                       
					   FROM 	RPA.PaymentHeader  Payment 
                       
					   WHERE Payment.Type = 1 
					         AND State  <> 4 
					 		AND FiscalYearRef = @FiscalYearRef
                       
					   GROUP BY DlRef
					  ) Payment 
			ON Payment.DlRef = Party.DlRef 
	  LEFT OUTER JOIN
                    (
					 SELECT ReceiptCheque.DlRef,
                            FirstRefundAmount = ISNULL(SUM(CASE WHEN Refund.HeaderDate < @FromDate 
							                                    THEN ReceiptCheque.AmountInBaseCurrency 
																ELSE 0 
														   END), 0),
                            RefundAmount = ISNULL(SUM(CASE WHEN @FromDate <= Refund.HeaderDate AND Refund.HeaderDate < @ToDate 
							                               THEN ReceiptCheque.AmountInBaseCurrency 
														   ELSE 0 
													  END), 0) 
                     
					 FROM 
					       RPA.ReceiptCheque   ReceiptCheque 
					 INNER JOIN
                         RPA.RefundChequeItem   Refund  
					   ON ReceiptCheque.ReceiptChequeID = Refund.ReceiptChequeRef   
					 INNER JOIN
                         RPA.RefundCheque   RRefund  
					   ON RRefund.RefundChequeID = Refund.RefundChequeRef   
					      AND RRefund.Type = 1 
					 INNER JOIN
                         RPA.ReceiptHeader  Receipt2 
					   ON Receipt2.ReceiptHeaderID = ReceiptCheque.ReceiptHeaderRef 
					      AND Receipt2.Type = 1 
                         --AND Receipt2.FiscalYearRef = @FiscalYearRef
                          AND RRefund.FiscalYearRef = @FiscalYearRef
                    
					GROUP BY ReceiptCheque.DlRef
                   )Refund  
			ON Refund.DlRef = Party.DlRef 
		  LEFT OUTER JOIN
                    (
					 SELECT  DlRef
					        ,FirstPaymentRefundAmount = SUM(FirstPaymentRefundAmount) 
							,PaymentRefundAmount = SUM(PaymentRefundAmount) 
                     
					 FROM
					     (
                          SELECT PaymentCheque.DlRef
						        ,FirstPaymentRefundAmount = ISNULL(SUM(CASE WHEN Refund.HeaderDate < @FromDate 
								                 THEN PaymentCheque.AmountInBaseCurrency 
												 ELSE 0 
											END), 0)
								,PaymentRefundAmount = ISNULL(SUM(CASE WHEN @FromDate <= Refund.HeaderDate AND Refund.HeaderDate < @ToDate 
								                 THEN PaymentCheque.AmountInBaseCurrency 
												 ELSE 0 
											END), 0) 
                         
						  FROM 
						         RPA.PaymentCheque   PaymentCheque 
						  INNER JOIN
                                 RPA.RefundChequeItem   Refund  
						    ON PaymentCheque.PaymentChequeID = Refund.PaymentChequeRef   
						  INNER JOIN
                                 RPA.PaymentHeader  Payment2 
						    ON Payment2.PaymentHeaderID = PaymentCheque.PaymentHeaderRef 
						       AND Payment2.Type = 1 
						  INNER JOIN
                                 RPA.RefundCheque   RRefund  
						    ON RRefund.RefundChequeID = Refund.RefundChequeRef   
						       AND RRefund.Type = 2
                               AND  RRefund.FiscalYearRef = @FiscalYearRef
                               --AND Payment2.FiscalYearRef = @FiscalYearRef
                        
					      GROUP BY PaymentCheque.DlRef
                          
                          UNION ALL
                          
					      SELECT  RefC.DlRef
					             ,FirstRefundAmount = ISNULL(SUM(CASE WHEN RefCI.HeaderDate < @FromDate 
					  		                                          THEN ReceiptCheque.AmountInBaseCurrency 
					  		      									  ELSE 0 
					  		      								 END), 0)
					  	         ,RefundAmount = ISNULL(SUM(CASE WHEN @FromDate <= RefCI.HeaderDate AND RefCI.HeaderDate < @ToDate 
					  		                                     THEN ReceiptCheque.AmountInBaseCurrency 
					  		 				                     ELSE 0 
					  		 			                    END), 0) 
                        
						  FROM 
						      RPA.RefundChequeItem   RefCI 
						  INNER JOIN
						      RPA.RefundCheque   RefC  
						    ON RefC.RefundChequeID = RefCI.RefundChequeRef   
						       AND RefC.Type = 4 
						  INNER JOIN
						      RPA.ReceiptCheque   ReceiptCheque  
						    ON  RefCI.ReceiptChequeRef = ReceiptCheque.ReceiptChequeID
						     
						  WHERE EXISTS 
						               (SELECT 1 
						                FROM FMK.FiscalYear F 
						  			  WHERE F.FiscalYearId = @FiscalYearRef 
						  			        AND RefC.Date >= F.StartDate 
						  					AND RefC.Date <= F.EndDate)
                                AND EXISTS 
						  	              (SELECT * 
						  	               FROM 
						                          RPA.PaymentChequeOther  PCO 
						                     INNER JOIN 
						  				        RPA.PaymentHeader Payment 
						  				     ON PCO.PaymentHeaderRef = Payment.PaymentHeaderId 
						                     WHERE PCO.ReceiptChequeRef = ReceiptCheque.ReceiptChequeId 
						  				         AND Payment.Type = 1 
						  						 AND Payment.DlRef = RefC.DlRef )
                          
						  GROUP BY RefC.DlRef
                        
					     )UnifiedPaymentRefund
                    
					 GROUP BY DlRef
                    
				   )PaymentRefund  
			ON PaymentRefund.DlRef = Party.DlRef 
LEFT OUTER JOIN
          (
		   SELECT  DebitItem.DebitDlRef
		          ,FirstDebitPrice = ISNULL(SUM(CASE WHEN Debit.Date < @FromDate 
		  		                 THEN DebitItem.AmountInBaseCurrency 
		  						 ELSE 0 
		  					END), 0)  
		  		  ,DebitPrice = ISNULL(SUM(CASE WHEN @FromDate <= Debit.Date AND Debit.Date < @ToDate 
		  		                 THEN DebitItem.AmountInBaseCurrency 
		  						 ELSE 0 
		  					END), 0)  
             FROM 
		         Gnr.DebitCreditNoteItem DebitItem 
		   INNER JOIN
                   Gnr.DebitCreditNote Debit 
		     ON DebitItem.DebitCreditNoteRef = Debit.DebitCreditNoteId
		   
             WHERE DebitItem.DebitType = 2 
		         AND Debit.FiscalYearRef = @FiscalYearRef
            
		   GROUP BY DebitItem.DebitDlRef 
		 ) DebitItem 
  ON DebitItem.DebitDlRef = Party.DlRef 
LEFT OUTER JOIN
          (
		   SELECT  CreditItem.CreditDlRef
		          ,FirstCreditPrice = ISNULL(SUM(CASE WHEN Credit.Date < @FromDate 
		  		                                    THEN CreditItem.AmountInBaseCurrency 
		  					                   	 ELSE 0 
		  					                   END), 0)
                  ,CreditPrice = ISNULL(SUM(CASE WHEN @FromDate <= Credit.Date AND Credit.Date < @ToDate 
		  		                               THEN CreditItem.AmountInBaseCurrency 
		  									   ELSE 0 
		  								  END), 0)  
             
		   FROM 
		       Gnr.DebitCreditNoteItem CreditItem 
             INNER JOIN
		       Gnr.DebitCreditNote Credit 
		     ON CreditItem.DebitCreditNoteRef = Credit.DebitCreditNoteId 
                 
		   WHERE CreditItem.CreditType = 2 
		         AND Credit.FiscalYearRef = @FiscalYearRef
             
		   GROUP BY CreditItem.CreditDlRef
		  ) CreditItem
  ON CreditItem.CreditDlRef = Party.DlRef   
LEFT OUTER JOIN         
     (
	  SELECT  S.DLRef
	         ,ShredInterestPenalty = SUM(ISNULL(SI.InterestAmount,0)) + SUM(ISNULL(SI.PenaltyAmount,0))  
	  
	  FROM 
	       GNR.Shred S
	  JOIN 
	       GNR.ShredItem SI 
	    ON SI.ShredRef = S.ShredID 
            JOIN 
	       FMK.FiscalYear F 
	    ON F.StartDate <= S.Date 
		   AND F.EndDate >= S.Date
	  
	   WHERE S.[Key] = 1 
	         AND S.Date >= @FromDate 
			 AND S.Date < @ToDate 
			 AND F.FiscalYearId = @FiscalYearRef
	   
	   GROUP BY S.DLRef
	 
	 )Shred 
  ON Shred.DLRef = Party.DLRef 
LEFT OUTER JOIN
          SLS.[InvoiceItem] InvoiceItem 
  ON InvoiceItem.InvoiceRef = Invoice2.InvoiceID 
LEFT OUTER JOIN
                 INV.[vwItem] Item 
  ON Item.ItemId = InvoiceItem.ItemRef 
LEFT OUTER JOIN
                SLS.InvoiceBroker InvoiceBroker 
  ON Invoice2.InvoiceId = InvoiceBroker.InvoiceRef
          
WHERE        (Item.ItemId = @ItemId OR @ItemID = -1)
             AND   (InvoiceItem.StockRef = @StockId OR @StockId = -1)
             AND   (InvoiceItem.TracingRef = @TracingId OR @TracingId = -1)
             AND   (Invoice2.QuotationRef = @QuotationId OR @QuotationId = -1)
             AND   (InvoiceBroker.PartyRef = @InvoiceBrockerPartyId OR @InvoiceBrockerPartyId = -1)
            
GROUP BY  Party.PartyId, Party.DLRef, Party.DLCode, Party.DlTitle, DlTitle_En, Party.MaximumCredit,Party.MaximumQuantityCredit,
          Party.CustomerOpeningBalance,	Invoice.FirstInvoiceNetPrice ,	ReturnedInvoice.FirstReturnedInvoiceNetPrice,
          Receipt.FirstReceiptPrice, Receipt.FirstReceiptDiscountPrice, FirstPaymentPrice  ,FirstPaymentDiscountPrice  ,Refund.FirstRefundAmount ,
          DebitItem.FirstDebitPrice  ,	CreditItem.FirstCreditPrice,
          Invoice.InvoiceNetPrice, Invoice.InvoicePrice, ReturnedInvoice.ReturnedInvoiceNetPrice,
          Receipt.ReceiptPrice,	Receipt.ReceiptDiscountPrice, RefundAmount , 	Payment.PaymentPrice , Payment.PaymentDiscountPrice ,
          DebitItem.DebitPrice , CreditItem.CreditPrice, Party.CustomerOpeningBalanceType,
          PaymentRefundAmount, PaymentRefund.FirstPaymentRefundAmount,
		  Party.CustomerGroupingTitle, Party.CustomerGroupingTitle_En, Party.CustomerGroupingCode,
          Shred.ShredInterestPenalty
HAVING
       ISNULL(Party.CustomerOpeningBalance, 0) > 0  OR
       ISNULL(Invoice.FirstInvoiceNetPrice,0) > 0  OR
       ISNULL(ReturnedInvoice.FirstReturnedInvoiceNetPrice, 0) > 0  OR
       ISNULL(Receipt.FirstReceiptPrice, 0) > 0  OR
       ISNULL(FirstPaymentPrice, 0) > 0  OR
       ISNULL(Refund.FirstRefundAmount, 0) > 0  OR
       ISNULL(DebitItem.FirstDebitPrice, 0) > 0  OR
       ISNULL(CreditItem.FirstCreditPrice, 0) > 0  OR
       ISNULL(Invoice.InvoiceNetPrice, 0) > 0  OR
       ISNULL(ReturnedInvoice.ReturnedInvoiceNetPrice, 0) > 0 OR
       ISNULL(Receipt.ReceiptPrice, 0) > 0 OR
       ISNULL(RefundAmount, 0)> 0 OR 
       ISNULL(Payment.PaymentPrice, 0) > 0 OR
       ISNULL(DebitItem.DebitPrice, 0) > 0 OR
       ISNULL(CreditItem.CreditPrice, 0) > 0 OR
       ISNULL(Invoice.InvoicePrice, 0) > 0 OR
       ISNULL(RefundAmount, 0) > 0 OR
       ISNULL(PaymentRefundAmount, 0)> 0 OR 
       ISNULL(PaymentRefund.FirstPaymentRefundAmount, 0) > 0 OR
       ISNULL(Shred.ShredInterestPenalty,0) > 0