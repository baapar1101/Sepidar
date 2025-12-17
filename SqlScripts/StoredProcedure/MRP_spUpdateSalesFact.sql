IF CAST(SERVERPROPERTY('productversion') AS VARCHAR(20)) >= '14.'
BEGIN
    EXEC SP_EXECUTESQL N'
IF OBJECT_ID(''MRP.spUpdateSalesFact'', ''P'') IS NOT NULL
    DROP PROCEDURE MRP.spUpdateSalesFact
'
END
GO

IF CAST(SERVERPROPERTY('productversion') AS VARCHAR(20)) >= '14.'
BEGIN
    EXEC SP_EXECUTESQL N'
CREATE PROC MRP.spUpdateSalesFact @FromDate DATE, @ToDate DATE
AS

--DECLARE @FiscalYearRef INT = (SELECT TOP 1 FiscalYearID FROM FMK.FiscalYear WHERE StartDate <= @FromDate AND EndDate >= @ToDate);
--IF @FiscalYearRef IS NULL
--BEGIN;
--    THROW 50000, ''Invalid date range provided'', 1;
--END;

WITH
SalesData AS
(
 -- Main sales data
    SELECT
		SI.InvoiceId,
		0 as ReturnedInvoiceId,
		SII.InvoiceItemID AS InvoiceItemID,
		0 AS ReturnedInvoiceItemID,
		SI.FiscalYearRef AS FiscalYearRef,
		SI.State AS InvoiceState,
		SII.TracingRef AS InvoiceItemTracingRef,
        NULL AS RIIInvoiceItemRef,
		SII.[DiscountInBaseCurrency] AS InvoiceDiscount,
		0 AS ReturnInvoiceDiscount,
		[SII].[NetPriceInBaseCurrency] AS NetPrice,
		0 AS ReturnedNetPrice,
        I.[SaleGroupRef],
        SI.[SaleTypeRef],
        SI.[Date],
        ST.SaleTypeMarket,
        SII.[StockRef],
        SI.[CustomerPartyRef],
		SI.PartyAddressRef,
        SII.[ItemRef],
        SII.[PriceInBaseCurrency] AS Price,
		SII.Fee * SII.[Rate] AS Fee,
        SII.[Quantity],
		0 as ReturnPrice,
		0 AS ReturnFee,
        0 as ReturnQuantity,
        [SII].[AdditionInBaseCurrency] AS SaleAdditionInBaseCurrency,
        [SII].AdditionFactorInBaseCurrency_VatEffective + [SII].AdditionFactorInBaseCurrency_VatIneffective AS SaleAdditionFactorInBaseCurrency,
        [SII].DiscountInBaseCurrency AS SaleDiscountInBaseCurrency,
		0 AS ReturnedSaleAdditionInBaseCurrency,
        0 AS TotalReturnedSaleAdditionFactorInBaseCurrency,
        0 AS ReturnedSaleDiscountInBaseCurrency
    FROM [SLS].[InvoiceItem] AS SII
    INNER JOIN  [INV].[Item] AS I ON SII.[ItemRef] = I.[ItemID]
    INNER JOIN [SLS].[Invoice] AS SI ON SI.[InvoiceId] = SII.[InvoiceRef]
    LEFT JOIN [SLS].[SaleType] ST ON SI.[SaleTypeRef] = ST.SaleTypeId
    WHERE SI.State = 1 AND SI.[Date] BETWEEN @FromDate AND @ToDate

    UNION ALL

    -- Returned items data
    SELECT
		0 AS InvoiceId,
		SRI.ReturnedInvoiceId as ReturnedInvoiceId,
		0 AS InvoiceItemID,
		SRII.ReturnedInvoiceItemID AS ReturnedInvoiceItemID,
		SRI.FiscalYearRef AS FiscalYearRef,
		0 AS InvoiceState,
		NULL AS InvoiceItemTracingRef,
        SRII.InvoiceItemRef AS RIIInvoiceItemRef,
		0 AS InvoiceDiscount,
		SRII.[DiscountInBaseCurrency] AS ReturnInvoiceDiscount,
		0 AS NetPrice,
		[SRII].[NetPriceInBaseCurrency]  AS ReturnedNetPrice,
        I.[SaleGroupRef],
        SRI.[SaleTypeRef],
        SRI.[Date],
        ST.SaleTypeMarket,
        SRII.[StockRef],
        SRI.[CustomerPartyRef],
		SRI.PartyAddressRef,
        SRII.[ItemRef],
		0 AS Price,
        0 AS Fee,
        0 AS Quantity,
        SRII.[PriceInBaseCurrency] as ReturnPrice,
		SRII.Fee * SRII.[Rate] AS ReturnFee,
        SRII.[Quantity] ReturnQuantity ,
		0 AS SaleAdditionInBaseCurrency,
        0 AS SaleAdditionFactorInBaseCurrency,
        0 AS SaleDiscountInBaseCurrency,
        [SRII].[AdditionInBaseCurrency] AS ReturnedSaleAdditionInBaseCurrency,
        [SRII].AdditionFactorInBaseCurrency_VatEffective + [SRII].AdditionFactorInBaseCurrency_VatIneffective AS TotalReturnedSaleAdditionFactorInBaseCurrency,
        [SRII].DiscountInBaseCurrency AS ReturnedSaleDiscountInBaseCurrency
	FROM [SLS].[ReturnedInvoiceItem] AS SRII
    INNER JOIN  [INV].[Item] AS I ON SRII.[ItemRef] = I.[ItemID]
    INNER JOIN [SLS].[ReturnedInvoice] AS SRI ON SRI.[ReturnedInvoiceId] = SRII.[ReturnedInvoiceRef]
    LEFT JOIN [SLS].[SaleType] ST ON SRI.[SaleTypeRef] = ST.SaleTypeId
    WHERE SRI.[Date] BETWEEN @FromDate AND @ToDate
)


INSERT INTO MRP.SaleFacts
SELECT *
FROM SalesData
'
END
GO