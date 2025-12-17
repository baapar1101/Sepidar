IF EXISTS (
		SELECT OBJECT_ID FROM sys.objects O WHERE   O.name LIKE 'vwRepair' 
												  AND O.schema_id = (
																	SELECT schema_id FROM sys.schemas sch WHERE sch.name LIKE 'AST'))
DROP VIEW AST.vwRepair
GO

CREATE VIEW AST.vwRepair
AS(
	SELECT  
		 R.[RepairId]
		,R.[Number]
		,R.[Date]
		,R.[DlRef]
		,R.[VoucherRef]
		,DL.[Title] AS DlTitle 
		,DL.[Title_En] AS DlTitle_En
		,DL.[Code] As DlCode
		,R.[AccountSlRef]
		,A.[FullCode] As AccountFullCode
		,A.[Title] As AccountTitle
		,A.[Title_En] As AccountTitle_En
		,R.[Description] 
		,R.[Description_En]
		,R.[FiscalYearRef]
		,R.[Version]
		,R.[Creator]
		,R.[CreationDate]
		,R.[LastModifier]
		,R.[LastModificationDate] 
		,v.Number AS VoucherNumber
		,v.[Date] AS VoucherDate
		,CASE
			WHEN r.VoucherRef IS NULL THEN 0 ELSE 1
		END AS HasVoucher
		,u.Name AS CreatorName
		,u.Name_En AS CreatorName_En
		
	FROM  AST.Repair R 
		 LEFT JOIN ACC.DL DL on DL.DLId = R.DLRef
		 LEFT JOIN Acc.vwAccount A on A.AccountId = R.AccountSlRef
		 LEFT JOIN ACC.Voucher v ON v.VoucherId = r.VoucherRef
		 LEFT JOIN FMK.[User] u ON u.UserID = R.Creator
  )