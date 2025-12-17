IF EXISTS (SELECT * FROM sys.columns WHERE object_id=object_id('CNT.Status') AND [name]='SLDebitCreditRef')
AND NOT EXISTS (SELECT TOP 1 SLDebitCreditRef FROM CNT.Status WHERE SLDebitCreditRef != NULL)
BEGIN

UPDATE S
SET S.SLDebitCreditRef = 
				 
			CASE 
				WHEN S.VoucherRef IS null AND S.Nature =  1 /*Contracting*/ THEN (SELECT TOP 1 Value FROM FMK.Configuration where [key] = 'ContractStatusReceivableSL' AND Value!='')
				WHEN S.VoucherRef IS null AND S.Nature =  2 /*Ownership*/ THEN (SELECT TOP 1 Value FROM FMK.Configuration where [key] = 'ContractStatusPayableSL' AND Value!='' )
				WHEN S.Nature = 1 /*Contracting*/ AND S.StatusRefType = 3 /*DecrementalModified*/ THEN
					(SELECT Top 1 AccountSLRef from ACC.VoucherItem WHERE VoucherRef = S.VoucherRef AND Credit = VS.Remained AND Debit = 0 AND (DLRef = VS.ContractorDlRef or (DLRef is null )))
				WHEN S.Nature = 1 /*Contracting*/ AND S.StatusRefType IN(1, 2) /*Ordinary, IncrementalModified*/ THEN
					(SELECT Top 1 AccountSLRef from ACC.VoucherItem WHERE VoucherRef = S.VoucherRef AND Credit = 0 AND Debit = VS.Remained AND (DLRef = VS.ContractorDlRef or (DLRef is null )))
				WHEN S.Nature = 2 /*Ownership*/ AND S.StatusRefType = 3 /*DecrementalModified*/ THEN
					(SELECT Top 1 AccountSLRef from ACC.VoucherItem WHERE VoucherRef = S.VoucherRef AND Credit = 0 AND Debit = VS.Remained AND (DLRef = VS.ContractorDlRef or (DLRef is null )))
				WHEN S.Nature = 2 /*Ownership*/ AND S.StatusRefType IN(1, 2) /*Ordinary, IncrementalModified*/ THEN
					(SELECT Top 1 AccountSLRef from ACC.VoucherItem WHERE VoucherRef = S.VoucherRef AND Credit = VS.Remained AND Debit = 0 AND (DLRef = VS.ContractorDlRef or (DLRef is null )))
				ELSE NULL
			END 
from CNT.[Status] S
	INNER JOIN CNT.vwStatus AS VS ON S.StatusID = VS.StatusID

END