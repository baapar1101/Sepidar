If Object_ID('INV.vwInventoryDelivery') Is Not Null
	Drop View INV.vwInventoryDelivery
GO
CREATE VIEW [INV].[vwInventoryDelivery]
AS
SELECT  ID.InventoryDeliveryID, ID.IsReturn, ID.Type, ID.StockRef, S.Code AS StockCode, S.Title AS StockTitle, 
        S.Title_En AS StockTitle_En, ID.ReceiverDLRef, ACC.DL.Code AS DLCode, ACC.DL.Title AS DLTitle, ACC.DL.Title_En AS DLTitle_En, ID.Number, 
        ID.Date, ID.AccountingVoucherRef, ACC.Voucher.Number AS AccountingVoucherNumber, ACC.Voucher.Date AS AccountingVoucherDate, ID.TotalPrice, ID.[Description],
        ID.FiscalYearRef, ID.Creator, ID.CreationDate, ID.LastModifier, ID.LastModificationDate, ID.Version,
		CONVERT(BIT,(CASE WHEN EXISTS(SELECT 1 FROM INV.InventoryDeliveryItem IDI WHERE IDI.InventoryDeliveryRef = ID.InventoryDeliveryID AND IDI.BaseInvoiceItem IS NOT NULL)
						  THEN 1 ELSE 0 END)) AS BasedOnInvoice,
	    CONVERT(BIT,(CASE WHEN EXISTS(SELECT 1 FROM INV.InventoryDeliveryItem IDI WHERE IDI.InventoryDeliveryRef = ID.InventoryDeliveryID AND IDI.ItemRequestItemRef IS NOT NULL)
						  THEN 1 ELSE 0 END)) AS IsBasedOnItemRequest
		, ID.CreatorForm, ID.DestinationStockRef,
		POrder.ProductOrderRef,POrder.ProductOrderNumber,POrder.ProductOrderCostCenterRef,POrder.ProductOrderCostCenterDLRef,
        DS.Title AS DestinationStockTitle, DS.Title_En AS DestinationStockTitle_En, DS.Code AS DestinationStockCode,
        U.Name AS CreatorName, U.Name_En AS CreatorName_En, Q.QuotationRef, Q.QuotationNumber, Q.QuotationCurrencyRef,
        Q.QuotationCurrencyTitle, Q.QuotationRate, [mUsr].[Name] AS [ModifierName], [mUsr].[Name_En] AS [ModifierName_En],
		[HDIDI].[HotDistributionNumber]
FROM INV.InventoryDelivery AS ID 
	LEFT JOIN ACC.DL ON ID.ReceiverDLRef = ACC.DL.DLId 
	INNER JOIN INV.Stock S ON ID.StockRef = S.StockID 
	LEFT OUTER JOIN INV.Stock DS ON DS.StockId = ID.DestinationStockRef 
	LEFT OUTER JOIN ACC.Voucher ON ID.AccountingVoucherRef = ACC.Voucher.VoucherId 
	LEFT JOIN [FMK].[User] AS [mUsr] ON ([ID].[LastModifier] = [mUsr].[UserID]) 
	LEFT JOIN FMK.[User] AS U ON (ID.Creator = U.UserID)
	OUTER APPLY
	(SELECT TOP 1 PO.ProductOrderID ProductOrderRef,PO.Number ProductOrderNumber,PO.CostCenterRef ProductOrderCostCenterRef,CC.DLRef ProductOrderCostCenterDLRef
	 FROM INV.InventoryDeliveryItem IDI
		INNER JOIN WKO.ProductOrder PO ON PO.ProductOrderID = IDI.ProductOrderRef
		INNER JOIN GNR.CostCenter CC  ON CC.CostCenterID = PO.CostCenterRef
	 WHERE IDI.InventoryDeliveryRef = ID.InventoryDeliveryID) POrder
	 OUTER APPLY 
	(SELECT TOP 1 QI.QuotationRef, Q.Number QuotationNumber, Q.CurrencyRef QuotationCurrencyRef,
		C.Title QuotationCurrencyTitle, Q.Rate QuotationRate
	FROM INV.InventoryDeliveryItem IDI
		INNER JOIN SLS.QuotationItem QI ON IDI.QuotationItemRef = QI.QuotationItemID
		INNER JOIN SLS.Quotation Q ON QI.QuotationRef = Q.QuotationId
		INNER JOIN GNR.Currency C ON Q.CurrencyRef = C.CurrencyID
	WHERE IDI.InventoryDeliveryRef = ID.InventoryDeliveryID) Q
	LEFT JOIN [DST].[vwHotDistributionInventoryDeliveryIds] AS [HDIDI] 
		ON [ID].[InventoryDeliveryID] =  [HDIDI].[InventoryDeliveryRef]
WHERE     (ID.IsReturn = 0)

GO