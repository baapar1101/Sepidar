If Object_ID('POS.vwSettlement') Is Not Null
	Drop View POS.vwSettlement
GO
Create View [POS].[vwSettlement]
as
Select 
	S.[SettlementID], 
	Case WHEN S.ReceiptHeaderRef IS NOT NULL OR S.PaymentHeaderRef IS NOT NULL THEN 3
		 WHEN Exists (Select * from POS.SettlementItem SI where SI.SettlementRef = S.SettlementID) THEN 2
		 ELSE 1 END as [Status],
	S.[CashierRef], 
	C.Title CashierTitle, 
	P.[PartyID] PartyRef, 
	P.[DLRef] PartyDLRef, 
	P.FullName [PartyFullName], 
	P.DLCode PartyDLCode,
	S.[Number], 
	S.[FromDate], 
	S.[ToDate], 
	S.[ReceiptHeaderRef], 
	RH.Number ReceiptHeaderNumber,
	RH.Date ReceiptHeaderDate,
	RH.TotalAmountInBaseCurrency ReceiptHeaderTotalAmount,
	S.[PaymentHeaderRef], 
	PH.Number PaymentHeaderNumber,
	PH.Date PaymentHeaderDate,
	PH.TotalAmountInBaseCurrency PaymentHeaderTotalAmount,
	(Select SUM(CashAmount) + SUM(ChequeAmount) + SUM(CardReaderAmount) + SUM(OtherAmount) + SUM(CashPaidAmount)  FROM POS.vwSettlementItem WHERE SettlementRef = SettlementID) as  SumNetReceiptAmount,
	S.[FiscalYearRef], 
	S.[Version], 
	S.[Creator], 
	S.[CreationDate], 
	S.[LastModifier], 
	S.[LastModificationDate]
FROM [POS].[Settlement] S
JOIN POS.vwCashier C ON C.CashierID = S.CashierRef
LEFT JOIN RPA.ReceiptHeader RH ON ReceiptHeaderRef = RH.ReceiptHeaderID
LEFT JOIN RPA.PaymentHeader PH ON PaymentHeaderRef = PH.PaymentHeaderID
LEFT JOIN GNR.vwParty P ON C.PartyRef = P.PartyID
