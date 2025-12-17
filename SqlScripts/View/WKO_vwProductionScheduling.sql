IF Object_ID('WKO.vwProductionScheduling') IS NOT NULL
	Drop View WKO.vwProductionScheduling
GO
CREATE VIEW [WKO].[vwProductionScheduling]
AS
SELECT 
DISTINCT
    PS.[ProductionSchedulingID],
    PS.[ProductOrderRef],
    PS.[Description],
    PS.[Start],
    PS.[End],
    PO.[State] AS ProductOrderState,
    PO.[CustomerPartyRef] AS ProductOrderCustomerRef,
    PO.[CustomerPartyDLTitle] AS ProductOrderCustomerTitle,
    PO.[CustomerPartyTitle_En] AS ProductOrderCustomerTitle_En,
	PO.[CustomerPartyDLCode] AS ProductOrderCustomerDLCode,
    CAST(
        CAST(ISNULL(PO.ActualQuantity, 0) AS FLOAT) 
        / NULLIF(PO.Quantity, 0) * 100 
        AS INT
    ) AS [PercentComplete],
	CAST(
        CAST(ISNULL(SUM(POBI.ActualConsumptionQuantity) OVER(PARTITION BY POBI.ProductOrderRef), 0) AS FLOAT) 
        / NULLIF(SUM(POBI.StandardConsumptionQuantity) OVER(PARTITION BY POBI.ProductOrderRef), 0) * 100 
        AS INT
    ) AS [PercentConsumptionComplete],
	PO.CostCenterDLRef,
	PO.CostCenterDLCode,
	PO.CostCenterDLTitle,
	PO.CostCenterDLTitle_En,
	PO.BaseQuotationItemRef,
	PO.BaseQuotationItemNumber,
	PO.ProductRef,
	PO.ProductCode,
	PO.ProductTitle,
	PO.ProductTitle_En,
    PO.Number AS ProductOrderNumber,
	(
         SELECT MAX(IR.[Date])
         FROM INV.InventoryReceipt IR 
		 LEFT JOIN INV.InventoryReceiptItem IRI ON IRI.InventoryReceiptRef = IR.InventoryReceiptID
         WHERE IR.IsReturn = 0
           AND IR.IsWastage = 0
           AND IRI.ProductOrderRef = PO.ProductOrderID
    ) AS LastInventoryReceiptDate,
	(
         SELECT MIN(ID.[Date])
         FROM INV.InventoryDelivery ID 
		 LEFT JOIN INV.InventoryDeliveryItem IDI ON IDI.InventoryDeliveryRef = ID.InventoryDeliveryID
         WHERE ID.IsReturn = 0
           AND IDI.ProductOrderRef = PO.ProductOrderID
    ) AS FirstInventoryDeliveryDate
FROM 
    [WKO].[ProductionScheduling] AS PS
LEFT JOIN [WKO].[vwProductOrder] AS PO 
    ON PO.ProductOrderID = PS.ProductOrderRef
LEFT JOIN [WKO].[vwProductOrderBOMItem] AS POBI 
    ON POBI.ProductOrderRef = PS.ProductOrderRef

GO