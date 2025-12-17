If Object_ID('ACC.vwVoucherItem') Is Not Null
	Drop View ACC.vwVoucherItem
GO
CREATE VIEW ACC.vwVoucherItem
AS
SELECT     
	VI.VoucherItemId, VI.VoucherRef, VI.RowNumber, VI.AccountSLRef, VI.DLRef, VI.Debit, VI.Credit, VI.CurrencyRef, VI.CurrencyRate, VI.CurrencyDebit, 
	VI.CurrencyCredit, ISNULL(VI.CurrencyDebit, 0) + ISNULL(VI.CurrencyCredit, 0) AS CurrencyAmount, VI.TrackingNumber, VI.TrackingDate, 
	VI.IssuerEntityName, VI.IssuerEntityRef, VI.Description, VI.Description_En, VI.Version, V.Number AS VoucherNumber, 
	V.SecondaryNumber AS VoucherSecondaryNumber, V.ReferenceNumber AS VoucherReferenceNumber, V.DailyNumber AS VoucherDailyNumber, V.Date AS VoucherDate, V.Type AS VoucherType,
	V.State AS VoucherState, AC.CLRef, AC.CLCode, AC.CLTitle,AC.CLTitle_En, AC.GLRef, AC.GLCode, AC.GLTitle,AC.GLTitle_En, 
	AC.FullCode AS SLCode, AC.Title AS SLTitle, AC.Title_En AS SLTitle_En, AC.HasDL AS SLHasDL, 
	AC.HasCurrency AS SLHasCurrency, AC.HasCurrencyConversion AS SLHasCurrencyConversion, AC.HasTracking AS SLHasTracking, 
	AC.HasTrackingCheck AS SLHasTrackingCheck, C.Title AS CurrencyTitle, C.Title_En AS CurrencyTitle_En, C.PrecisionCount AS CurrencyPrecisionCount, 
	DL.Title AS DLTitle, DL.Title_En AS DLTitle_En, DL.Type AS DLType, DL.Code AS DLCode, V.FiscalYearRef,V.IssuerSystem,V.MergedIssuerSystem,V.IsMerged,
	ISNULL(P.IsCustomer,0)IsCustomer, ISNULL(P.IsVendor,0)IsVendor, ISNULL(P.IsBroker,0)IsBroker, ISNULL(P.IsEmployee,0)IsEmployee
FROM ACC.Voucher AS V 
	JOIN ACC.VoucherItem AS VI ON V.VoucherId = VI.VoucherRef 
	JOIN ACC.vwAccount AS AC ON VI.AccountSLRef = AC.AccountId 
	LEFT JOIN ACC.DL AS DL ON VI.DLRef = DL.DLId 
	LEFT JOIN GNR.Party AS P ON P.DLRef = DL.DLId   
	LEFT JOIN GNR.Currency AS C ON VI.CurrencyRef = C.CurrencyID

