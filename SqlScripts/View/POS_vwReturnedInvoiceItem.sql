If Object_ID('POS.vwReturnedInvoiceItem') Is Not Null
	Drop View POS.vwReturnedInvoiceItem
GO
Create VIEW [POS].[vwReturnedInvoiceItem]
AS
SELECT     II.ReturnedInvoiceItemID, II.ReturnedInvoiceRef, II.RowID, II.ItemRef, I.Type AS ItemType, I.TaxExempt ItemTaxExempt ,
                      I.Code AS ItemCode, I.Title AS ItemTitle, I.Title_En AS ItemTitle_En, I.BarCode AS ItemBarCode,   
                      I.UnitRef AS ItemUnitRef, I.SecondaryUnitRef AS ItemSecondaryUnitRef,I.UnitsRatio AS ItemUnitsRatio, U.Title AS ItemUnitTitle, U.Title_En AS ItemUnitTitle_En, U2.Title AS ItemSecondaryUnitTitle, II.TracingRef, 
                      T.Title AS TracingTitle, I.TracingCategoryRef , II.Quantity, II.SecondaryQuantity, II.Fee, II.Price, II.Discount,   
                      II.Addition, II.Tax, II.Duty, II.NetPrice, 
					  isnull(PN.CanChangeInvoiceFee, 1) PriceNoteCanChangeInvoiceFee, 
					  isnull(PN.CanChangeInvoiceDiscount, 1) PriceNoteCanChangeInvoiceDiscount,
					  PN.Discount PriceNoteDiscountRate
FROM				  POS.ReturnedInvoiceItem II INNER JOIN  
					  POS.ReturnedInvoice INV ON INV.ReturnedInvoiceID = II.ReturnedInvoiceRef LEFT JOIN  
					  SLS.PriceNoteItem PN ON PN.SaleTypeRef = INV.SaleTypeRef AND INV.CurrencyRef = PN.CurrencyRef AND II.ItemRef = PN.ItemRef AND 
							PN.CustomerGroupingRef IS NULL AND ISNULL(PN.TracingRef,0) = ISNULL(II.TracingRef,0) Left JOIN  
                      INV.Tracing T ON II.TracingRef = T.TracingID INNER JOIN  
                      INV.Item I ON II.ItemRef = I.ItemID INNER JOIN  
                      INV.Unit U ON I.UnitRef = U.UnitID Left outer join 
                      INV.Unit U2 ON I.SecondaryUnitRef = U2.UnitID Left outer join 
                      INV.TracingCategory AS TC ON I.TracingCategoryRef = TC.TracingCategoryID 



