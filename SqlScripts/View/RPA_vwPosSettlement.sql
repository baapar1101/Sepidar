If Object_ID('RPA.vwPosSettlement') Is Not Null
	Drop View RPA.vwPosSettlement
GO
CREATE VIEW RPA.vwPosSettlement
AS
SELECT     S.PosSettlementID, S.Number, S.Date, S.SettleReceiptsTo, S.SettlementReceiptRef, R.Number AS SettlementReceiptNumber, R.Date AS SettlementReceiptDate, S.Version, S.Creator, 
           S.CreationDate, S.LastModifier, S.LastModificationDate, S.PosRef, P.TerminalNo AS PosTerminalNo, P.BankAccountTitle AS PosBankAccountTitle, S.FiscalYearRef,
		   P.BankAccountTitle_En AS PosBankAccountTitle_En
FROM         RPA.PosSettlement AS S INNER JOIN
           RPA.vwPos AS P ON S.PosRef = P.PosId LEFT OUTER JOIN
           RPA.ReceiptHeader AS R ON S.SettlementReceiptRef = R.ReceiptHeaderId

