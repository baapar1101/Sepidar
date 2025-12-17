IF OBJECT_ID('SLS.vwCommissionCalculationInvoice') IS NOT NULL
	DROP VIEW SLS.vwCommissionCalculationInvoice
GO
CREATE VIEW SLS.vwCommissionCalculationInvoice
AS
	SELECT  CCIn.CommissionCalculationInvoiceID 
		   ,CCIn.CommissionCalculationRef 
		   ,CCIn.InvoiceItemRef 
		   ,CCIn.ReturnedInvoiceItemRef
		   ,II.InvoiceRef
		   ,b2.ReturnedInvoiceRef
		   ,InvoiceNumber   = CASE 
		                         WHEN CCIn.InvoiceItemRef         IS NOT NULL THEN Inv.Number
		                         WHEN CCIn.ReturnedInvoiceItemRef IS NOT NULL THEN RInv.Number
		                      END
		   ,InvoiceDate     = CASE 
		                         WHEN CCIn.InvoiceItemRef         IS NOT NULL THEN Inv.Date
		                         WHEN CCIn.ReturnedInvoiceItemRef IS NOT NULL THEN RInv.Date
		                      END
		   ,SalePortionPercent  = CASE WHEN com.CalculationBase = 5 --Manual 
											THEN NULL
										ELSE 
											 ISNULL(icb.SalePortionPercent, ricb.SalePortionPercent)
								   END
		   ,InvoiceItemQuantity =
		                       CASE 
		                         WHEN CCIn.InvoiceItemRef         IS NOT NULL THEN II.Quantity
		                         WHEN CCIn.ReturnedInvoiceItemRef IS NOT NULL THEN b2.Quantity
		                       END
		   ,ReturnedInvoiceItemQuantity = ISNULL(BaseInvoiceItemQuantity, 0)
		   ,InvoiceItemPrice =
		                       CASE 
		                         WHEN CCIn.InvoiceItemRef         IS NOT NULL THEN II.NetPriceInBaseCurrency - II.TaxInBaseCurrency - II.DutyInBaseCurrency
		                         WHEN CCIn.ReturnedInvoiceItemRef IS NOT NULL THEN b2.NetPriceInBaseCurrency - b2.TaxInBaseCurrency - b2.DutyInBaseCurrency
		                       END
		   ,ReturnedInvoiceItemPrice = ISNULL(BaseInvoiceItemPrice, 0)
		   ,ItemRef         = CASE 
		                         WHEN CCIn.InvoiceItemRef         IS NOT NULL THEN II.ItemRef
		                         WHEN CCIn.ReturnedInvoiceItemRef IS NOT NULL THEN b2.ItemRef
		                      END
			,ItemCode       = CASE 
		                         WHEN CCIn.InvoiceItemRef         IS NOT NULL THEN IIItem.Code
		                         WHEN CCIn.ReturnedInvoiceItemRef IS NOT NULL THEN RIIItem.Code
		                      END
		   ,ItemTitle       = CASE 
		                         WHEN CCIn.InvoiceItemRef         IS NOT NULL THEN IIItem.Title
		                         WHEN CCIn.ReturnedInvoiceItemRef IS NOT NULL THEN RIIItem.Title
		                      END
		  ,InvoiceType      = CASE 
		                         WHEN CCIn.InvoiceItemRef         IS NOT NULL THEN 1
		                         WHEN CCIn.ReturnedInvoiceItemRef IS NOT NULL THEN 2
		                      END
	FROM      SLS.CommissionCalculationInvoice CCIn
	LEFT JOIN SLS.InvoiceItem                  II ON CCIn.InvoiceItemRef         = II.InvoiceItemId
	LEFT JOIN SLS.ReturnedInvoiceItem          b2 ON CCIn.ReturnedInvoiceItemRef = b2.ReturnedInvoiceItemID
	LEFT JOIN SLS.Invoice                      Inv ON II.InvoiceRef            = Inv.InvoiceId
	LEFT JOIN SLS.ReturnedInvoice              RInv ON b2.ReturnedInvoiceRef    = RInv.ReturnedInvoiceId
	LEFT JOIN INV.Item                         IIItem ON ISNULL(II.ItemRef, -1)   = IIItem.ItemID
	LEFT JOIN INV.Item                         RIIItem ON ISNULL(b2.ItemRef, -1)   = RIIItem.ItemID
	LEFT JOIN SLS.CommissionCalculation		      cc   ON CCIn.CommissionCalculationRef = cc.CommissionCalculationID
	LEFT JOIN SLS.InvoiceItem /*ReturnBaseIrem*/  rii  ON b2.InvoiceItemRef          = rii.InvoiceItemID
	LEFT JOIN SLS.InvoiceCommissionBroker         icb  ON icb .PartyRef = cc.BrokerPartyRef AND (icb .InvoiceRef         = II.InvoiceRef OR icb.InvoiceRef = rii.InvoiceRef)
	LEFT JOIN SLS.ReturnedInvoiceCommissionBroker ricb ON ricb.PartyRef = cc.BrokerPartyRef AND (ricb.ReturnedInvoiceRef = b2.ReturnedInvoiceRef)
	LEFT JOIN SLS.Commission com ON com.CommissionId = cc.CommissionRef
	LEFT JOIN (
	            SELECT  BaseInvoiceItemRef      = InvoiceItemRef   
					,BaseInvoiceItemQuantity = SUM(Quantity)  
					,BaseInvoiceItemPrice    = SUM(NetPriceInBaseCurrency - TaxInBaseCurrency - DutyInBaseCurrency)  
             FROM SLS.ReturnedInvoiceItem  
             WHERE InvoiceItemRef IS NOT NULL
             GROUP BY InvoiceItemRef    
           )R ON CCIn.InvoiceItemRef = R.BaseInvoiceItemRef  
GO
