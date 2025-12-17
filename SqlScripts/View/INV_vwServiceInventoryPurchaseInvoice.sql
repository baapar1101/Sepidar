IF OBJECT_ID('INV.vwServiceInventoryPurchaseInvoice') IS NOT NULL
	DROP VIEW INV.[vwServiceInventoryPurchaseInvoice]
GO
CREATE VIEW [INV].[vwServiceInventoryPurchaseInvoice]  
AS  
SELECT  [IP].InventoryPurchaseInvoiceID,[IP].VendorDLRef, ACC.DL.Code AS DLCode, ACC.DL.Title AS DLTitle, ACC.DL.Title_En AS DLTitle_En, [IP].Number,   
        [IP].InvoiceNumber, [IP].[Date], [IP].CurrencyRef, GNR.Currency.Title AS CurrencyTitle, GNR.Currency.Title_En AS CurrencyTitle_En, [IP].CurrencyRate,   
		[IP].[PurchasingAgentPartyRef],
		Agent.DlCode AS PurchasingAgentDlCode, Agent.DlTitle AS PurchasingAgentDlTitle, Agent.DlTitle_En AS PurchasingAgentDlTitle_En,
		[PurchaseOrderRef],PO.[Date] AS PurchaseOrderDate,
	    CASE WHEN PO.PurchasingType=2 THEN PO.[Number] ELSE PO.DLCode END AS PurchaseOrderNumber,PO.PurchasingType AS PurchaseOrderPurchasingType,
        [IP].TotalPrice,[IP].TotalPriceInBaseCurrency, 
		[IP].TotalTax, [GNR].[fnCalcAmountInBaseCurrency]([IP].[TotalTax], [IP].[CurrencyRate]) AS TotalTaxInBaseCurrency,
		[IP].TotalDuty, [GNR].[fnCalcAmountInBaseCurrency]([IP].[TotalDuty], [IP].[CurrencyRate]) AS TotalDutyInBaseCurrency,
		[IP].TotalNetPrice, [IP].TotalNetPriceInBaseCurrency,
		IPI.NetPriceInBaseCurrency AS TotalItemNetPriceInBaseCurrency,
		[IP].FiscalYearRef, [IP].Creator, [IP].CreationDate, [IP].LastModifier,   
        [IP].LastModificationDate, [IP].[Version], [IP].PaymentHeaderRef, [IP].[Type], RPA.PaymentHeader.Number PaymentNumber, RPA.PaymentHeader.[Date] PaymentDate,  
		[IP].[Description], [IP].Description_En,
        U.[Name] AS CreatorName, U.Name_En AS CreatorName_En,  
        [IP].TotalWithHoldingTaxAmount, [GNR].[fnCalcAmountInBaseCurrency]([IP].[TotalWithHoldingTaxAmount], [IP].[CurrencyRate]) AS [TotalWithHoldingTaxAmountInBaseCurrency],
		[IP].TotalInsuranceAmount, [GNR].[fnCalcAmountInBaseCurrency]([IP].[TotalInsuranceAmount], [IP].[CurrencyRate]) AS TotalInsuranceAmountInBaseCurrency,
        [IP].SLAccountRef,AC.FullCode SLAccountCode,AC.Title SLAccountTitle,AC.Title_En SLAccountTitle_En,  
        [IP].AccountingVoucherRef, V.Number AS AccountingVoucherNumber, V.[Date] AS AccountingVoucherDate,  
        CostCenter.Code AS CostCenterCode, CostCenter.DLId AS CostCenterRef,  
        CostCenter.Title AS CostCenterTitle, CostCenter.Title_En AS CostCenterTitle_En,   
		CostCenter.[Type] AS CostCenterDlType, Tender.TenderID TenderID, Tender.[Date] AS TenderDate,  
		C.PrecisionCount AS CurrencyPrecisionCount, 
		ISNULL(IPI.Discount,0) AS Discount,ISNULL(IPI.DiscountInBaseCurrentcy,0) AS DiscountInBaseCurrentcy,
		ISNULL(IPI.Addition ,0) AS Addition, ISNULL(IPI.additionInBaseCurrency,0) AS AdditionInBaseCurrency  
	FROM	INV.InventoryPurchaseInvoice AS [IP]
			INNER JOIN ACC.DL ON [IP].VendorDLRef = ACC.DL.DLId  
			LEFT JOIN ACC.DL AS CostCenter ON [IP].CostCenterRef = CostCenter.DLId  
			LEFT JOIN CNT.Tender AS Tender ON [IP].CostCenterRef = Tender.DLRef  
			INNER JOIN GNR.Currency ON [IP].CurrencyRef = GNR.Currency.CurrencyID   
			LEFT JOIN RPA.PaymentHeader ON [IP].PaymentHeaderRef = RPA.PaymentHeader.PaymentHeaderId   
			LEFT JOIN FMK.[User] AS U ON ([IP].Creator = U.UserID)  
			LEFT JOIN ACC.vwAccount AS AC ON [IP].SLAccountRef = AC.AccountId   
			LEFT JOIN ACC.Voucher V ON [IP].AccountingVoucherRef = V.VoucherId  
			LEFT JOIN 	  GNR.[vwParty] AS Agent ON [IP].[PurchasingAgentPartyRef] = Agent.PartyID 
			LEFT JOIN 	  POM.[vwPurchaseOrder] AS PO ON [IP].[PurchaseOrderRef] = PO.PurchaseOrderID 
			LEFT JOIN GNR.Currency AS C ON [IP].CurrencyRef = C.CurrencyID      
			LEFT JOIN(  
				SELECT InventoryPurchaseInvoiceREf,	SUM(ISNULL(Discount,0)) AS Discount,SUM(ISNULL(DiscountInBaseCurrentcy,0)) AS DiscountInBaseCurrentcy,
				SUM(ISNULL(Addition,0)) AS Addition, sum(isnull(AdditionInBaseCurrency,0)) AS AdditionInBaseCurrency,
				SUM(ISNULL(PriceInBaseCurrency,0)) - SUM(ISNULL(DiscountInBaseCurrentcy,0)) + SUM(ISNULL(AdditionInBaseCurrency,0)) AS NetPriceInBaseCurrency
				From INV.vwServiceInventoryPurchaseInvoiceItem   
				GROUP BY InventoryPurchaseInvoiceREf) IPI ON [IP].InventoryPurchaseInvoiceID = ipi.InventoryPurchaseInvoiceREf  
	WHERE [IP].[Type] = 2 /* InventoryPurchaseInvoiceType.Service = 2*/
GO