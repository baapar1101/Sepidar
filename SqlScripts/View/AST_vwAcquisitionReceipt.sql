IF EXISTS (
		SELECT OBJECT_ID FROM sys.objects O WHERE   O.name LIKE 'vwAcquisitionReceipt' 
												  AND O.schema_id = (
																	SELECT schema_id FROM sys.schemas sch WHERE sch.name LIKE 'AST'))
DROP VIEW AST.vwAcquisitionReceipt
GO

CREATE VIEW AST.vwAcquisitionReceipt
AS(
	SELECT  AR.[AcquisitionReceiptID]
		   ,AR.[Number]
		   ,AR.[Date] 
		   ,AR.[CurrencyRef]
		   ,C.Title AS CurrencyTitle
		   ,C.Title_En AS CurrencyTitle_En
		   ,AR.[CurrencyRate]
		   ,AR.[Type] 
		   ,AR.[Description]
		   ,AR.[Description_En]
		   
		   ,AR.[AccountingDLRef]
		   ,DL.Title AS DLTitle
		   ,DL.Title_En AS DLTitle_En
		   ,DL.Code AS DLFullCode
		   
		   ,AR.[AccountingSLRef]
		   ,A.FullCode AS SLFullCode
		   ,A.Title AS SLTitle
		   ,A.Title_En AS SLTitle_En
		   
		   ,AR.[FiscalYearRef]
		   ,AR.[VoucherRef]
		   ,V.Number AS VoucherNumber
		   ,V.[Date] AS VoucherDate
		   , CASE 
					WHEN AR.VoucherRef IS NULL THEN 0 ELSE 1
		   END  AS HasVoucher
		   ,AR.[Version]
		   ,AR.[Creator]
		   ,AR.[CreationDate]
		   ,AR.[LastModifier]
		   ,AR.[LastModificationDate]
		   
		   ,u.Name AS CreatorName
		   ,u.Name_En AS CreatorName_En
		   
	FROM AST.AcquisitionReceipt AR
		LEFT JOIN ACC.DL AS DL
			ON AR.AccountingDLRef = DL.DLId
		LEFT JOIN ACC.vwAccount AS A 
			ON AR.AccountingSLRef = A.AccountId
		LEFT OUTER JOIN GNR.Currency AS C 
			ON AR.CurrencyRef = C.CurrencyID
		LEFT OUTER JOIN ACC.Voucher AS V 
			ON AR.VoucherRef = V.VoucherId
		LEFT JOIN FMK.[User] u ON u.UserID = AR.Creator
  )