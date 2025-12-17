If Object_ID('DST.vwOrderItem') Is Not Null
	Drop View DST.vwOrderItem
GO
CREATE VIEW DST.vwOrderItem
AS
SELECT 
	OI.OrderItemID, OI.OrderRef, OI.RowID, 
	OI.ItemRef, 
	I.Code AS ItemCode, I.Title AS ItemTitle, I.Title_En AS ItemTitle_En, I.IsUnitRatioConstant AS ItemIsUnitRatioConstant, 
	I.UnitsRatio AS ItemUnitsRatio, I.TracingCategoryRef AS ItemTracingCategoryRef, I.TaxExempt AS ItemTaxExempt,
	I.UnitRef AS ItemUnitRef, U.Title AS UnitTitle, U.Title_En AS UnitTitle_En,
	I.ConsumerFee,
	I.SecondaryUnitRef AS ItemSecondaryUnitRef, SU.Title AS SecondaryUnitTitle, SU.Title_En AS SecondaryUnitTitle_En,
	I.BarCode AS ItemBarCode, I.[Type] AS ItemType, I.SerialTracking, I.TaxExempt,
	OI.StockRef, S.Code AS StockCode, S.Title AS StockTitle, S.Title_En AS StockTitle_En, 
    OI.TracingRef, T.Title AS TracingTitle, OI.DiscountItemGroupRef,
	OI.Quantity, OI.SecondaryQuantity, OI.Fee, OI.Price, OI.[Description], OI.Description_En, 
	OI.OrderedQuantity, OI.OrderedSecondaryQuantity, OI.InvoicedQuantity, OI.Discount, OI.Addition, OI.Tax, OI.Duty, OI.NetPrice,  OI.PriceInBaseCurrency, 
    OI.DiscountInBaseCurrency, OI.AdditionInBaseCurrency, OI.TaxInBaseCurrency, OI.DutyInBaseCurrency, OI.NetPriceInBaseCurrency, OI.DiscountOrderItemRef,
	OI.AggregateAmountDiscountRate, OI.AggregateAmountPriceDiscount, OI.AggregateAmountPercentDiscount,
	OI.CustomerDiscount, OI.CustomerDiscountRate, OI.PriceInfoDiscountRate, OI.PriceInfoPercentDiscount, OI.PriceInfoPriceDiscount, OI.Rate,
	OI.AdditionFactor_VatEffective, OI.AdditionFactorInBaseCurrency_VatEffective, OI.AdditionFactor_VatIneffective, OI.AdditionFactorInBaseCurrency_VatIneffective, 
	ISNULL(OI.AdditionFactor_VatEffective, 0) + ISNULL(OI.AdditionFactor_VatIneffective, 0) AS AdditionFactor,
	ISNULL(OI.AdditionFactorInBaseCurrency_VatEffective, 0) + ISNULL(OI.AdditionFactorInBaseCurrency_VatIneffective, 0) AS AdditionFactorInBaseCurrency,
	GR.CalculationFormulaRef AS CalculationFormulaRef, OI.IsAggregateDiscountInvoiceItem,
	OI.ProductPackRef, P.Title ProductPackTitle, OI.OrderedProductPackQuantity, OI.ProductPackQuantity,
	ISNULL(II.ProductPackQuantity,0) InvoicedProductPackQuantity,I.SaleGroupRef AS [ItemSaleGroupRef], I.[PurchaseGroupRef] AS [ItemPurchaseGroupRef]
FROM DST.OrderItem AS OI 
	INNER JOIN INV.vwItem AS I ON OI.ItemRef = I.ItemID 
    LEFT JOIN INV.Stock AS S ON OI.StockRef = S.StockID
	LEFT JOIN INV.TracingCategory AS TC ON I.TracingCategoryRef = TC.TracingCategoryID 
	LEFT JOIN INV.Tracing AS T ON OI.TracingRef = T.TracingID AND TC.TracingCategoryID = T.TracingCategoryRef 
	INNER JOIN INV.Unit AS U ON I.UnitRef = U.UnitID 
	LEFT JOIN INV.Unit AS SU ON I.SecondaryUnitRef = SU.UnitID 
	LEFT JOIN GNR.[Grouping] GR ON I.SaleGroupRef = GR.GroupingID
	LEFT JOIN sls.[ProductPack] p  ON OI.PRoductPackRef = p.PRoductPackid
	LEFT JOIN (SELECT OrderItemRef, SUM(ISNULL(ProductPackQuantity,0))  ProductPackQuantity
						FROM sls.[InvoiceItem]  
						GROUP BY OrderItemRef)II ON  OI.OrderItemId = II.OrderItemRef


	