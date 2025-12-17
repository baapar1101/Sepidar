If Object_ID('RPA.vwPosBalance') Is Not Null
	Drop View RPA.vwPosBalance
GO
CREATE VIEW RPA.vwPosBalance
AS
SELECT     PosId PosRef, FirstAmount AS IncreaseAmount, 0 AS DecreaseAmount, 3 AS DocSpecificationRef, PosId AS DocRef, 0 AS Date, 
           'موجودي اوليه' AS DocDescription, 'First Balance' AS DocDescription_En, '' HeaderNumber, 
			'' ItemDescription, '' ItemDescription_En, FirstAmount * Rate AmountInBaseCurrency, Rate, null ReceiptPaymentType, -1 FiscalYearRef,
			NULL AS [TrackingCode]
FROM         RPA.Pos

UNION ALL
SELECT     POS.PosRef, POS.Amount AS IncreaseAmount, 0 AS DecreaseAmount, 13 AS DocSpecificationRef, POS.ReceiptHeaderRef AS DocRef, POS.HeaderDate AS Date, 
           'دريافت از كارت خوان' AS Description, 'Pos Receipt' AS Description_En,  POS.HeaderNumber, 
			'' ItemDescription, '' ItemDescription_En, POS.AmountInBaseCurrency, POS.Rate, Header.Type ReceiptType, Header.FiscalYearRef,
			[POS].[TrackingCode]
FROM         RPA.ReceiptPos  POS INNER jOIN
			RPA.ReceiptHeader Header ON Header.ReceiptHeaderId = POS.ReceiptHeaderRef

UNION ALL
SELECT    RPA.ReceiptPos.PosRef, 0 AS IncreaseAmount, RPA.ReceiptPos.Amount AS DecreaseAmount, 61 AS DocSpecificationRef, 
		  RPA.PosSettlementReceipt.PosSettlementRef AS DocRef, RPA.ReceiptPos.HeaderDate AS Date, 
          'تسويه كارت خوان' AS Description, 'Pos Receipt' AS Description_En,  HeaderNumber, '' ItemDescription, 
		  '' ItemDescription_En, -1 * RPA.ReceiptPos.AmountInBaseCurrency, RPA.ReceiptPos.Rate, Header.Type ReceiptType, Header.FiscalYearRef,
		  [TrackingCode]
FROM    RPA.ReceiptPos INNER JOIN 
		RPA.PosSettlementReceipt ON ReceiptPosRef = ReceiptPosId INNER jOIN
		RPA.ReceiptHeader Header ON Header.ReceiptHeaderId = RPA.ReceiptPos.ReceiptHeaderRef


