If Object_ID('CNT.vwSettlementDebtItem') Is Not Null
	Drop View CNT.vwSettlementDebtItem
GO
CREATE VIEW CNT.vwSettlementDebtItem
AS
SELECT     SDI.SettlementDebtItemID, SDI.RowNumber, SDI.SettlementRef, SDI.CostStatementItemRef, SDI.Amount,
		   SE.ContractRef,SE.Number AS SettlementNumber, SE.Date AS SettlementDate, SE.PaymentNumber,
		   C.ContractID AS ContractDate, CS.CostStatementRef, CS.CostStatementNumber, 
		   CS.CostStatementDate AS CostStatementDate,SDI.Remain, CS.InvoiceNumber, SDI.Description_En, SDI.Description
FROM         CNT.SettlementDebtItem AS SDI INNER JOIN
                      CNT.vwSettlement AS SE ON SDI.SettlementRef = SE.SettlementID INNER JOIN
                      CNT.Contract AS C ON SE.ContractRef = C.ContractID AND SE.ContractRef = C.ContractID INNER JOIN
                      CNT.vwCostStatementItem AS CS ON SDI.CostStatementItemRef = CS.CostStatementItemID 
                      
