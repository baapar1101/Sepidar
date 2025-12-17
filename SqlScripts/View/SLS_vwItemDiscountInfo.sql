IF Object_ID('SLS.vwItemDiscountInfo') IS NOT NULL
    DROP VIEW SLS.vwItemDiscountInfo
GO

CREATE VIEW SLS.vwItemDiscountInfo AS
SELECT RowID = ROW_NUMBER() OVER (ORDER BY DiscountItemID),
         D.SaleTypeRef,
         ST.Title          AS                  SaleTypeTitle,
         D.CustomerGroupingRef,
         D.CurrencyRef,
         IOD.ItemRef,
         IOD.TracingRef,
         DI.DiscountItemID,
         D.Number,
         D.Title,
         DI.FromValue,
         ToValue,
         DI.DiscountType,
         D.DiscountCalcType,
         D.SaleVolumeType,
         D.StartDate,
         D.EndDate,
         DI.Amount,
         0                 AS                  DiscountPrice, -- It is here intentionally. Just to prevent column not found errors.
         I.ItemID          AS                  DiscountedItemRef,
         I.IsActive        AS                  DiscountedItemIsActive,
         I.Sellable        AS                  DiscountedItemSellable,
         DI.TracingRef     AS                  DiscountedTracingRef,
         DI.ProductPackRef AS                  DiscountedProductPackRef,
         D.IsActive        AS                  DiscountIsActive,
         DI.DiscountItemGroupRef,
         DI.DiscountRef,
         ISNULL(D.DiscountCalculationBasis, 0) DiscountCalculationBasis,
         PD.ProductPackRef                     ProductPackRef
FROM SLS.Discount D
         INNER JOIN SLS.DiscountItem DI ON D.DiscountID = DI.DiscountRef
         LEFT JOIN SLS.ItemDiscount IOD ON IOD.DiscountRef = D.DiscountID
         LEFT JOIN SLS.ProductPackDiscount PD ON PD.DiscountRef = D.DiscountID
         LEFT JOIN INV.Item I ON I.ItemID = CASE WHEN DI.DiscountType = 5 THEN IOD.ItemRef ELSE DI.ItemRef END
         LEFT JOIN SLS.SaleType ST ON D.SaleTypeRef = ST.SaleTypeID
