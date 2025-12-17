IF OBJECT_ID('SLS.vwCommissionCalculationItem') IS NOT NULL
	DROP VIEW SLS.vwCommissionCalculationItem
GO
CREATE VIEW SLS.vwCommissionCalculationItem
AS
 SELECT  CCI.CommissionCalculationItemID
     ,CCI.CommissionCalculationRef
     ,CCI.ItemRef
     ,CCI.InvoiceRef
     ,CCI.ReturnedInvoiceRef
     ,CCI.IsExtraReturnedInvoice
     ,InvoiceNumber   = CASE
                           WHEN CCI.InvoiceRef         IS NOT NULL THEN Inv.Number
                           WHEN CCI.ReturnedInvoiceRef IS NOT NULL THEN RInv.Number
                        END
     ,InvoiceDate     = CASE
                           WHEN CCI.InvoiceRef         IS NOT NULL THEN Inv.Date
                           WHEN CCI.ReturnedInvoiceRef IS NOT NULL THEN RInv.Date
                        END
     ,InvoicePrice    = CASE
                           WHEN CCI.InvoiceRef          IS NOT NULL THEN inv.Price
                           WHEN CCI.ReturnedInvoiceRef  IS NOT NULL THEN RInv.Price
                        END
     ,InvoicePriceInBaseCurrency = CASE
		                              WHEN CCI.InvoiceRef          IS NOT NULL THEN inv.PriceInBaseCurrency
		                              WHEN CCI.ReturnedInvoiceRef  IS NOT NULL THEN RInv.PriceInBaseCurrency
		                           END
     ,InvoiceNetPrice = CASE
                           WHEN CCI.InvoiceRef         IS NOT NULL THEN Inv.NetPrice
                           WHEN CCI.ReturnedInvoiceRef IS NOT NULL THEN RInv.NetPrice
                        END
     ,InvoiceNetPriceInBaseCurrency = CASE
		                                 WHEN CCI.InvoiceRef          IS NOT NULL THEN inv.NetPriceInBaseCurrency
		                                 WHEN CCI.ReturnedInvoiceRef  IS NOT NULL THEN RInv.NetPriceInBaseCurrency
		                              END
     ,InvoiceDiscount    = CASE
                              WHEN CCI.InvoiceRef          IS NOT NULL THEN inv.Discount
                              WHEN CCI.ReturnedInvoiceRef  IS NOT NULL THEN RInv.Discount
                           END
     ,InvoiceDiscountInBaseCurrency = CASE
		                                 WHEN CCI.InvoiceRef          IS NOT NULL THEN inv.DiscountInBaseCurrency
		                                 WHEN CCI.ReturnedInvoiceRef  IS NOT NULL THEN RInv.DiscountInBaseCurrency
		                              END
     ,InvoiceAddition    = CASE
                          WHEN CCI.InvoiceRef          IS NOT NULL THEN inv.Addition
                          WHEN CCI.ReturnedInvoiceRef  IS NOT NULL THEN RInv.Addition
                         END
     ,InvoiceAdditionInBaseCurrency = CASE
		                                 WHEN CCI.InvoiceRef          IS NOT NULL THEN inv.AdditionFactorInBaseCurrency
		                                 WHEN CCI.ReturnedInvoiceRef  IS NOT NULL THEN RInv.AdditionFactorInBaseCurrency
		                              END
     ,InvoiceTax    = CASE
                          WHEN CCI.InvoiceRef          IS NOT NULL THEN inv.Tax
                          WHEN CCI.ReturnedInvoiceRef  IS NOT NULL THEN RInv.Tax
                         END
     ,InvoiceTaxInBaseCurrency = CASE
		                            WHEN CCI.InvoiceRef          IS NOT NULL THEN inv.TaxInBaseCurrency
		                            WHEN CCI.ReturnedInvoiceRef  IS NOT NULL THEN RInv.TaxInBaseCurrency
		                         END
     ,InvoiceDuty    = CASE
                          WHEN CCI.InvoiceRef          IS NOT NULL THEN inv.Duty
                          WHEN CCI.ReturnedInvoiceRef  IS NOT NULL THEN RInv.Duty
                         END
     ,InvoiceDutyInBaseCurrency = CASE
		                             WHEN CCI.InvoiceRef          IS NOT NULL THEN inv.DutyInBaseCurrency
		                             WHEN CCI.ReturnedInvoiceRef  IS NOT NULL THEN RInv.DutyInBaseCurrency
		                          END
     ,ItemTitle = I.Title
     ,ItemTitle_En = I.Title_En
     ,ItemCode = I.Code
     ,CCI.Amount
      ,InvoiceType      = CASE
                           WHEN CCI.InvoiceRef         IS NOT NULL THEN 1
                           WHEN CCI.ReturnedInvoiceRef IS NOT NULL THEN 2
                         END
     ,CustomerName     = CASE
                           WHEN CCI.InvoiceRef         IS NOT NULL THEN Inv.CustomerPartyName
                           WHEN CCI.ReturnedInvoiceRef IS NOT NULL THEN RInv.CustomerPartyName
                         END
     ,CustomerName_En  = CASE
                           WHEN CCI.InvoiceRef         IS NOT NULL THEN Inv.CustomerPartyName_En
                           WHEN CCI.ReturnedInvoiceRef IS NOT NULL THEN RInv.CustomerPartyName_En
                         END
      ,SettlementAmount = CASE
                           WHEN CCI.InvoiceRef         IS NOT NULL THEN Inv.TotalReceivedAmount
                           WHEN CCI.ReturnedInvoiceRef IS NOT NULL THEN RInv.PaymentTotalAmount
                         END
 FROM      SLS.CommissionCalculationItem CCI
 LEFT JOIN SLS.vwInvoice Inv
   ON CCI.InvoiceRef         = Inv.InvoiceId
 LEFT JOIN SLS.vwReturnedInvoice RInv
   ON CCI.ReturnedInvoiceRef = RInv.ReturnedInvoiceId
 LEFT JOIN INV.Item I
   ON CCI.ItemRef            = I.ItemID
GO
