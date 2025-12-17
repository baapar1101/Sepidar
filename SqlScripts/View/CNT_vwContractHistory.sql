If Object_ID('CNT.vwContractHistory') Is Not Null
	Drop View CNT.vwContractHistory
GO
CREATE VIEW CNT.vwContractHistory
AS

SELECT        ContractID AS ContractHistoryID, AnnexDate, AnnexDocumentNumber, DocumentNumber AS ContractDocumentNumber, Date AS ContractDate, StartDate, EndDate, AffectedChange, ChangeAmountType,Cost PrimaryFee, 
                         ChangeAmount, ContractID ContractRef, RowNumber, Type, Description, Description_En, C.Title, C.Title_En, C.DlRef,
						 null ChangeFee,Cost FinalFee
FROM            CNT.Contract C
WHERE        (ContractRef IS NULL)


UNION

SELECT        ContractID AS ContractHistoryID, AnnexDate, AnnexDocumentNumber, DocumentNumber AS ContractDocumentNumber, Date AS ContractDate, StartDate, EndDate, AffectedChange, ChangeAmountType, PrimaryFee, 
                         ChangeAmount, ContractRef, RowNumber, Type, Description, Description_En, C.Title, C.Title_En, C.DlRef,
				CASE (ISNULL(C.ChangeAmountType, -1)) 
				WHEN 1 THEN C.PrimaryFee * C.ChangeAmount / 100
				WHEN 2 THEN -1 * C.PrimaryFee * C.ChangeAmount / 100
				WHEN 3 THEN C.ChangeAmount
				WHEN 4 THEN -1 * C.ChangeAmount
				WHEN 5 THEN C.ChangeAmount - C.PrimaryFee
				WHEN -1 THEN 0
				END AS ChangeFee,
			C.PrimaryFee + 
			CASE (ISNULL(C.ChangeAmountType, -1)) 
				WHEN 1 THEN C.PrimaryFee * C.ChangeAmount / 100
				WHEN 2 THEN -1 * C.PrimaryFee * C.ChangeAmount / 100
				WHEN 3 THEN C.ChangeAmount
				WHEN 4 THEN -1 * C.ChangeAmount
				WHEN 5 THEN C.ChangeAmount - C.PrimaryFee
				WHEN -1 THEN 0
				END  AS FinalFee
FROM            CNT.Contract C
WHERE        (ContractRef IS NOT NULL)




