IF OBJECT_ID('DST.vwDebtCollectionListInvoice') IS NOT NULL
	DROP VIEW DST.vwDebtCollectionListInvoice
GO

CREATE VIEW DST.vwDebtCollectionListInvoice
AS

SELECT
	DCLI.[DebtCollectionListInvoiceId]
   ,DCLI.[DebtCollectionListRef]
   ,DCLI.[RowNumber]
   ,DCLI.[InvoiceRef]
   ,I.[Number] AS [InvoiceNumber]
   ,[ReturnedInvoiceNumber] = null
   ,[ReturnedInvoiceRef] = null
   ,I.[Date] AS [InvoiceDate]
   ,I.[CustomerPartyRef]
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
   ,I.[Agreements] AS Agreement
   ,I.[NetPrice]
   ,I.[RemainingAmount]
   ,DCLI.[Amount]
   ,DCLI.[Discount]
   ,CAST(
	CASE
		WHEN PASC.[PartyAccountSettlementCount] > 0 THEN 1
		ELSE 0
	END
	AS BIT) AS [HasPartyAccountSettlement]
   ,DCLI.[UnexecutedActReasonRef]
   ,UAR.[Title] AS [UnexecutedActReasonTitle]
   ,UAR.[Title_En] AS [UnexecutedActReasonTitle_En]
   ,I.[CurrencyRef] AS [InvoiceCurrencyRef]
   ,DCLI.[PartyAccountSettlementRef]
FROM DST.DebtCollectionListInvoice AS DCLI

JOIN SLS.vwInvoice AS I
	ON DCLI.[InvoiceRef] = I.[InvoiceId]

LEFT JOIN DST.vwPathPartyAddress AS PPA
	ON I.[PartyAddressRef] = PPA.[PartyAddressRef]

LEFT JOIN (SELECT
		[DebitEntityRef]
	   ,COUNT([PartyAccountSettlementItemID]) AS [PartyAccountSettlementCount]
	FROM RPA.PartyAccountSettlementItem
	WHERE [DebitEntityRef] IS NOT NULL and [DebitEntityType] = 1
	GROUP BY [DebitEntityRef]) AS PASC
	ON PASC.[DebitEntityRef] = I.[InvoiceId]

LEFT JOIN DST.vwUnexecutedActReason AS UAR
	ON DCLI.[UnexecutedActReasonRef] = UAR.[UnexecutedActReasonId]

UNION ALL

SELECT
	DCLI.[DebtCollectionListInvoiceId]
   ,DCLI.[DebtCollectionListRef]
   ,DCLI.[RowNumber]
   ,[InvoiceRef] = null
   ,[InvoiceNumber] = null
   ,RI.[Number] AS [ReturnedInvoiceNumber]
   ,DCLI.[ReturnedInvoiceRef]
   ,RI.[Date] AS [InvoiceDate]
   ,RI.[CustomerPartyRef]
   ,RI.[CustomerPartyDLCode]
   ,RI.[CustomerPartyName]
   ,RI.[CustomerPartyName_En]
   ,PPA.[AreaTitle]
   ,PPA.[AreaTitle_En]
   ,PPA.[PathTitle]
   ,PPA.[PathTitle_En]
   ,RI.[PartyAddress] AS [CustomerPartyAddress]
   ,RI.[PartyAddress_En] AS [CustomerPartyAddress_En]
   ,RI.[SaleTypeTitle]
   ,RI.[SaleTypeTitle_En]
   ,[Agreement] = ''
   ,-RI.[NetPrice] NetPrice
   ,-RI.[RemainingAmount] 
   ,DCLI.[Amount]
   ,DCLI.[Discount]
   ,CAST(
	CASE
		WHEN PASI.[PartyAccountSettlementCount] > 0 THEN 1
		ELSE 0
	END
	AS BIT) AS [HasPartyAccountSettlement]
   ,DCLI.[UnexecutedActReasonRef]
   ,UAR.[Title] AS [UnexecutedActReasonTitle]
   ,UAR.[Title_En] AS [UnexecutedActReasonTitle_En]
   ,RI.[CurrencyRef] AS [InvoiceCurrencyRef]
   ,DCLI.[PartyAccountSettlementRef]
FROM DST.DebtCollectionListInvoice AS DCLI

JOIN SLS.vwReturnedInvoice AS RI
	ON DCLI.[ReturnedInvoiceRef] = RI.[ReturnedInvoiceId]

LEFT JOIN DST.vwPathPartyAddress AS PPA
	ON RI.[PartyAddressRef] = PPA.[PartyAddressRef]

LEFT JOIN (SELECT
		[CreditEntityRef]
	   ,COUNT([PartyAccountSettlementItemID]) AS [PartyAccountSettlementCount]
	FROM RPA.PartyAccountSettlementItem
	WHERE [CreditEntityRef] IS NOT NULL and [CreditEntityType] = 22
	GROUP BY [CreditEntityRef]) AS PASI
	ON PASI.[CreditEntityRef] = RI.[ReturnedInvoiceId]

LEFT JOIN DST.vwUnexecutedActReason AS UAR
	ON DCLI.[UnexecutedActReasonRef] = UAR.[UnexecutedActReasonId]