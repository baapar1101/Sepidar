
IF OBJECT_ID('SLS.vwReturnedInvoiceItem') IS NOT NULL
	DROP VIEW SLS.vwReturnedInvoiceItem
GO
CREATE VIEW SLS.vwReturnedInvoiceItem
AS
SELECT     RII.ReturnedInvoiceRef, RII.RowID, RII.InvoiceItemRef, RII.ItemRef, I.Code AS ItemCode, I.Title AS ItemTitle, I.Title_En AS ItemTitle_En, RII.[Description], 
           RII.Description_En, I.IsUnitRatioConstant AS ItemIsUnitRatioConstant, I.UnitsRatio AS ItemUnitsRatio, I.TracingCategoryRef AS ItemTracingCategoryRef,
           I.UnitRef AS ItemUnitRef, I.SecondaryUnitRef AS ItemSecondaryUnitRef, I.[Type] AS ItemType, RII.StockRef, S.Code AS StockCode, S.Title AS StockTitle, 
           I.SerialTracking,
		   I.ConsumerFee,
           I.PropertyAmounts, I.SaleGroupRef AS ItemSaleGroupRef, I.PurchaseGroupRef AS ItemPurchaseGroupRef,
           S.Title_En AS StockTitle_En, RII.TracingRef, T.Title AS TracingTitle, RII.Quantity, RII.SecondaryQuantity, RII.Fee, RII.Price, RII.Discount, 
           RII.PriceInfoDiscountRate, RII.CustomerDiscountRate,RII.CustomerDiscount, RII.Addition, RII.Tax, RII.Duty, RII.NetPrice, RII.Rate, RII.ReturnedInvoiceItemID, 
           Iv.Number AS InvoiceNumber, Iv.InvoiceId, II.Quantity AS InvoiceQuantity, II.Discount AS InvoiceDiscount, II.Addition AS InvoiceAddition, 
           II.Tax AS InvoiceTax, II.Duty AS InvoiceDuty, U.Title AS UnitTitle, U.Title_En AS UnitTitle_En, I.TaxExempt, RII.PriceInBaseCurrency, RII.DiscountInBaseCurrency, 
           RII.AdditionInBaseCurrency, RII.TaxInBaseCurrency, RII.DutyInBaseCurrency, RII.NetPriceInBaseCurrency, I.BarCode AS ItemBarCode, I.IranCode AS ItemIranCode,
           GR.CalculationFormulaRef AS CalculationFormulaRef,RII.DiscountReturnedInvoiceItemRef,
           RII.PriceInfoPriceDiscount,RII.PriceInfoPercentDiscount, RII.ReturnOrderItemRef, RO.Number AS ReturnOrderNumber, RO.[ReturnOrderID] AS [ReturnOrderRef], 
           RII.AggregateAmountDiscountRate, RII.AggregateAmountPriceDiscount, RII.AggregateAmountPercentDiscount,
		   RII.AdditionFactor_VatEffective, RII.AdditionFactorInBaseCurrency_VatEffective, RII.AdditionFactor_VatIneffective, RII.AdditionFactorInBaseCurrency_VatIneffective, 
	       ISNULL(RII.AdditionFactor_VatEffective, 0) + ISNULL(RII.AdditionFactor_VatIneffective, 0) AS AdditionFactor,
	       ISNULL(RII.AdditionFactorInBaseCurrency_VatEffective, 0) + ISNULL(RII.AdditionFactorInBaseCurrency_VatIneffective, 0) AS AdditionFactorInBaseCurrency,
		   RII.PRoductPackRef, P.Title ProductPackTitle, RII.ProductPackQuantity, RII.IsAggregateDiscountInvoiceItem,
           RII.ReturnReasonRef, RR.Title AS ReturnReasonTitle, RR.Title_En AS ReturnReasonTitle_En, Su.Title AS SecondaryUnitTitle, SU.Title_En AS SecondaryUnitTitle_En, RII.ForDiscountInvoiceItemRef, RII.ForDiscountReturnedOrderItemRef
FROM       SLS.ReturnedInvoiceItem AS RII
                INNER JOIN INV.vwItem AS I ON RII.ItemRef = I.ItemID 
                LEFT JOIN INV.Stock AS S ON RII.StockRef = S.StockID 
                LEFT JOIN INV.TracingCategory AS TC ON I.TracingCategoryRef = TC.TracingCategoryID 
                LEFT JOIN INV.Tracing AS T ON RII.TracingRef = T.TracingID AND TC.TracingCategoryID = T.TracingCategoryRef 
                LEFT JOIN SLS.InvoiceItem AS II ON II.InvoiceItemID = RII.InvoiceItemRef 
                LEFT JOIN SLS.Invoice AS Iv ON Iv.InvoiceId = II.InvoiceRef 
                INNER JOIN INV.Unit AS U ON I.UnitRef = U.UnitID 
                LEFT JOIN INV.Unit AS SU ON I.SecondaryUnitRef = SU.UnitID 
                LEFT JOIN GNR.[Grouping] GR ON I.SaleGroupRef=GR.GroupingID
                LEFT JOIN DST.[ReturnOrderItem] ROI ON RII.ReturnOrderItemRef = ROI.ReturnOrderItemID
                LEFT JOIN DST.[ReturnOrder] RO ON ROI.ReturnOrderRef = RO.ReturnOrderID
                LEFT JOIN sls.[ProductPack] p  ON RII.PRoductPackRef = p.PRoductPackid
                LEFT JOIN DST.ReturnReason RR ON RII.ReturnReasonRef = RR.ReturnReasonID
                      