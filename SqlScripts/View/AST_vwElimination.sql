if exists(select 1 from sys.views where name='vwElimination' and type='v')
BEGIN
DROP VIEW [AST].vwElimination	
END


GO

CREATE VIEW [AST].vwElimination
As
SELECT  s.EliminationID
		,s.Number
		,s.[Date]
		,s.VoucherRef		
		,a.Title AS LossSLTitle
		,a.Title_En AS LossSLTitle_En
		,s.FiscalYearRef
		,fy.Title AS FiscalYearTitle
		,s.LossSLRef
		,a.FullCode AS SLAccountCode
		,v.Number AS VoucherNumber
		,v.[Date] AS VoucherDate
		,CASE
			WHEN	s.VoucherRef IS NOT NULL THEN 1 ELSE 0		
		END AS HasVoucher
		,s.[Description]
		,s.[Description_En]
		,s.[Version]
		,s.Creator
		,s.CreationDate
		,s.LastModifier
		,s.LastModificationDate
		,u.Name AS CreatorName
		,u.Name_En AS CreatorName_En
		 FROM AST.Elimination s
		 LEFT JOIN fmk.FiscalYear fy ON fy.FiscalYearId = s.FiscalYearRef
		 LEFT JOIN acc.vwAccount a ON a.AccountId = s.LossSLRef
		 LEFT JOIN acc.Voucher v ON v.VoucherId = s.VoucherRef
		 LEFT JOIN FMK.[User] u ON u.UserID = s.Creator