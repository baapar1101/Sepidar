IF Object_ID('RPA.vwPartySettlementItem') IS NOT NULL
	Drop View RPA.vwPartySettlementItem
GO
Create View RPA.vwPartySettlementItem
AS
SELECT PSI.PartySettlementItemID, PSI.PartySettlementRef, PSI.InvoiceRef,
	PSI.CurrencyRef, C.Title CurrencyTitle, C.Title_En CurrencyTitle_En, PSI.Rate,
	I.Number AS InvoiceNumber, PSI.Amount, PSI.AmountInBaseCurrency,
	PSI.RemainingAmount, I.Date AS InvoiceDate, I.NetPrice AS InvoiceNetPrice,
	I.NetPrice AS InvoiceNetPriceInBaseCurrency, PSI.CommissionCalculationRef,
	CC.ToDate CommissionCalculationToDate, CC.Amount CommissionCalculationAmount, CC.CommissionTitle CommissionCalculationTitle 
FROM RPA.PartySettlementItem AS PSI
	INNER JOIN GNR.Currency C ON PSI.CurrencyRef = C.CurrencyID
	LEFT JOIN SLS.Invoice I ON PSI.InvoiceRef = I.InvoiceID
	LEFT JOIN SLS.vwCommissionCalculation CC ON CC.CommissionCalculationID = PSI.CommissionCalculationRef
	
	

