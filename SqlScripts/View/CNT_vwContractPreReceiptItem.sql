If Object_ID('CNT.vwContractPreReceiptItem') Is Not Null
	Drop View CNT.vwContractPreReceiptItem
GO
CREATE VIEW CNT.vwContractPreReceiptItem
AS
SELECT     PR.PreReceiptID, PR.ReceiptRef, PR.ContractRef, PR.RowNumber, PR.Date, PR.Price, PR.Type, PR.Description, PR.Description_En, PR.ReceiptNumber,
PR.PaymentRef, PH.Number PaymentNumber, PH.Date PaymentDate
FROM         CNT.ContractPreReceiptItem AS PR LEFT OUTER JOIN
                      RPA.ReceiptHeader AS RH ON PR.ReceiptRef = RH.ReceiptHeaderId LEFT OUTER JOIN
                      RPA.PaymentHeader AS PH ON PR.PaymentRef = PH.PaymentHeaderId

