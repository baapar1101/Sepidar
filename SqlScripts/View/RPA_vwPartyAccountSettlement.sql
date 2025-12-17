IF OBJECT_ID('RPA.vwPartyAccountSettlement') IS NOT NULL
	DROP VIEW RPA.vwPartyAccountSettlement
GO
CREATE VIEW RPA.vwPartyAccountSettlement
AS
SELECT  PS.PartyAccountSettlementID,
		PS.Number,
		PS.[Date],
		PS.[State],
		PS.CurrencyRef,
		C.Title CurrencyTitle,
		C.Title_En CurrencyTitle_En,
		C.PrecisionCount CurrencyPrecisionCount,
		PS.Rate,
		PS.[Description],
		PS.[Description_En],		
		PS.FiscalYearRef,
		PS.PartyRef,
		P.FullName AS PartyFullName,
		P.Name AS PartyName,
		P.LastName AS PartyLastName,
		P.DLCode PartyDLCode,
		P.DLTitle AS PartyDLTitle,
		p.DLRef As PartyDLRef,
		PSI.TotalAmount,		
		PS.VoucherRef,
		V.Number AS VoucherNumber,
		V.Date AS VoucherDate, 
		PS.CreatorForm,
	    PS.Creator,
	    PS.CreationDate,
	    PS.LastModifier,
	    PS.LastModificationDate,
	    PS.[Version],			
		PS.PartyAccountSettlementType
FROM RPA.PartyAccountSettlement PS
		INNER JOIN
			(
				SELECT PartyAccountSettlementRef,
					    SUM(Amount)/2 TotalAmount
				FROM RPA.PartyAccountSettlementItem
				GROUP BY PartyAccountSettlementRef
			) PSI ON PS.PartyAccountSettlementID = PSI.PartyAccountSettlementRef
		INNER JOIN GNR.vwParty P ON PS.PartyRef = P.PartyId
		INNER JOIN GNR.Currency C ON PS.CurrencyRef = C.CurrencyID
		LEFT  JOIN ACC.Voucher AS V ON PS.VoucherRef = V.VoucherId
		