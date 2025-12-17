If Object_ID('CNT.vwCostStatement') Is Not Null
	Drop View CNT.vwCostStatement
GO
CREATE VIEW CNT.vwCostStatement
AS
SELECT     CS.CostStatementID, CS.ContractRef, CS.WorkshopRef, CS.Number, CS.Date, CS.Type, CS.VoucherType , CS.Description, CS.Description_En, CS.FundResponderDLRef, 
					  C.DLRef AS ContractDLRef, C.DLCode AS ContractDLCode, C.Title AS ContractTitle, C.Title_En AS ContractTitle_En, C.Date AS ContractDate,
					  D.Code AS FundResponderDLCode, D.Title AS FundResponderDLTitle, D.Title_En AS FundResponderDLTitle_En,
                      ACC.DL.Title AS ContractorDLTitle, ACC.DL.Title_En AS ContractorDLTitle_En,
                      W.Title AS WorkshopTitle, W.Title_En AS WorkshopTitle_En, W.Code AS WorkshopCode,
                      CS.VoucherRef, V.Number AS VoucherNumber, V.Date AS VoucherDate,  
                      CSI.TotalPrice, TotalRemain AS Remain,
					  CS.LastModificationDate,CS.LastModifier, CS.CreationDate, CS.Creator, 
                      CS.Version, CS.FiscalYearRef, CS.Established 
FROM
	CNT.CostStatement CS
	INNER JOIN (
			SELECT CostStatementRef, SUM(Price) AS TotalPrice, SUM(Remain) AS TotalRemain
			FROM CNT.vwCostStatementItem CSI
			GROUP BY CostStatementRef) CSI ON CSI.CostStatementRef=CS.CostStatementID
	INNER JOIN CNT.vwContract AS C ON C.ContractID = CS.ContractRef
	INNER JOIN GNR.Party AS P ON C.ContractorPartyRef = P.PartyId
	INNER JOIN ACC.DL ON P.DLRef = ACC.DL.DLId AND P.DLRef = ACC.DL.DLId
	LEFT OUTER JOIN ACC.DL AS D ON CS.FundResponderDLRef = D.DLId
	LEFT OUTER JOIN CNT.Workshop AS W ON CS.WorkshopRef = w.WorkshopID
	LEFT OUTER JOIN ACC.Voucher AS V ON V.VoucherId = CS.VoucherRef