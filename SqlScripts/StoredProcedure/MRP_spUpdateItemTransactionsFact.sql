IF CAST(SERVERPROPERTY('productversion') AS VARCHAR(20)) >= '14.'
BEGIN
    EXEC SP_EXECUTESQL N'
IF OBJECT_ID(''MRP.spUpdateItemTransactionsFact'', ''P'') IS NOT NULL
    DROP PROCEDURE MRP.spUpdateItemTransactionsFact
'
END
GO

IF CAST(SERVERPROPERTY('productversion') AS VARCHAR(20)) >= '14.'
BEGIN
    EXEC SP_EXECUTESQL N'
CREATE PROCEDURE MRP.spUpdateItemTransactionsFact
    @FromDate DATETIME,
    @ToDate DATETIME
AS

DECLARE @FiscalYearID INT = (SELECT TOP 1 FiscalYearId FROM FMK.FiscalYear WHERE StartDate <= @FromDate AND EndDate >= @ToDate);
DECLARE @FiscalYearStartDate DATE = CAST((SELECT TOP 1 StartDate FROM FMK.FiscalYear WHERE FiscalYearId = @FiscalYearID) AS date);

WITH RawTransactions AS (
    SELECT
        Quantity =
            CASE
                WHEN IR.IsReturn = 0 THEN ISNULL(IRI.Quantity, 0)
                ELSE -ISNULL(IRI.Quantity, 0)
            END,
        Price =
            CASE
                WHEN IRI.IsReturn = 0 THEN ISNULL(IRI.Price, 0) + ISNULL(IRI.TransportPrice, 0)
                ELSE -(ISNULL(IRI.Price, 0) + ISNULL(IRI.TransportPrice, 0))
            END,
        IsOpening = CASE WHEN IR.[Type] = 4 /* Opening */ THEN 1 ELSE 0 END,
        [Date] = IR.[Date],
        ItemRef = IRI.ItemRef,
        DelivererDLRef = IR.DelivererDLRef,
        StockRef = IR.StockRef
    FROM INV.InventoryReceiptItem IRI
    JOIN INV.InventoryReceipt IR ON IRI.InventoryReceiptRef = IR.InventoryReceiptID
    WHERE IR.[Date] BETWEEN @FromDate AND @ToDate

    UNION ALL

    SELECT
        Quantity =
            -1 * CASE
                WHEN IDI.IsReturn = 0 THEN ISNULL(IDI.Quantity, 0)
                ELSE -ISNULL(IDI.Quantity, 0)
            END,
        Price =
            -1 * CASE
                WHEN IDI.IsReturn = 0 THEN ISNULL(IDI.Price, 0)
                ELSE -ISNULL(IDI.Price, 0)
            END,
        IsOpening = 0,
        [Date] = ID.[Date],
        ItemRef = IDI.ItemRef,
        DelivererDLRef = NULL,
        StockRef = ID.StockRef
    FROM INV.InventoryDeliveryItem IDI
    JOIN INV.InventoryDelivery ID ON IDI.InventoryDeliveryRef = ID.InventoryDeliveryID
    WHERE ID.[Date] BETWEEN @FromDate AND @ToDate
), Transactions AS (
    SELECT
        [Date],
        TR.Quantity,
        TR.Price,
        I.ItemId,
        I.PurchaseGroupRef AS ItemPurchaseGroupRef,
        I.UnitRef AS UnitId,
        TR.DelivererDLRef AS VendorDlRef,
        IsOpening,
        StockRef
    FROM RawTransactions TR
    INNER JOIN INV.Item I ON TR.ItemRef = I.ItemID
)

INSERT INTO MRP.ItemTransactionsFact
SELECT *
FROM [Transactions]

'
END
GO