If Object_ID('INV.vwInventoryReceipt') Is Not Null
	Drop View INV.vwInventoryReceipt
GO
CREATE VIEW [INV].[vwInventoryReceipt]
AS
SELECT     IR.InventoryReceiptID, IR.[Type], IR.PurchaseType, IR.StockRef, INV.Stock.Title AS StockTitle, INV.Stock.Title_En AS StockTitle_En, 
					  [IR].[Description],IR.IsWastage,
                      INV.Stock.Code AS StockCode, IR.DelivererDLRef, ACC.DL.Title AS DelivererTitle, ACC.DL.Title_En AS DelivererTitle_En, 
                      ACC.DL.Code AS DelivererCode,ACC.DL.[Type] AS DelivererDLType, IR.SLAccountRef, AC.Title AS SLAccountTitle, AC.Title_En AS SLAccountTitle_En, 
                      AC.FullCode AS SLAccountCode, IR.Number, IR.[Date], IR.AccountingVoucherRef, IR.IsReturn, 
                      ACC.Voucher.Number AS AccountingVoucherNumber, 
                      ACC.Voucher.[Date] AS AccountingVoucherDate, IR.PaymentHeaderRef, IR.BasePurchaseInvoiceRef,IR.BaseImportPurchaseInvoiceRef,
                      INV.InventoryPurchaseInvoice.[Date] AS BasePurchaseInvoiceDate, INV.InventoryPurchaseInvoice.Number AS BasePurchaseInvoiceNumber,
                      INV.InventoryPurchaseInvoice.InvoiceNumber AS BasePurchaseInvoiceInvoiceNumber,pi.Date AS BaseImportPurchaseInvoiceDate,pi.Number AS BaseImportPurchaseInvoiceNumber,
                      pi.PurchaseNumber AS BaseImportPurchaseInvoicePurchaseNumber,pi.NetPriceInBaseCurrency AS BaseImportPurchaseInvoiceNetPrice,
                      IR.TotalNetPrice, IR.TotalTransportPrice, IR.TotalDuty, IR.TotalTax, IR.TotalPrice, IR.FiscalYearRef, IR.Creator, IR.CreationDate, IR.LastModifier, 
                      IR.LastModificationDate, IR.Version, PH.Number AS PaymentHeaderNumber, PH.Date AS PaymentHeaderDate, PH.[Type] AS PaymentHeaderType,
                      CASE WHEN IR.[Type]=4 THEN 1 ELSE 0 END AS IsOpening,
                      [U].[Name] AS [CreatorName], [U].[Name_En] AS [CreatorName_En], [mUsr].[Name] AS [ModifierName], [mUsr].[Name_En] AS [ModifierName_En],
					  [IR].[TransportBrokerSLAccountRef], [TBAC].[HasDL] AS [TransportBrokerSLAccountHasDL],
                      TBAC.Title AS TransportBrokerSLAccountTitle, TBAC.Title_En AS TransportBrokerSLAccountTitle_En, TBAC.FullCode AS TransportBrokerSLAccountCode,
                      IR.TransporterDLRef, TDL.Title AS TransporterTitle, TDL.Title_En AS TransporterTitle_En, TDL.Code AS TransporterCode, IR.CreatorForm,
                      IR.BaseInventoryDeliveryRef, DS.Title AS BaseInventoryDeliveryStockTitle, DS.Title_En AS BaseInventoryDeliveryStockTitle_En,
                      D.Number AS BaseInventoryDeliveryNumber,
                      DS.Code AS BaseInventoryDeliveryStockCode, DS.StockID AS BaseInventoryDeliveryStockRef, [D].[Date] AS BaseInventoryDeliveryDate,
					  POrder.ProductOrderRef,POrder.ProductOrderNumber,POrder.ProductOrderProductRef,POrder.ProductOrderCostCenterRef,POrder.ProductOrderCostCenterDLRef,
					  POrder.DLTitle AS ProductOrderCostCenterDLTitle, POrder.DLCode ProductOrderCostCenterDLCode,
                      po.PurchaseOrderID AS BasePurchaseOrderRef , ISNULL(po.Number,po.DlCode) AS BasePurchaseOrderNumber , TotalOtherCost
FROM         INV.InventoryReceipt AS IR 
                      INNER JOIN INV.Stock ON IR.StockRef = INV.Stock.StockID 					  
                      LEFT JOIN RPA.PaymentHeader AS PH ON IR.PaymentHeaderRef = PH.PaymentHeaderId 
                      LEFT JOIN ACC.vwAccount AS AC ON IR.SLAccountRef = AC.AccountId 
                      LEFT JOIN ACC.DL ON IR.DelivererDLRef = ACC.DL.DLId 
                      LEFT JOIN ACC.Voucher ON IR.AccountingVoucherRef = ACC.Voucher.VoucherId 
                      LEFT JOIN INV.InventoryPurchaseInvoice ON IR.BasePurchaseInvoiceRef = INV.InventoryPurchaseInvoice.InventoryPurchaseInvoiceID
                      LEFT JOIN POM.PurchaseInvoice pi ON IR.BaseImportPurchaseInvoiceRef = pi.PurchaseInvoiceID     
                      LEFT JOIN POM.vwPurchaseOrder po ON po.PurchaseOrderID=pi.PurchaseOrderRef OR po.PurchaseOrderID = INV.InventoryPurchaseInvoice.PurchaseOrderRef
                      LEFT JOIN [FMK].[User] AS [U] ON ([IR].[Creator] = [U].[UserID]) 
                      LEFT JOIN [FMK].[User] AS [mUsr] ON ([IR].[LastModifier] = [mUsr].[UserID]) 
                      LEFT JOIN ACC.vwAccount AS TBAC ON IR.TransportBrokerSLAccountRef = TBAC.AccountId 
                      LEFT JOIN ACC.DL AS TDL ON TDL.DLId = IR.TransporterDLRef 
                      LEFT JOIN INV.InventoryDelivery AS D ON IR.BaseInventoryDeliveryRef = D.InventoryDeliveryId 
                      LEFT JOIN INV.Stock AS DS ON DS.StockId = D.StockRef 
					  OUTER APPLY
						(SELECT TOP 1 PO.ProductOrderID ProductOrderRef,PO.Number ProductOrderNumber,PO.ProductRef ProductOrderProductRef,PO.CostCenterRef ProductOrderCostCenterRef,CC.DLRef ProductOrderCostCenterDLRef,
						CC.DLTitle, CC.DLCode
						 FROM INV.InventoryReceiptItem IRI
							INNER JOIN WKO.ProductOrder PO ON PO.ProductOrderID = IRI.ProductOrderRef
							INNER JOIN GNR.vwCostCenter CC  ON CC.CostCenterID = PO.CostCenterRef
						 WHERE IRI.InventoryReceiptRef = IR.InventoryReceiptID) POrder
WHERE     (IR.IsReturn = 0)

GO