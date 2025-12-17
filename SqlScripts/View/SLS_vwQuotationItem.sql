IF OBJECT_ID('SLS.vwQuotationItem') IS NOT NULL
	DROP VIEW SLS.vwQuotationItem
GO
CREATE VIEW SLS.vwQuotationItem
AS
SELECT     QI.QuotationItemID, QI.QuotationRef, QI.RowID, QI.ItemRef, I.Code AS ItemCode, I.Title AS ItemTitle, I.Title_En AS ItemTitle_En, QI.[Description], 
           QI.Description_En, I.IsUnitRatioConstant AS ItemIsUnitRatioConstant, I.UnitsRatio AS ItemUnitsRatio, I.TracingCategoryRef AS ItemTracingCategoryRef, 
           I.SerialTracking,
		   I.ConsumerFee,
           I.PropertyAmounts,
           I.SecondaryUnitRef AS ItemSecondaryUnitRef, I.Type AS ItemType, QI.StockRef, S.Code AS StockCode, S.Title AS StockTitle, 
           S.Title_En AS StockTitle_En, QI.Quantity, QI.SecondaryQuantity, QI.Fee, QI.Price, QI.PriceInBaseCurrency,
		   QI.Discount,QI.PriceInfoDiscountRate,QI.CustomerDiscount,QI.CustomerDiscountRate, QI.DiscountInBaseCurrency, 
           QI.Addition, QI.AdditionInBaseCurrency, QI.Tax, QI.TaxInBaseCurrency, QI.Duty, 
           QI.DutyInBaseCurrency, QI.NetPrice, QI.NetPriceInBaseCurrency, QI.Rate, QI.UsedQuantity, QI.TracingRef, T.TracingID, T.Title AS TracingTitle, 
		   QI.AdditionFactor_VatEffective, QI.AdditionFactorInBaseCurrency_VatEffective, QI.AdditionFactor_VatIneffective, QI.AdditionFactorInBaseCurrency_VatIneffective, 
	       ISNULL(QI.AdditionFactor_VatEffective, 0) + ISNULL(QI.AdditionFactor_VatIneffective, 0) AS AdditionFactor,
	       ISNULL(QI.AdditionFactorInBaseCurrency_VatEffective, 0) + ISNULL(QI.AdditionFactorInBaseCurrency_VatIneffective, 0) AS AdditionFactorInBaseCurrency,
           U.Title AS UnitTitle, U.Title_En AS UnitTitle_En, I.TaxExempt, I.BarCode as ItemBarCode, I.IranCode as ItemIranCode,
           U2.Title AS SecondaryUnitTitle, U2.Title_En AS SecondaryUnitTitle_En,GR.CalculationFormulaRef AS CalculationFormulaRef,QI.DiscountQuotationItemRef,
           QI.PriceInfoPriceDiscount,QI.PriceInfoPercentDiscount, ISNULL(CASE WHEN ISNULL(Delivery.DeliveredQuantity,0) <= QI.Quantity THEN Delivery.DeliveredQuantity ELSE QI.Quantity END, 0) AS DeliveredQuantity,
           ISNULL(CASE WHEN ISNULL(Delivery.DeliveredSecondaryQuantity,0) <= QI.SecondaryQuantity THEN Delivery.DeliveredSecondaryQuantity ELSE QI.SecondaryQuantity END, 0) AS DeliveredSecondaryQuantity,
           QI.PRoductPackRef, P.Title ProductPackTitle, QI.ProductPackQuantity,
           QI.AggregateAmountDiscountRate, QI.AggregateAmountPriceDiscount, QI.AggregateAmountPercentDiscount,
		   I.SaleGroupRef AS [ItemSaleGroupRef], I.[PurchaseGroupRef] AS [ItemPurchaseGroupRef], QI.IsAggregateDiscountInvoiceItem
		   ,QOT.Number AS QuotationNumber
           ,ISNULL(POQ.OrderedQuantity, 0) AS OrderedQuantity
           ,CASE WHEN POQ.ProductOrderUnitRef = I.UnitRef THEN ISNULL(ProducedQ.MainUniProducedQuantity, 0) ELSE ISNULL(ProducedQ.SecondaryUniProducedQuantity, 0) END AS ProducedQuantity
           ,POQ.ProductOrderUnitRef AS QuotationBasedProductOrderUnitRef
		   ,QI.IsReadyForProductOrder
           
FROM       SLS.QuotationItem AS QI 
                INNER JOIN INV.vwItem AS I ON QI.ItemRef = I.ItemID 
                LEFT JOIN INV.TracingCategory AS TC ON I.TracingCategoryRef = TC.TracingCategoryID AND I.TracingCategoryRef = TC.TracingCategoryID 
                LEFT JOIN INV.Tracing AS T ON TC.TracingCategoryID = T.TracingCategoryRef AND QI.TracingRef = T.TracingID 
                LEFT JOIN INV.Stock AS S ON QI.StockRef = S.StockID 
                INNER JOIN INV.Unit AS U ON I.UnitRef = U.UnitID 
                LEFT JOIN INV.Unit AS U2 ON I.SecondaryUnitRef = U2.UnitID  
                LEFT JOIN GNR.[Grouping] GR ON I.SaleGroupRef=GR.GroupingID 
				LEFT JOIN SLS.Quotation QOT ON QOT.QuotationId= QI.QuotationRef
                LEFT JOIN (SELECT ISNULL(IDI.QuotationItemRef, IItem.QuotationItemRef) QuotationItemRef,
							SUM(IDI.Quantity) DeliveredQuantity,
							SUM(IDI.SecondaryQuantity) DeliveredSecondaryQuantity
						FROM INV.InventoryDeliveryItem IDI
							LEFT JOIN 
							(SELECT II.InvoiceItemID, II.Quantity, II.SecondaryQuantity, II.QuotationItemRef
							FROM SLS.InvoiceItem II 
							INNER JOIN SLS.Invoice I ON II.InvoiceRef = I.InvoiceId
							WHERE I.State <> 2 AND II.QuotationItemRef IS NOT NULL) IItem ON IDI.BaseInvoiceItem = IItem.InvoiceItemID
						WHERE IDI.QuotationItemRef IS NOT NULL OR IItem.InvoiceItemID IS NOT NULL
						GROUP BY ISNULL(IDI.QuotationItemRef, IItem.QuotationItemRef)) Delivery ON Delivery.QuotationItemRef = QI.QuotationItemID
						LEFT JOIN sls.[ProductPack] p  ON QI.PRoductPackRef = p.PRoductPackid
                
                LEFT JOIN (
                    SELECT 
                        PO.BaseQuotationItemRef,
                        SUM(PO.Quantity) AS OrderedQuantity,
                        MAX(PO.ProductFormulaUnitRef) AS ProductOrderUnitRef
                    FROM WKO.ProductOrder PO
                    JOIN INV.Item I
                        ON I.ItemID = PO.ProductRef
                    WHERE PO.IsInitial = 0
                    GROUP BY PO.BaseQuotationItemRef
                ) AS POQ ON POQ.BaseQuotationItemRef = QI.QuotationItemID

                LEFT JOIN (
                    SELECT 
                        PO.BaseQuotationItemRef, 
                        SUM(IRI.Quantity) AS MainUniProducedQuantity,
                        SUM(IRI.SecondaryQuantity) AS SecondaryUniProducedQuantity
                    FROM WKO.ProductOrder PO
                    JOIN INV.InventoryReceiptItem IRI
                        ON IRI.ProductOrderRef = PO.ProductOrderID
                    JOIN INV.InventoryReceipt IR
                        ON IR.InventoryReceiptID = IRI.InventoryReceiptRef
                    WHERE IR.IsWastage = 0
                    GROUP BY PO.BaseQuotationItemRef
                ) AS ProducedQ ON ProducedQ.BaseQuotationItemRef = QI.QuotationItemID