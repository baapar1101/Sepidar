If Object_ID('SLS.UpdateGeneralBaseCurrencyAmount') Is Not Null
	Drop Procedure SLS.UpdateGeneralBaseCurrencyAmount
GO
CREATE PROCEDURE SLS.UpdateGeneralBaseCurrencyAmount
AS
BEGIN
	UPDATE GNR.DebitCreditNoteItem SET AmountInBaseCurrency = [GNR].[fnCalcAmountInBaseCurrency](Amount, Rate)
	UPDATE GNR.DebitCreditNote SET SumAmountInBaseCurrency  = (Select sum(AmountInBaseCurrency) from GNR.DebitCreditNoteItem where DebitCreditNoteRef = DebitCreditNoteId)
END