UPDATE SLS.QuotationItem
SET 
	CustomerDiscountRate = ROUND(CASE WHEN (CustomerDiscountRate + PriceInfoDiscountRate+ AggregateAmountDiscountRate) = 0 THEN 
																((Discount - PriceInfoPriceDiscount- AggregateAmountPriceDiscount) / (Fee * Quantity)) *100
									  ELSE (((Discount - PriceInfoPriceDiscount - AggregateAmountPriceDiscount) / (Fee * Quantity)) *100) * 
										   (CustomerDiscountRate / (CustomerDiscountRate + PriceInfoDiscountRate+ AggregateAmountDiscountRate))
									  END,2
								) ,
	PriceInfoDiscountRate = ROUND(CASE WHEN (CustomerDiscountRate + PriceInfoDiscountRate+ AggregateAmountDiscountRate) = 0 THEN 0
									  ELSE (((Discount - PriceInfoPriceDiscount-AggregateAmountPriceDiscount) / (Fee * Quantity)) *100) * 
										   (PriceInfoDiscountRate / (CustomerDiscountRate + PriceInfoDiscountRate+AggregateAmountDiscountRate))
									  END,2
								)

UPDATE SLS.InvoiceItem
SET 
	CustomerDiscountRate = ROUND(CASE WHEN (CustomerDiscountRate + PriceInfoDiscountRate+AggregateAmountDiscountRate) = 0 THEN 
													((Discount - PriceInfoPriceDiscount-AggregateAmountPriceDiscount) / (Fee * Quantity)) *100
									  ELSE (((Discount - PriceInfoPriceDiscount-AggregateAmountPriceDiscount) / (Fee * Quantity)) *100) * 
										   (CustomerDiscountRate / (CustomerDiscountRate + PriceInfoDiscountRate+AggregateAmountDiscountRate))
									  END,2
								) ,
	PriceInfoDiscountRate = ROUND(CASE WHEN (CustomerDiscountRate + PriceInfoDiscountRate+AggregateAmountDiscountRate) = 0 THEN 0
									  ELSE (((Discount - PriceInfoPriceDiscount-AggregateAmountPriceDiscount) / (Fee * Quantity)) *100) * 
										   (PriceInfoDiscountRate / (CustomerDiscountRate + PriceInfoDiscountRate+AggregateAmountDiscountRate))
									  END,2
								)

UPDATE SLS.ReturnedInvoiceItem
SET CustomerDiscountRate = ROUND(CASE WHEN (CustomerDiscountRate + PriceInfoDiscountRate+AggregateAmountDiscountRate) = 0 THEN 
													((Discount - PriceInfoPriceDiscount-AggregateAmountPriceDiscount) / (Fee * Quantity)) *100
									  ELSE (((Discount - PriceInfoPriceDiscount-AggregateAmountPriceDiscount) / (Fee * Quantity)) *100) * 
										   (CustomerDiscountRate / (CustomerDiscountRate + PriceInfoDiscountRate+AggregateAmountDiscountRate))
									  END,2
								) ,
	PriceInfoDiscountRate = ROUND(CASE WHEN (CustomerDiscountRate + PriceInfoDiscountRate+AggregateAmountDiscountRate) = 0 THEN 0
									  ELSE (((Discount - PriceInfoPriceDiscount-AggregateAmountPriceDiscount) / (Fee * Quantity)) *100) * 
										   (PriceInfoDiscountRate / (CustomerDiscountRate + PriceInfoDiscountRate+AggregateAmountDiscountRate))
									  END,2
								)

UPDATE II
SET PriceInfoPercentDiscount = ROUND((PriceInfoDiscountRate * II.Price)/100,C.PrecisionCount)
FROM SLS.InvoiceItem II
	JOIN SLS.Invoice I ON II.InvoiceRef = I.InvoiceId
	JOIN GNR.Currency C ON I.CurrencyRef = C.CurrencyID
WHERE ABS(PriceInfoPercentDiscount - ((II.PriceInfoDiscountRate * II.Price)/100)) > 1

UPDATE QI
SET PriceInfoPercentDiscount = ROUND((PriceInfoDiscountRate * QI.Price)/100,C.PrecisionCount)
FROM SLS.QuotationItem QI
	JOIN SLS.Quotation Q ON Q.QuotationId = QI.QuotationRef
	JOIN GNR.Currency C ON C.CurrencyID = Q.CurrencyRef
WHERE ABS(PriceInfoPercentDiscount - ((QI.PriceInfoDiscountRate * QI.Price)/100)) > 1

UPDATE RI
SET PriceInfoPercentDiscount = ROUND((PriceInfoDiscountRate * RI.Price)/100,C.PrecisionCount)
FROM SLS.ReturnedInvoiceItem RI
	JOIN SLS.ReturnedInvoice R ON R.ReturnedInvoiceId = RI.ReturnedInvoiceRef
	JOIN GNR.Currency C ON C.CurrencyID = R.CurrencyRef
WHERE ABS(PriceInfoPercentDiscount - ((RI.PriceInfoDiscountRate * RI.Price)/100)) > 1


UPDATE SLS.InvoiceItem
SET CustomerDiscount = Discount - (PriceInfoPercentDiscount + PriceInfoPriceDiscount + AggregateAmountPriceDiscount+AggregateAmountPercentDiscount)
WHERE ISNULL(CustomerDiscount,0) = 0 OR (ABS(CustomerDiscount - (CustomerDiscountRate * Price)) > 1)

ALTER TABLE SLS.InvoiceItem ALTER COLUMN [CustomerDiscount] [decimal](19, 4) NOT NULL


UPDATE SLS.QuotationItem
SET CustomerDiscount = Discount - (PriceInfoPercentDiscount + PriceInfoPriceDiscount+AggregateAmountPriceDiscount+AggregateAmountPercentDiscount)
WHERE ISNULL(CustomerDiscount,0) = 0 OR (ABS(CustomerDiscount - (CustomerDiscountRate * Price)) > 1)

ALTER TABLE SLS.QuotationItem ALTER COLUMN [CustomerDiscount] [decimal](19, 4) NOT NULL


UPDATE SLS.ReturnedInvoiceItem
SET CustomerDiscount = Discount - (PriceInfoPercentDiscount + PriceInfoPriceDiscount+AggregateAmountPriceDiscount+AggregateAmountPercentDiscount)
WHERE ISNULL(CustomerDiscount,0) = 0 OR (ABS(CustomerDiscount - (CustomerDiscountRate * Price)) > 1)

ALTER TABLE SLS.ReturnedInvoiceItem ALTER COLUMN [CustomerDiscount] [decimal](19, 4) NOT NULL
