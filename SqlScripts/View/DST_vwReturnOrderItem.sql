If Object_ID('DST.vwReturnOrderItem') Is Not Null
	Drop View DST.vwReturnOrderItem
GO
CREATE VIEW DST.vwReturnOrderItem
AS
SELECT     
	OI.ReturnOrderItemID, OI.ReturnOrderRef, OI.RowID, RO.[State] AS ReturnOrderState, RO.Number AS ReturnOrderNumber, RO.[Date] AS ReturnOrderDate,
	OI.InvoiceItemRef,
	II.Quantity AS InvoiceQuantity, II.Discount AS InvoiceDiscount, II.Addition AS InvoiceAddition, 
    II.Tax AS InvoiceTax, II.Duty AS InvoiceDuty,
	OI.ItemRef, 
	I.Code AS ItemCode, I.Title AS ItemTitle, I.Title_En AS ItemTitle_En, I.IsUnitRatioConstant AS ItemIsUnitRatioConstant, 
	I.UnitsRatio AS ItemUnitsRatio, I.TracingCategoryRef AS ItemTracingCategoryRef, I.TaxExempt AS ItemTaxExempt,
	I.UnitRef AS ItemUnitRef, U.Title AS UnitTitle, U.Title_En AS UnitTitle_En, 
	I.SecondaryUnitRef AS ItemSecondaryUnitRef, SU.Title AS SecondaryUnitTitle, SU.Title_En AS SecondaryUnitTitle_En,
	I.BarCode AS ItemBarCode, I.Type AS ItemType, I.SerialTracking, I.TaxExempt, I.ConsumerFee,
	II.InvoiceRef, I.SaleGroupRef AS ItemSaleGroupRef, I.PurchaseGroupRef AS ItemPurchaseGroupRef,
	IV.Number AS InvoiceNumber, IV.[Date] AS InvoiceDate,
	OI.StockRef, S.Code AS StockCode, S.Title AS StockTitle, S.Title_En AS StockTitle_En, 
    OI.TracingRef, T.Title AS TracingTitle, 
	OI.Quantity, OI.SecondaryQuantity, OI.Fee, OI.Price, OI.[Description], OI.Description_En, 
	OI.Discount, OI.Addition, OI.Tax, OI.Duty, OI.NetPrice,  OI.PriceInBaseCurrency, OI.ForDiscountInvoiceItemRef,
    OI.DiscountInBaseCurrency, OI.AdditionInBaseCurrency, OI.TaxInBaseCurrency, OI.DutyInBaseCurrency, OI.NetPriceInBaseCurrency, OI.DiscountReturnOrderItemRef,
	OI.CustomerDiscount, OI.CustomerDiscountRate, OI.PriceInfoDiscountRate, OI.PriceInfoPercentDiscount, OI.PriceInfoPriceDiscount, OI.Rate,
	OI.AdditionFactor_VatEffective, OI.AdditionFactorInBaseCurrency_VatEffective, OI.AdditionFactor_VatIneffective, OI.AdditionFactorInBaseCurrency_VatIneffective, 
	ISNULL(OI.AdditionFactor_VatEffective, 0) + ISNULL(OI.AdditionFactor_VatIneffective, 0) AS AdditionFactor,
	ISNULL(OI.AdditionFactorInBaseCurrency_VatEffective, 0) + ISNULL(OI.AdditionFactorInBaseCurrency_VatIneffective, 0) AS AdditionFactorInBaseCurrency,
	GR.CalculationFormulaRef AS CalculationFormulaRef,
	ISNULL((SELECT  TOP 1  RII.ReturnOrderItemRef FROM sls.ReturnedInvoiceItem RII WHERE RII.ReturnOrderItemRef=OI.ReturnOrderItemID), 0) AS IsDone,
    OI.ReturnReasonRef, RR.Title AS ReturnReasonTitle, RR.Title_En AS ReturnReasonTitle_En,
	OI.AggregateAmountDiscountRate, OI.AggregateAmountPriceDiscount, OI.AggregateAmountPercentDiscount,
	OI.ProductPackRef, P.Title ProductPackTitle,  OI.ProductPackQuantity, OI.IsAggregateDiscountInvoiceItem
FROM DST.ReturnOrderItem AS OI 
	LEFT JOIN DST.ReturnOrder AS RO ON OI.ReturnOrderRef = RO.ReturnOrderID
	LEFT JOIN SLS.vwInvoiceItem AS II ON OI.InvoiceItemRef = II.InvoiceItemID
	LEFT JOIN SLS.vwInvoice AS IV ON II.InvoiceRef = IV.InvoiceId
	INNER JOIN INV.vwItem AS I ON OI.ItemRef = I.ItemID
    LEFT JOIN INV.Stock AS S ON OI.StockRef = S.StockID
	LEFT JOIN INV.TracingCategory AS TC ON I.TracingCategoryRef = TC.TracingCategoryID 
	LEFT JOIN INV.Tracing AS T ON OI.TracingRef = T.TracingID AND TC.TracingCategoryID = T.TracingCategoryRef 
	INNER JOIN INV.Unit AS U ON I.UnitRef = U.UnitID 
	LEFT JOIN INV.Unit AS SU ON I.SecondaryUnitRef = SU.UnitID 
	LEFT JOIN GNR.[Grouping] GR ON I.SaleGroupRef = GR.GroupingID
    LEFT JOIN DST.ReturnReason RR ON OI.ReturnReasonRef = RR.ReturnReasonID
	LEFT JOIN sls.[ProductPack] p  ON OI.ProductPackRef = p.PRoductPackid
