If Object_ID('RPA.vwPosSettlementReceipt') Is Not Null
	Drop View RPA.vwPosSettlementReceipt
GO
CREATE VIEW RPA.vwPosSettlementReceipt
AS
SELECT     RPA.PosSettlementReceipt.PosSettlementReceiptID, RPA.PosSettlementReceipt.PosSettlementRef, RPA.PosSettlementReceipt.ReceiptPosRef, 
           RPA.vwReceiptHeader.Number AS ReceiptNumber, RPA.vwReceiptHeader.Date AS ReceiptDate, RPA.vwReceiptHeader.DlTitle, 
		RPA.vwReceiptHeader.DlTitle_En, RPA.ReceiptPos.Amount AS ReceiptAmount, RPA.PosSettlementReceipt.Version
FROM         RPA.PosSettlementReceipt INNER JOIN
                      RPA.ReceiptPos ON RPA.PosSettlementReceipt.ReceiptPosRef = RPA.ReceiptPos.ReceiptPosId INNER JOIN
                      RPA.vwReceiptHeader ON RPA.ReceiptPos.ReceiptHeaderRef = RPA.vwReceiptHeader.ReceiptHeaderId

