If Object_ID('CNT.vwSettlementItem') Is Not Null
	Drop View CNT.vwSettlementItem
GO
CREATE VIEW CNT.vwSettlementItem
AS
SELECT     SEI.SettlementItemID, SEI.RowNumber, SEI.SettlementRef, SEI.StatusRef, SEI.Amount, SE.ContractRef,
                      S.Number AS StatusNumber, SEI.Remain, SE.Number AS SettlementNumber, SE.Date AS SettlementDate, SE.ReceiptRef, 
                      RPA.ReceiptHeader.Number AS ReceiptNumber, S.[Date] AS StatusDate, S.StatusRefType StatusRefType,
					  SEI.Description_En, SEI.Description
FROM         CNT.SettlementItem AS SEI INNER JOIN
                      CNT.Settlement AS SE ON SEI.SettlementRef = SE.SettlementID INNER JOIN
                      CNT.Contract AS C ON SE.ContractRef = C.ContractID AND SE.ContractRef = C.ContractID INNER JOIN
                      CNT.Status AS S ON SEI.StatusRef = S.StatusID LEFT OUTER JOIN
                      RPA.ReceiptHeader ON SE.ReceiptRef = RPA.ReceiptHeader.ReceiptHeaderId

