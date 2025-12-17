IF OBJECT_ID('INV.vwAssetPurchaseInvoice') IS NOT NULL
	DROP VIEW INV.[vwAssetPurchaseInvoice]
GO
CREATE VIEW [INV].[vwAssetPurchaseInvoice]
AS
SELECT  [IP].InventoryPurchaseInvoiceID,[IP].VendorDLRef, ACC.DL.Code AS DLCode, ACC.DL.Title AS DLTitle, 
		ACC.DL.Title_En AS DLTitle_En, [IP].Number, 
        [IP].InvoiceNumber, [IP].[Date], [IP].CurrencyRef, GNR.Currency.Title AS CurrencyTitle, 
		[IP].[PurchasingAgentPartyRef],
		Agent.DlCode AS PurchasingAgentDlCode, Agent.DlTitle AS PurchasingAgentDlTitle, Agent.DlTitle_En AS PurchasingAgentDlTitle_En,
		[PurchaseOrderRef],PO.[Date] AS PurchaseOrderDate,
	    CASE WHEN PO.PurchasingType=2 THEN PO.[Number] ELSE PO.DLCode END AS PurchaseOrderNumber,
		GNR.Currency.Title_En AS CurrencyTitle_En, [IP].CurrencyRate, 
        [IP].TotalPrice,[IP].TotalPriceInBaseCurrency, 
		[IP].[TotalTax], [GNR].[fnCalcAmountInBaseCurrency]([IP].[TotalTax], [IP].[CurrencyRate]) AS TotalTaxInBaseCurrency,
		[IP].[TotalDuty], [GNR].[fnCalcAmountInBaseCurrency]([IP].[TotalDuty], [IP].[CurrencyRate]) AS TotalDutyInBaseCurrency,
		[IP].TotalNetPrice, [IP].TotalNetPriceInBaseCurrency,
		[IP].FiscalYearRef, [IP].Creator, [IP].CreationDate, [IP].LastModifier, 
        [IP].LastModificationDate, [IP].[Version], [IP].PaymentHeaderRef, [IP].[Type],
		RPA.PaymentHeader.Number PaymentNumber, RPA.PaymentHeader.[Date] PaymentDate,
        U.[Name] AS CreatorName, U.Name_En AS CreatorName_En,
        [IP].TotalWithHoldingTaxAmount, [GNR].[fnCalcAmountInBaseCurrency]([IP].[TotalWithHoldingTaxAmount], [IP].[CurrencyRate]) AS [TotalWithHoldingTaxAmountInBaseCurrency],
		[IP].TotalInsuranceAmount,[GNR].[fnCalcAmountInBaseCurrency]([IP].TotalInsuranceAmount, [IP].[CurrencyRate]) AS [TotalInsuranceAmountInBaseCurrency],
        [IP].SLAccountRef,AC.FullCode SLAccountCode,AC.Title SLAccountTitle,AC.Title_En SLAccountTitle_En,
        [IP].AccountingVoucherRef, V.Number AS AccountingVoucherNumber, V.[Date] AS AccountingVoucherDate,
        CostCenter.Code AS CostCenterCode, CostCenter.DLId AS CostCenterRef,
        CostCenter.Title AS CostCenterTitle, CostCenter.Title_En AS CostCenterTitle_En,
		C.PrecisionCount AS CurrencyPrecisionCount
		,AssetAcquisitionPurchaseSLRef
        ,AssetAcquisitionPurchaseSLAccountCode     = AC1.FullCode 
		,AssetAcquisitionPurchaseSLAccountTitle    = AC1.Title    
		,AssetAcquisitionPurchaseSLAccountTitle_En = AC1.Title_En 
		,[PAR].[PartyId] AS [PartyId]
		,[IP].[PartyAddressRef]
		,[PA].[Address]
		,[PA].[Title] AS [AddressTitle]
		,[PA].[ZipCode] AS [AddressZipCode]
		,[PAR].[IdentificationCode] AS [PartyIdentificationCode]
		,[PAR].[EconomicCode] AS [PartyEconomicCode]
		,'' AS [Description]
		,ISNULL(IPI.Addition ,0) AS Addition
		,ISNULL(IPI.additionInBaseCurrency,0) AS AdditionInBaseCurrency
		,ISNULL(IPI.Discount, 0) AS Discount
		,ISNULL(IPI.DiscountInBaseCurrentcy, 0) AS DiscountInBaseCurrentcy
FROM INV.InventoryPurchaseInvoice AS [IP]
	INNER JOIN ACC.DL ON [IP].VendorDLRef = ACC.DL.DLId
	LEFT JOIN ACC.DL AS CostCenter ON [IP].CostCenterRef = CostCenter.DLId
	INNER JOIN GNR.Currency ON [IP].CurrencyRef = GNR.Currency.CurrencyID 
	LEFT JOIN RPA.PaymentHeader ON [IP].PaymentHeaderRef = RPA.PaymentHeader.PaymentHeaderId 
	LEFT JOIN FMK.[User] AS U ON ([IP].Creator = U.UserID)
	LEFT JOIN ACC.vwAccount AS AC ON [IP].SLAccountRef = AC.AccountId 
	LEFT JOIN ACC.vwAccount AS AC1 ON [IP].AssetAcquisitionPurchaseSLRef = AC1.AccountId 
	LEFT JOIN ACC.Voucher V ON [IP].AccountingVoucherRef = V.VoucherId
	LEFT JOIN GNR.Currency AS C ON [IP].CurrencyRef = C.CurrencyID 	
	LEFT JOIN 	  GNR.[vwParty] AS Agent ON [IP].[PurchasingAgentPartyRef] = Agent.PartyID 
	LEFT JOIN 	  POM.[vwPurchaseOrder] AS PO ON [IP].[PurchaseOrderRef] = PO.PurchaseOrderID 
	LEFT JOIN [GNR].[vwParty] AS [PAR] ON [PAR].[DLRef] = [IP].[VendorDLRef] 
	LEFT JOIN [GNR].[vwPartyAddress] AS [PA] ON [IP].[PartyAddressRef] = [PA].[PartyAddressId]
	LEFT JOIN	(
					SELECT	InventoryPurchaseInvoiceREf , 
							SUM(ISNULL(Addition,0)) AS Addition, SUM(ISNULL(AdditionInBaseCurrency,0)) AS AdditionInBaseCurrency,
							SUM(ISNULL(Discount,0)) AS Discount, SUM(ISNULL(DiscountInBaseCurrentcy,0)) AS DiscountInBaseCurrentcy
					From INV.InventoryPurchaseInvoiceItem 
					GROUP BY InventoryPurchaseInvoiceREf
				) IPI ON [IP].InventoryPurchaseInvoiceID = IPI.InventoryPurchaseInvoiceREf
WHERE [IP].[Type] = 3 /* InventoryPurchaseInvoiceType.AssetPurchase = 3*/
GO
