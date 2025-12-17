If Object_ID('CNT.vwCostStatementItem') Is Not Null
	Drop View CNT.vwCostStatementItem
GO
CREATE VIEW CNT.vwCostStatementItem
AS
SELECT     CSI.CostStatementItemID, CSI.CostStatementRef, CSI.RowNumber,
		   CSI.CostTypeRef, CO.Title AS CostTypeTitle, CO.Title_En AS CostTypeTitle_En, CostSLRef, 
		   S.FullCode AS CostSLCode, S.Title AS CostSLTitle, S.Title_En AS CostSLTitle_en,
		   CSI.ItemRef, I.Code AS ItemCode,I.Title AS ItemTitle, I.Title_En AS ItemTitle_En,
		   CSI.Quantity, CSI.Fee, CSI.Price,ISNull(SDI.Total,0) AS TotalSettled, 
		   CASE WHEN CS.[Type] = 1 THEN 0 ELSE (CSI.Price - (ISNull(SDI.Total,0)+ISNull(CSI.InitialSettledValue,0))) END AS Remain,
		   SDI.LastDate AS LastSettlementDate,
		   CSI.Description, CSI.Description_En,
		   CSI.InvoiceNumber, CSI.InvoiceDate,
		   CSI.PartyRef, P.FullName AS PartyFullName, P.DLRef AS PartyDLRef , P.DLCode AS PartyDLCode, P.DLTitle AS PartyDlTitle, P.DLTitle_En AS PartyDlTitle_En,  
		   CSI.SlRef, A.FullCode AS SlCode, A.Title AS SlTitle, A.Title_En AS SlTitle_En,
		   CS.Number AS CostStatementNumber, CS.Date AS CostStatementDate, CS.ContractRef,
		   (SELECT STUFF(e,1,1,'') FROM (
				SELECT ','+CAST(S.Number AS NVARCHAR(MAX))
				FROM CNT.SettlementDebtItem SI INNER JOIN CNT.Settlement S ON SI.SettlementRef=S.SettlementID
				WHERE SI.CostStatementItemRef = CSI.CostStatementItemID FOR XML PATH('')) x(e)) AS SettlementNumbers,
		  CSI.InitialSettledValue
FROM
	CNT.CostStatementItem CSI
	INNER JOIN CNT.CostStatement AS CS ON CSI.CostStatementRef = CS.CostStatementID 
	LEFT JOIN (
		SELECT CostStatementItemRef, SUM(Amount) AS Total, MAX(Date) AS LastDate
		FROM CNT.SettlementDebtItem SI INNER JOIN CNT.Settlement S ON SI.SettlementRef=S.SettlementID
		GROUP BY CostStatementItemRef) SDI ON SDI.CostStatementItemRef=CSI.CostStatementItemID
	LEFT JOIN INV.Item AS I ON CSI.ItemRef = I.ItemID
	LEFT OUTER JOIN GNR.vwParty AS P ON P.PartyId = CSI.partyRef
	LEFT OUTER JOIN ACC.vwAccount AS A ON A.AccountId = CSI.SlRef
	INNER JOIN CNT.vwCost AS CO ON CO.CostID = CSI.CostTypeRef 
	LEFT JOIN ACC.vwAccount S ON CSI.CostSLRef = S.AccountId

