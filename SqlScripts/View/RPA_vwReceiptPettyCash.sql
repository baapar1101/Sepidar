IF OBJECT_ID('RPA.vwReceiptPettyCash') IS NOT NULL
	DROP VIEW [RPA].[vwReceiptPettyCash]
GO
CREATE VIEW [RPA].[vwReceiptPettyCash]
AS
SELECT		[RPC].[ReceiptPettyCashId],
			[RPC].[CurrencyRef],
			[RPC].[PettyCashRef],
			[PC].[Title] AS [PettyCashTitle],
			[PC].[Title_En] AS [PettyCashTitle_En],
			[RPC].[ReceiptHeaderRef],
			[RPC].[Amount],
			[RPC].[AmountInBaseCurrency],
			[RPC].[Description],
			[RPC].[Description_En],
			[RPC].[Rate],
			[CUR].[Title] AS [CurrencyTitle],
			[CUR].[Title_En] AS [CurrencyTitle_En]
FROM		[RPA].[ReceiptPettyCash] AS [RPC]
INNER JOIN	[GNR].[Currency] AS [CUR] ON [RPC].[CurrencyRef] = [CUR].[CurrencyID]
INNER JOIN	[RPA].[PettyCash] AS [PC] ON [RPC].[PettyCashRef] = [PC].[PettyCashId]
