IF OBJECT_ID('DST.vwColdDistributionInvoice') IS NOT NULL
	DROP VIEW DST.vwColdDistributionInvoice
GO

CREATE VIEW DST.vwColdDistributionInvoice
AS

SELECT
	CDI.[ColdDistributionInvoiceId]
   ,CDI.[ColdDistributionRef]
   ,CDI.[RowNumber]
   ,CDI.[InvoiceRef]
   ,CDI.[DebtCollectionListAmount]
   ,CDI.[DebtCollectionListDiscount]
   ,CDI.[DebtCollectionListUnexecutedActReasonRef]
   ,UAR_DCL.[Title] AS [DebtCollectionListUnexecutedActReasonTitle]
   ,UAR_DCL.[Title_En] AS [DebtCollectionListUnexecutedActReasonTitle_En]
   ,HasDebtCollection = CASE
                            WHEN CDI.[DebtCollectionListUnexecutedActReasonRef] IS NULL AND CDI.[DebtCollectionListAmount] IS NULL
                            THEN 0 ELSE 1
                        END
   ,I.[Number] AS [InvoiceNumber]
   ,I.[Date] AS [InvoiceDate]
   ,I.[CustomerPartyDLCode]
   ,I.[CustomerPartyName]
   ,I.[CustomerPartyName_En]
   ,PPA.[AreaTitle]
   ,PPA.[AreaTitle_En]
   ,PPA.[PathTitle]
   ,PPA.[PathTitle_En]
   ,I.[PartyAddress] AS [CustomerPartyAddress]
   ,I.[PartyAddress_En] AS [CustomerPartyAddress_En]
   ,I.[SaleTypeTitle]
   ,I.[SaleTypeTitle_En]
   ,I.[NetPrice]
   ,I.[CurrencyTitle]
   ,I.[CurrencyTitle_En]
   ,ITWV.TotalWeight
   ,ITWV.TotalVolume
   ,CAST(
	CASE
		WHEN IDC.[InventoryDeliveryCount] > 0 THEN 1
		ELSE 0
	END
	AS BIT) AS [HasInventoryDelivery]
   ,CAST(
	CASE
		WHEN PASC.[PartyAccountSettlementCount] > 0 THEN 1
		ELSE 0
	END
	AS BIT) AS [HasPartyAccountSettlement]
   ,CAST(
	CASE
		WHEN IDC.[InventoryDeliveryCount] > 0 THEN 1
		WHEN CDI.[UnexecutedActReasonRef] IS NOT NULL THEN 2
		ELSE 0
	END
	AS INT) AS [State]
   ,CDI.[UnexecutedActReasonRef]
   ,UAR.[Title] AS [UnexecutedActReasonTitle]
   ,UAR.[Title_En] AS [UnexecutedActReasonTitle_En]
FROM DST.ColdDistributionInvoice AS CDI

JOIN SLS.vwInvoice AS I
	ON CDI.[InvoiceRef] = I.[InvoiceId]

LEFT JOIN DST.vwPathPartyAddress AS PPA
	ON I.[PartyAddressRef] = PPA.[PartyAddressRef]

LEFT JOIN (SELECT
		II.[InvoiceRef]
	   ,COUNT(DISTINCT [InventoryDeliveryRef]) AS InventoryDeliveryCount
	FROM INV.InventoryDeliveryItem AS IID
	JOIN SLS.InvoiceItem AS II
		ON IID.[BaseInvoiceItem] = II.[InvoiceItemID]
	GROUP BY II.[InvoiceRef]) AS IDC
	ON IDC.[InvoiceRef] = I.[InvoiceId]

LEFT JOIN (SELECT
		[DebitEntityRef]
	   ,COUNT([PartyAccountSettlementItemID]) AS [PartyAccountSettlementCount]
	FROM RPA.PartyAccountSettlementItem
	WHERE [DebitEntityRef] IS NOT NULL
	GROUP BY [DebitEntityRef]) AS PASC
	ON PASC.[DebitEntityRef] = I.[InvoiceId]

LEFT JOIN DST.vwUnexecutedActReason AS UAR
	ON CDI.[UnexecutedActReasonRef] = UAR.[UnexecutedActReasonId]

LEFT JOIN DST.vwUnexecutedActReason AS UAR_DCL
	ON CDI.[DebtCollectionListUnexecutedActReasonRef] = UAR_DCL.[UnexecutedActReasonId]

JOIN (SELECT
		II.InvoiceRef
	   ,SUM(I.Weight * II.Quantity) TotalWeight
	   ,SUM(I.Volume * II.Quantity) TotalVolume
	FROM SLS.InvoiceItem II
	JOIN INV.Item I
		ON II.ItemRef = I.ItemID
	GROUP BY II.InvoiceRef) AS ITWV
	ON I.InvoiceId = ITWV.InvoiceRef