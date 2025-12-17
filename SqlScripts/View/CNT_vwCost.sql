If Object_ID('CNT.vwCost') Is Not Null
	Drop View CNT.vwCost
GO
CREATE VIEW [CNT].[vwCost]
AS
SELECT C.CostID, C.Title, C.Title_En, C.Number,
	   C.SLRef, S.FullCode AS SLCode, S.Title AS SLTitle, S.Title_En AS SLTitle_En, S.FullCode AS SLFullCode,
	   C.Version, c.Creator, C.CreationDate, C.	LastModifier, C.LastModificationDate
FROM
CNT.Cost  C LEFT JOIN
ACC.vwAccount S ON C.SLRef = S.AccountId

