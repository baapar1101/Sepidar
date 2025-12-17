IF OBJECT_ID('RPA.vwPartySettlement') IS NOT NULL
	DROP VIEW RPA.vwPartySettlement
GO
CREATE VIEW RPA.vwPartySettlement
AS
SELECT  PS.PartySettlementID,
		PS.Number,
		PS.[Date],
		PS.[State],
		PS.CurrencyRef,
		C.Title CurrencyTitle,
		C.Title_En CurrencyTitle_En,
		C.PrecisionCount CurrencyPrecisionCount,
		PS.Rate,
		PS.[Description],
		PS.FiscalYearRef,
		PS.PartyRef,
		P.FullName AS PartyFullName,
		P.Name AS PartyName,
		P.LastName AS PartyLastName,
		P.DLCode PartyDLCode,
		P.DLTitle AS PartyDLTitle,
		p.DLRef As PartyDLRef,
		PSI.TotalAmount,
		PS.SettlementByRemainingAmount, 
		PS.SettlementByRemainingAmountInBaseCurrency,
		PS.SettlementByRemainingRate,
		PS.ReceiptHeaderRef,
		Receipt.Number AS ReceiptNumber,
		Receipt.Amount AS ReceiptAmount,
		Receipt.AmountInBaseCurrency ReceiptAmountInBaseCurrency,
		Receipt.Discount ReceiptDiscount,
		Receipt.DiscountInBaseCurrency ReceiptDiscountInBaseCurrency,
		Receipt.TotalAmount AS ReceiptTotalAmount,
		Receipt.TotalAmountInBaseCurrency ReceiptTotalAmountInBaseCurrency,
		Receipt.ChequeAmount ReceiptChequeAmount,
		Receipt.ChequeAmountInBaseCurrency ReceiptChequeAmountInBaseCurrency,
		Receipt.DraftAmount ReceiptDraftAmount,
		Receipt.DraftAmountInBaseCurrency ReceiptDraftAmountInBaseCurrency,
		Receipt.POSAmount ReceiptPOSAmount,
		Receipt.POSAmountInBaseCurrency ReceiptPOSAmountInBaseCurrency,
		Receipt.[Date] AS ReceiptDate,
		CASE WHEN PS.SettlementType = 1 /*Invoice*/ THEN (PSI.TotalAmount - PS.SettlementByRemainingAmount) ELSE 0 END SettlementByReceiptAmount,
		PS.VoucherRef,
		V.Number AS VoucherNumber,
		V.Date AS VoucherDate, 
		PS.CreatorForm,
	    PS.Creator,
	    PS.CreationDate,
	    PS.LastModifier,
	    PS.LastModificationDate,
	    PS.[Version],
		PS.PaymentHeaderRef,
		Payment.Number AS PaymentNumber,
		Payment.Amount AS PaymentAmount,
		Payment.AmountInBaseCurrency PaymentAmountInBaseCurrency,
		Payment.Discount PaymentDiscount,
		Payment.DiscountInBaseCurrency PaymentDiscountInBaseCurrency,
		Payment.TotalAmount AS PaymentTotalAmount,
		Payment.TotalAmountInBaseCurrency PaymentTotalAmountInBaseCurrency,
		Payment.ChequeAmount PaymentChequeAmount,
		Payment.ChequeAmountInBaseCurrency PaymentChequeAmountInBaseCurrency,
		Payment.DraftAmount PaymentDraftAmount,
		Payment.DraftAmountInBaseCurrency PaymentDraftAmountInBaseCurrency,
		Payment.ChequeOtherAmount PaymentChequeOtherAmount,
		Payment.ChequeOtherAmountInBaseCurrency PaymentChequeOtherAmountInBaseCurrency,
		Payment.[Date] AS PaymentDate,
		PS.SettlementType
FROM RPA.PartySettlement PS
		INNER JOIN
			(
				SELECT PartySettlementRef,
					    SUM(Amount) TotalAmount
				FROM RPA.PartySettlementItem
				GROUP BY PartySettlementRef
			) PSI ON PS.PartySettlementID = PSI.PartySettlementRef
		INNER JOIN GNR.vwParty P ON PS.PartyRef = P.PartyId
		INNER JOIN GNR.Currency C ON PS.CurrencyRef = C.CurrencyID
		LEFT  JOIN ACC.Voucher AS V ON PS.VoucherRef = V.VoucherId
		LEFT JOIN 
			(
				SELECT RH.ReceiptHeaderId, RH.Number, RH.Date, RH.Amount, RH.AmountInBaseCurrency,
						RH.Discount, RH.DiscountInBaseCurrency, RH.TotalAmount, RH.TotalAmountInBaseCurrency,
						ISNULL(Cheque.TotalAmount, 0) AS ChequeAmount,
						ISNULL(Cheque.TotalAmountInBaseCurrency, 0) AS ChequeAmountInBaseCurrency,
						ISNULL(Pos.TotalAmount, 0) AS POSAmount,
						ISNULL(Pos.TotalAmountInBaseCurrency, 0) AS POSAmountInBaseCurrency,
						ISNULL(Draft.TotalAmount, 0) AS DraftAmount,
						ISNULL(Draft.TotalAmountInBaseCurrency, 0) AS DraftAmountInBaseCurrency
				From RPA.ReceiptHeader RH
						LEFT JOIN (SELECT RCH.ReceiptHeaderRef, SUM(RCH.Amount) TotalAmount, SUM(RCH.AmountInBaseCurrency) TotalAmountInBaseCurrency
								   FROM RPA.ReceiptCheque RCH
								   GROUP BY RCH.ReceiptHeaderRef) Cheque ON RH.ReceiptHeaderId = Cheque.ReceiptHeaderRef
						LEFT JOIN (SELECT RP.ReceiptHeaderRef, SUM(RP.Amount) TotalAmount, SUM(RP.AmountInBaseCurrency) TotalAmountInBaseCurrency
								   FROM RPA.ReceiptPos RP
								   GROUP BY RP.ReceiptHeaderRef) Pos ON RH.ReceiptHeaderId = Pos.ReceiptHeaderRef
						LEFT JOIN (SELECT RD.ReceiptHeaderRef, SUM(RD.Amount) TotalAmount, SUM(RD.AmountInBaseCurrency) TotalAmountInBaseCurrency
								   FROM RPA.ReceiptDraft RD
								   GROUP BY RD.ReceiptHeaderRef) Draft ON RH.ReceiptHeaderId = Draft.ReceiptHeaderRef
				GROUP BY RH.ReceiptHeaderId, RH.Number, RH.Date, RH.Amount, RH.AmountInBaseCurrency,
						  RH.Discount, RH.DiscountInBaseCurrency, RH.TotalAmount, RH.TotalAmountInBaseCurrency, Cheque.TotalAmount,
						  Cheque.TotalAmountInBaseCurrency, Pos.TotalAmount, Pos.TotalAmountInBaseCurrency, Draft.TotalAmount, 
						  Draft.TotalAmountInBaseCurrency
			 ) Receipt ON PS.ReceiptHeaderRef = Receipt.ReceiptHeaderId 
		LEFT JOIN 
			(
				SELECT PH.PaymentHeaderId, PH.Number, PH.Date, PH.Amount, PH.AmountInBaseCurrency,
						PH.Discount, PH.DiscountInBaseCurrency, PH.TotalAmount, PH.TotalAmountInBaseCurrency,
						ISNULL(Cheque.TotalAmount, 0) AS ChequeAmount,
						ISNULL(Cheque.TotalAmountInBaseCurrency, 0) AS ChequeAmountInBaseCurrency,
						ISNULL(ChequeOther.TotalAmount, 0) AS ChequeOtherAmount,
						ISNULL(ChequeOther.TotalAmountInBaseCurrency, 0) AS ChequeOtherAmountInBaseCurrency,
						ISNULL(Draft.TotalAmount, 0) AS DraftAmount,
						ISNULL(Draft.TotalAmountInBaseCurrency, 0) AS DraftAmountInBaseCurrency
				From RPA.PaymentHeader PH
						LEFT JOIN(SELECT PCH.PaymentHeaderRef, SUM(PCH.Amount) TotalAmount, SUM(PCH.AmountInBaseCurrency) TotalAmountInBaseCurrency
								  FROM RPA.PaymentCheque  PCH
								  GROUP BY PCH.PaymentHeaderRef) Cheque ON PH.PaymentHeaderId = Cheque.PaymentHeaderRef
						LEFT JOIN (SELECT PCO.PaymentHeaderRef, SUM(PCO.Amount) TotalAmount, SUM(PCO.AmountInBaseCurrency) TotalAmountInBaseCurrency
								   FROM RPA.vwPaymentChequeOther PCO
								   GROUP BY PCO.PaymentHeaderRef)ChequeOther ON PH.PaymentHeaderId = ChequeOther.PaymentHeaderRef
						LEFT JOIN (SELECT PD.PaymentHeaderRef, SUM(PD.Amount) TotalAmount, SUM(PD.AmountInBaseCurrency) TotalAmountInBaseCurrency
								   FROM RPA.PaymentDraft PD
								   GROUP BY PD.PaymentHeaderRef)Draft ON PH.PaymentHeaderId = Draft.PaymentHeaderRef
				GROUP BY PH.PaymentHeaderId, PH.Number, PH.Date, PH.Amount, PH.AmountInBaseCurrency,
						  PH.Discount, PH.DiscountInBaseCurrency, PH.TotalAmount, PH.TotalAmountInBaseCurrency, Cheque.TotalAmount,
						  Cheque.TotalAmountInBaseCurrency, ChequeOther.TotalAmount, ChequeOther.TotalAmountInBaseCurrency, 
						  Draft.TotalAmount, Draft.TotalAmountInBaseCurrency
			 ) Payment ON PS.PaymentHeaderRef = Payment.PaymentHeaderId 
