If Object_ID('RPA.vwReceiptHeader') Is Not Null
	Drop View RPA.vwReceiptHeader
GO
CREATE VIEW RPA.vwReceiptHeader
AS
SELECT     ReceiptHeader.ReceiptHeaderId, ReceiptHeader.Type, ReceiptHeader.DlRef, ReceiptHeader.Number, ReceiptHeader.Date, 
           ReceiptHeader.[Guid], ReceiptHeader.CurrencyRef, ReceiptHeader.Description, ReceiptHeader.Description_En, 
		   ReceiptHeader.Creator, UC.Name AS CreatorName, UC.Name_En AS CreatorName_En, ReceiptHeader.CreationDate, 
           ReceiptHeader.LastModifier, ULM.Name AS LastModifierName, ULM.Name_En AS LastModifierName_En, ReceiptHeader.LastModificationDate, 
		   ReceiptHeader.Version, ReceiptHeader.Discount, ReceiptHeader.ReceiptAmount, 
           ReceiptHeader.TotalAmount, ReceiptHeader.ItemType, Currency.Title AS CurrencyTitle, ReceiptHeader.State, ReceiptHeader.CreatorForm, 
           ACC.DL.Title AS DlTitle, ACC.DL.Title_En AS DlTitle_En, ACC.DL.Code AS DlCode, ReceiptHeader.Rate, ReceiptHeader.CashRef, ReceiptHeader.Amount, 
           Cash.DlTitle AS CashTitle, Cash.DlTitle_En AS CashTitle_En, ReceiptHeader.AmountInBaseCurrency, Account.FullCode AS AccountCode, 
           Account.Title AS AccountTitle, Account.Title_En AS AccountTitle_En, ReceiptHeader.AccountSlRef, ReceiptHeader.FiscalYearRef, 
           ReceiptHeader.VoucherRef, ACC.Voucher.Number AS VoucherNumber, ACC.Voucher.Date AS VoucherDate, ReceiptHeader.TotalAmountInBaseCurrency,
		   ReceiptHeader.DiscountRate, ReceiptHeader.DiscountInBaseCurrency, Currency.Title_En AS CurrencyTitle_En, Cash.DlCode AS CashDlCode,
		   ReceiptHeader.AmountInBaseCurrency + ReceiptHeader.DiscountInBaseCurrency AS ReceiptAmountInBaseCurrency,
		   CASE ReceiptHeader.State WHEN 4 THEN 1 ELSE 0 END IsInitial,CASE ReceiptHeader.CreatorForm WHEN 4 THEN 1 WHEN 5 THEN 1 WHEN 6 THEN 1 WHEN 7 THEN 1 ELSE 0 END IsTransfer,
		   CASE  WHEN 
					EXISTS (SELECT 1 
							FROM RPA.PartyAccountSettlementItem 
							WHERE CreditEntityType = 23 /*Receipt*/ AND  ReceiptHeader.ReceiptHeaderId = CreditEntityRef) THEN 1 
				ELSE 0 END RelatedToPartySettlement
FROM         
		RPA.ReceiptHeader AS ReceiptHeader INNER JOIN
		GNR.Currency AS Currency ON ReceiptHeader.CurrencyRef = Currency.CurrencyID INNER JOIN
		ACC.DL ON ReceiptHeader.DlRef = ACC.DL.DLId LEFT OUTER JOIN
		FMK.[User] AS UC ON ReceiptHeader.Creator = UC.UserID LEFT OUTER JOIN
		FMK.[User] AS ULM ON ReceiptHeader.LastModifier = ULM.UserID LEFT OUTER JOIN
		ACC.Voucher ON ReceiptHeader.VoucherRef = ACC.Voucher.VoucherId LEFT OUTER JOIN
		ACC.vwAccount AS Account ON ReceiptHeader.AccountSlRef = Account.AccountId LEFT OUTER JOIN
		RPA.vwCash Cash ON ReceiptHeader.CashRef = Cash.CashId

