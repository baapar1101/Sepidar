IF Object_ID('DST.vwColdDistributionReturnedInvoice') IS NOT NULL
	DROP VIEW DST.vwColdDistributionReturnedInvoice
GO

CREATE VIEW DST.vwColdDistributionReturnedInvoice
AS

SELECT
	CDRI.[ColdDistributionReturnedInvoiceId]
	, CDRI.[ColdDistributionRef]
	, CDRI.[RowNumber]
	, CDRI.[ReturnedInvoiceRef]
    , CDRI.[DebtCollectionListAmount]
    , CDRI.[DebtCollectionListDiscount]
    , CDRI.[DebtCollectionListUnexecutedActReasonRef]
	, UAR_DCL.[Title]	 AS [DebtCollectionListUnexecutedActReasonTitle]
	, UAR_DCL.[Title_En] AS [DebtCollectionListUnexecutedActReasonTitle_En]
    , HasDebtCollection = CASE
                              WHEN CDRI.[DebtCollectionListUnexecutedActReasonRef] IS NULL AND CDRI.[DebtCollectionListAmount] IS NULL
                              THEN 0 ELSE 1
                          END
	, RI.[Number]					AS [ReturnedInvoiceNumber]
	, RI.[Date]						AS [ReturnedInvoiceDate]
	, RI.[CustomerPartyDLCode]
	, RI.[CustomerPartyName]
	, RI.[CustomerPartyName_En]
	, PPA.[AreaTitle]
	, PPA.[AreaTitle_En]
	, PPA.[PathTitle]
	, PPA.[PathTitle_En]
	, RI.[PartyAddress]				AS [CustomerPartyAddress]
	, RI.[PartyAddress_En]			AS [CustomerPartyAddress_En]
	--, ShopName
	, RI.[SaleTypeTitle]
	, RI.[SaleTypeTitle_En]
	, RI.[NetPrice]
	, CAST(
		CASE 
			WHEN IDC.[InventoryDeliveryCount] > 0 
			THEN 1 
			ELSE 0 
			END
		AS BIT)						AS [HasInventoryDelivery]
	, CAST(
		CASE 
			WHEN IDC.[InventoryDeliveryCount] > 0 THEN 1
			WHEN CDRI.[UnexecutedActReasonRef] IS NOT NULL THEN 2
			ELSE 0
			END
		AS INT)						AS [State]
	, CDRI.[UnexecutedActReasonRef]
	, UAR.[Title]					AS [UnexecutedActReasonTitle]
	, UAR.[Title_En]				AS [UnexecutedActReasonTitle_En]
FROM 
	DST.ColdDistributionReturnedInvoice AS CDRI

		JOIN SLS.vwReturnedInvoice AS RI
			ON CDRI.[ReturnedInvoiceRef] = RI.[ReturnedInvoiceId]

		LEFT JOIN DST.vwPathPartyAddress AS PPA
			ON RI.[PartyAddressRef] = PPA.[PartyAddressRef]

		LEFT JOIN (SELECT 
						RII.[ReturnedInvoiceRef]
						, COUNT(DISTINCT [IDRI].[InventoryDeliveryRef]) AS InventoryDeliveryCount 
					FROM 
						INV.vwInventoryDeliveryReturnItem AS IDRI
							JOIN SLS.ReturnedInvoiceItem AS RII
								ON IDRI.[BaseReturnedInvoiceItem] = RII.[ReturnedInvoiceItemID] 
					GROUP BY
						RII.[ReturnedInvoiceRef]) AS IDC
			ON IDC.[ReturnedInvoiceRef] = RI.[ReturnedInvoiceId]

		LEFT JOIN DST.vwUnexecutedActReason AS UAR
			ON CDRI.[UnexecutedActReasonRef] = UAR.[UnexecutedActReasonId]

		LEFT JOIN DST.vwUnexecutedActReason AS UAR_DCL
			ON CDRI.[DebtCollectionListUnexecutedActReasonRef] = UAR_DCL.[UnexecutedActReasonId]