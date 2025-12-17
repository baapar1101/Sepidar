IF OBJECT_ID('DST.vwDebtCollectionList') IS NOT NULL
	DROP VIEW DST.vwDebtCollectionList
GO

CREATE VIEW DST.vwDebtCollectionList
AS

SELECT
	DCL.[DebtCollectionListId]
   ,DCL.[Date]
   ,DCL.[Number]
   ,DCL.[DebtCollectorPartyRef]
   ,P.[DLCode] AS [DebtCollectorPartyDLCode]
   ,P.[DLTitle] AS [DebtCollectorPartyDLTitle]
   ,P.[DLTitle_En] AS [DebtCollectorPartyDLTitle_En]
   ,DCL.[CurrencyRef]
   ,C.[Title] AS [CurrencyTitle]
   ,C.[Title_En] AS [CurrencyTitle_En]
   ,C.[PrecisionCount] AS [CurrencyPrecisionCount]
   ,DCL.[Rate]
   ,DCL.[State]
   ,DCL.[IsModifiedByDevice]
   ,ISNULL([SettlementSummary].[SettlementAmount], 0) AS [SettlementAmount]
   ,ISNULL([SettlementSummary].[DiscountAmount], 0) AS [DiscountAmount]
   ,ISNULL([SettlementSummary].[CashAmount], 0) AS [CashAmount]
   ,ISNULL([SettlementSummary].[ChequeAmount], 0) AS [ChequeAmount]
   ,ISNULL([SettlementSummary].[PosAmount], 0) AS [PosAmount]
   ,ISNULL([SettlementSummary].[DraftAmount], 0) AS [DraftAmount]
   ,DCL.[FiscalYearRef]
   ,DCL.[Version]
   ,DCL.[Creator]
   ,DCL.[CreationDate]
   ,DCL.[LastModifier]
   ,DCL.[LastModificationDate]
   ,CU.Name CreatorName
   ,MU.Name LastModifierName
FROM DST.DebtCollectionList AS DCL
JOIN GNR.vwParty AS P
	ON DCL.[DebtCollectorPartyRef] = P.[PartyId]
JOIN GNR.Currency AS C
	ON DCL.[CurrencyRef] = C.[CurrencyID]
INNER JOIN FMk.[User] CU
	ON DCL.Creator = CU.UserID
INNER JOIN FMk.[User] MU
	ON DCL.LastModifier = MU.UserID
LEFT JOIN (SELECT
		[DebtCollectionListInvoice].[DebtCollectionListRef]
	   ,ISNULL(SUM([PASI].[Amount]), 0) SettlementAmount
	   ,ISNULL(SUM([RH].[Discount]), 0) DiscountAmount
	   ,ISNULL(SUM([RH].[Amount]), 0) CashAmount
	   ,ISNULL(SUM([RC].[Amount]), 0) ChequeAmount
	   ,ISNULL(SUM([RD].[Amount]), 0) DraftAmount
	   ,ISNULL(SUM([RP].[Amount]), 0) PosAmount
	FROM [RPA].[PartyAccountSettlementItem] AS [PASI]
	JOIN (SELECT DISTINCT
			[DCLI].[DebtCollectionListRef]
		   ,[DCLI].[PartyAccountSettlementRef]
		FROM [DST].[DebtCollectionListInvoice] AS [DCLI]
		WHERE [DCLI].[PartyAccountSettlementRef] IS NOT NULL) AS DebtCollectionListInvoice
		ON [DebtCollectionListInvoice].[PartyAccountSettlementRef] = [PASI].[PartyAccountSettlementRef]
	LEFT JOIN [RPA].[ReceiptHeader] AS [RH]
		ON [RH].[ReceiptHeaderId] = [PASI].[CreditEntityRef]
	LEFT JOIN (SELECT
			[RC].[ReceiptHeaderRef]
		   ,SUM([RC].[Amount]) AS [Amount]
		FROM [RPA].[ReceiptCheque] AS [RC]
		GROUP BY [RC].[ReceiptHeaderRef]) AS [RC]
		ON [RH].[ReceiptHeaderId] = [RC].[ReceiptHeaderRef]
	LEFT JOIN (SELECT
			[RD].[ReceiptHeaderRef]
		   ,SUM([RD].[Amount]) AS [Amount]
		FROM [RPA].[ReceiptDraft] AS [RD]
		GROUP BY [RD].[ReceiptHeaderRef]) AS [RD]
		ON [RH].[ReceiptHeaderId] = [RD].[ReceiptHeaderRef]
	LEFT JOIN (SELECT
			[RP].[ReceiptHeaderRef]
		   ,SUM([RP].[Amount]) AS [Amount]
		FROM [RPA].[ReceiptPos] AS [RP]
		GROUP BY [RP].[ReceiptHeaderRef]) AS [RP]
		ON [RH].[ReceiptHeaderId] = [RP].[ReceiptHeaderRef]
	WHERE [PASI].[CreditEntityType] = 23
	GROUP BY [DebtCollectionListInvoice].[DebtCollectionListRef]) SettlementSummary
	ON [DCL].[DebtCollectionListId] = [SettlementSummary].[DebtCollectionListRef]
