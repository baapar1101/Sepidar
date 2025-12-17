IF OBJECT_ID('SLS.vwInvoiceItem') IS NOT NULL
	DROP VIEW SLS.vwInvoiceItem
GO
CREATE VIEW SLS.vwInvoiceItem
AS
SELECT      II.InvoiceRef, II.RowID, II.QuotationItemRef, II.OrderItemRef, II.ItemRef, I.Code AS ItemCode, I.Title AS ItemTitle, I.Title_En AS ItemTitle_En, II.[Description], 
            II.Description_En, I.IsUnitRatioConstant AS ItemIsUnitRatioConstant, I.UnitsRatio AS ItemUnitsRatio, I.TracingCategoryRef AS ItemTracingCategoryRef, 
            I.UnitRef AS ItemUnitRef, I.SecondaryUnitRef AS ItemSecondaryUnitRef, I.[Type] AS ItemType, II.StockRef, S.Code AS StockCode, S.Title AS StockTitle, 
            I.SerialTracking,SI.Number AS InvoiceNumber,
            I.PropertyAmounts,
            S.Title_En AS StockTitle_En, II.TracingRef, T.Title AS TracingTitle, II.Quantity, II.SecondaryQuantity, II.Fee, II.Price, 
			II.Discount, II.PriceInfoDiscountRate,II.CustomerDiscount,II.CustomerDiscountRate, 
            II.AdditionFactor_VatEffective, II.AdditionFactorInBaseCurrency_VatEffective, II.AdditionFactor_VatIneffective, II.AdditionFactorInBaseCurrency_VatIneffective, 
	        ISNULL(II.AdditionFactor_VatEffective, 0) + ISNULL(II.AdditionFactor_VatIneffective, 0) AS AdditionFactor,
	        ISNULL(II.AdditionFactorInBaseCurrency_VatEffective, 0) + ISNULL(II.AdditionFactorInBaseCurrency_VatIneffective, 0) AS AdditionFactorInBaseCurrency,
		    II.AggregateAmountDiscountRate, II.AggregateAmountPriceDiscount, II.AggregateAmountPercentDiscount,
		    II.Addition, II.Tax, II.Duty, II.NetPrice, II.Rate, II.InvoiceItemID, U.Title AS UnitTitle, U.Title_En AS UnitTitle_En, I.TaxExempt, II.PriceInBaseCurrency, 
            II.DiscountInBaseCurrency, II.AdditionInBaseCurrency, II.TaxInBaseCurrency, II.DutyInBaseCurrency, II.NetPriceInBaseCurrency, I.BarCode AS ItemBarCode,  I.IranCode AS ItemIranCode,
            GR.CalculationFormulaRef AS CalculationFormulaRef,II.DiscountInvoiceItemRef,II.PriceInfoPriceDiscount,II.PriceInfoPercentDiscount, Su.Title AS SecondaryUnitTitle, SU.Title_En AS SecondaryUnitTitle_En,
			ii.PRoductPackRef, P.Title ProductPackTitle, ii.ProductPackQuantity , II.DiscountItemGroupRef, II.BankFeeForCurrencySale, II.BankFeeForCurrencySaleInBaseCurrency,
            I.SaleGroupRef AS [ItemSaleGroupRef], I.[PurchaseGroupRef] AS [ItemPurchaseGroupRef], II.[IsAggregateDiscountInvoiceItem],[II].TaxPayerCurrencyPurchaseRate
			,I.ConsumerFee
FROM        SLS.InvoiceItem AS II 
            INNER JOIN SLS.Invoice SI ON II.InvoiceRef = SI.InvoiceId 
            INNER JOIN INV.vwItem AS I ON II.ItemRef = I.ItemID 
            LEFT JOIN INV.Stock AS S ON II.StockRef = S.StockID 
            LEFT JOIN INV.TracingCategory AS TC ON I.TracingCategoryRef = TC.TracingCategoryID 
            LEFT JOIN INV.Tracing AS T ON II.TracingRef = T.TracingID AND TC.TracingCategoryID = T.TracingCategoryRef 
            INNER JOIN INV.Unit AS U ON I.UnitRef = U.UnitID 
            LEFT JOIN INV.Unit AS SU ON I.SecondaryUnitRef = SU.UnitID 
            LEFT JOIN GNR.[Grouping] GR ON I.SaleGroupRef=GR.GroupingID
			LEFT JOIN sls.[ProductPack] p  ON ii.PRoductPackRef = p.PRoductPackid
