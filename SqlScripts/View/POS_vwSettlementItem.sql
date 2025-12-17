If Object_ID('POS.vwSettlementItem') Is Not Null
	Drop View POS.vwSettlementItem
GO
Create View [POS].[vwSettlementItem]
as
Select 
	[SettlementItemID],
	[SettlementRef],
	[RowID],
	[InvoiceRef],
	[ReturnedInvoiceRef],
	EntityFullName,
	[SalesInvoiceRef],
	[SalesReturnedInvoiceRef],
	CASE WHEN InvoiceRef IS NOT NULL THEN 1
		 WHEN ReturnedInvoiceRef IS NOT NULL THEN 2
		 ELSE 3 END ItemType,
	CASE WHEN InvoiceRef IS NOT NULL THEN I.Number
		 WHEN ReturnedInvoiceRef IS NOT NULL THEN RI.Number
		 ELSE 0 END Number,
	CASE WHEN InvoiceRef IS NOT NULL THEN I.Date
		 WHEN ReturnedInvoiceRef IS NOT NULL THEN RI.Date
		 ELSE NULL END Date,
	CASE WHEN InvoiceRef IS NOT NULL THEN I.NetPrice
		 WHEN ReturnedInvoiceRef IS NOT NULL THEN RI.NetPrice * - 1
		 ELSE NULL END NetPrice,
	CASE WHEN InvoiceRef IS NOT NULL THEN I.CashAmount
		 WHEN ReturnedInvoiceRef IS NOT NULL THEN RI.CashAmount * - 1
		 ELSE NULL END CashAmount,
	CASE WHEN InvoiceRef IS NOT NULL THEN I.ChequeAmount
		 WHEN ReturnedInvoiceRef IS NOT NULL THEN RI.ChequeAmount * - 1
		 ELSE NULL END ChequeAmount,
	CASE WHEN InvoiceRef IS NOT NULL THEN I.ChequeSecondaryNumber
		 WHEN ReturnedInvoiceRef IS NOT NULL THEN RI.ChequeSecondaryNumber
		 ELSE NULL END ChequeSecondaryNumber,
	CASE WHEN InvoiceRef IS NOT NULL THEN I.CardReaderAmount
		 WHEN ReturnedInvoiceRef IS NOT NULL THEN RI.CardReaderAmount * - 1
		 ELSE NULL END CardReaderAmount,
	CASE WHEN InvoiceRef IS NOT NULL THEN I.PosRef
		 WHEN ReturnedInvoiceRef IS NOT NULL THEN NULL
		 ELSE NULL END PosRef,
	CASE WHEN InvoiceRef IS NOT NULL THEN (SELECT TerminalNO FROM RPA.POS WHERE PosID = I.PosRef)
		 WHEN ReturnedInvoiceRef IS NOT NULL THEN NULL
		 ELSE NULL END TerminalNO,
	CASE WHEN InvoiceRef IS NOT NULL THEN I.TransactionNumber
		 WHEN ReturnedInvoiceRef IS NOT NULL THEN NULL
		 ELSE NULL END TransactionNumber,
	CASE WHEN InvoiceRef IS NOT NULL THEN I.OtherAmount
		 WHEN ReturnedInvoiceRef IS NOT NULL THEN RI.OtherAmount * -1
		 ELSE NULL END OtherAmount,
	CASE WHEN InvoiceRef IS NOT NULL THEN I.OtherDescription
		 WHEN ReturnedInvoiceRef IS NOT NULL THEN RI.OtherDescription
		 ELSE NULL END OtherDescription,
	CASE WHEN InvoiceRef IS NOT NULL THEN I.CashPaidAmount * -1
		 WHEN ReturnedInvoiceRef IS NOT NULL THEN RI.CashPaidAmount
		 ELSE NULL END CashPaidAmount,
	CASE WHEN InvoiceRef IS NOT NULL THEN I.SaleTypeRef
		 WHEN ReturnedInvoiceRef IS NOT NULL THEN RI.SaleTypeRef
		 ELSE NULL END SaleTypeRef,
	CASE WHEN InvoiceRef IS NOT NULL THEN I.StockRef
		 WHEN ReturnedInvoiceRef IS NOT NULL THEN RI.StockRef
		 ELSE NULL END StockRef
FROM [POS].[SettlementItem] S
LEFT JOIN POS.Invoice I ON S.InvoiceRef = I.InvoiceID
LEFT JOIN POS.ReturnedInvoice RI ON S.ReturnedInvoiceRef = RI.ReturnedInvoiceID

