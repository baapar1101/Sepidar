IF OBJECT_ID('DST.vwHotDistributionSaleDocument') IS NOT NULL
	DROP VIEW DST.vwHotDistributionSaleDocument
GO

CREATE VIEW DST.vwHotDistributionSaleDocument
AS

SELECT
	[T].[HotDistributionSaleDocumentId]
   ,[T].[HotDistributionRef]
   ,CASE
		WHEN [T].[InvoiceRef] IS NOT NULL THEN 1
		WHEN [T].[ReturnedInvoiceRef] IS NOT NULL THEN 2
		ELSE NULL
	END AS [Type]
   ,[T].[InvoiceRef]
   ,[T].[InvoiceNumber]
   ,[T].[ReturnedInvoiceRef]
   ,[T].[ReturnedInvoiceNumber]
   ,[T].[Date]
   ,[T].[CustomerPartyDLCode]
   ,[T].[CustomerPartyName]
   ,[T].[CustomerPartyName_En]
   ,[T].[SaleTypeTitle]
   ,[T].[SaleTypeTitle_En]
   ,[T].[Price]
   ,[T].[NetPrice]
   ,[T].[CurrencyTitle]
   ,[T].[CurrencyTitle_En]
   ,[PPA].[AreaTitle]
   ,[PPA].[AreaTitle_En]
   ,[PPA].[PathTitle]
   ,[PPA].[PathTitle_En]
   ,[T].[PartyAddress]
   ,[T].[PartyAddress_En]
   ,[T].[State] AS [DocumentState]
   ,[T].[HasPartyAccountSettlement]
   ,[T].[IsDocCreatedByHotDistribution]
   ,CAST(
	CASE
		WHEN [T].[Guid] IS NOT NULL THEN 1
		ELSE 0
	END
	AS BIT) AS [IsDocCreatedByDevice]
FROM (SELECT
		[HDSD].[HotDistributionSaleDocumentId]
	   ,[HDSD].[HotDistributionRef]
	   ,[HDSD].[InvoiceRef]
	   ,[HDSD].[ReturnedInvoiceRef]
	   ,[I].[Number] AS [InvoiceNumber]
	   ,NULL AS [ReturnedInvoiceNumber]
	   ,[I].[Date]
	   ,[I].[CustomerPartyDLCode]
	   ,[I].[CustomerPartyName]
	   ,[I].[CustomerPartyName_En]
	   ,[I].[SaleTypeTitle]
	   ,[I].[SaleTypeTitle_En]
	   ,[I].[Price]
	   ,[I].[NetPrice]
	   ,[I].[CurrencyTitle]
	   ,[I].[CurrencyTitle_En]
	   ,[I].[PartyAddressRef]
	   ,[I].[PartyAddress]
	   ,[I].[PartyAddress_En]
	   ,[I].[State]
	   ,CAST(
		CASE
			WHEN PASC.[PartyAccountSettlementCount] > 0 THEN 1
			ELSE 0
		END
		AS BIT) AS [HasPartyAccountSettlement]
	   ,[HDSD].[IsDocCreatedByHotDistribution]
	   ,[I].[Guid]
	FROM [DST].[HotDistributionSaleDocument] AS [HDSD]
	JOIN [SLS].[vwInvoice] AS [I]
		ON [HDSD].[InvoiceRef] = [I].[InvoiceId]
	LEFT JOIN (SELECT
			[DebitEntityRef]
		   ,COUNT([PartyAccountSettlementItemID]) AS [PartyAccountSettlementCount]
		FROM RPA.PartyAccountSettlementItem
		WHERE [DebitEntityRef] IS NOT NULL
		GROUP BY [DebitEntityRef]) AS PASC
		ON PASC.[DebitEntityRef] = I.[InvoiceId]

	UNION

	SELECT
		[HDSD].[HotDistributionSaleDocumentId]
	   ,[HDSD].[HotDistributionRef]
	   ,[HDSD].[InvoiceRef]
	   ,[HDSD].[ReturnedInvoiceRef]
	   ,NULL AS [InvoiceNumber]
	   ,[RI].[Number] AS [ReturnedInvoiceNumber]
	   ,[RI].[Date]
	   ,[RI].[CustomerPartyDLCode]
	   ,[RI].[CustomerPartyName]
	   ,[RI].[CustomerPartyName_En]
	   ,[RI].[SaleTypeTitle]
	   ,[RI].[SaleTypeTitle_En]
	   ,[RI].[Price]
	   ,[RI].[NetPrice]
	   ,[RI].[CurrencyTitle]
	   ,[RI].[CurrencyTitle_En]
	   ,[RI].[PartyAddressRef]
	   ,[RI].[PartyAddress]
	   ,[RI].[PartyAddress_En]
	   ,1 AS [State]
	   ,0 AS [HasPartyAccountSettlement]
	   ,[HDSD].[IsDocCreatedByHotDistribution]
	   ,[RI].[Guid]
	FROM [DST].[HotDistributionSaleDocument] AS [HDSD]
	JOIN [SLS].[vwReturnedInvoice] AS [RI]
		ON [HDSD].[ReturnedInvoiceRef] = [RI].[ReturnedInvoiceId]) AS T
LEFT JOIN [DST].[vwPathPartyAddress] AS [PPA]
	ON [PPA].[PartyAddressRef] = [T].[PartyAddressRef]
