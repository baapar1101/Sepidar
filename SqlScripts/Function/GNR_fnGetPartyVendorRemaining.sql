IF OBJECT_ID('GNR.fnGetPartyVendorRemaining') IS NOT NULL
	DROP FUNCTION [GNR].[fnGetPartyVendorRemaining]
GO

CREATE FUNCTION [GNR].[fnGetPartyVendorRemaining] (@PartyDLRef INT = -1, @ContainsCheque INT = 1, @FiscalYearRef INT, @FromDate DATE = NULL, @ToDate DATE = NULL)
RETURNS TABLE

RETURN

--DECLARE @PartyDLRef INT = -1, @ContainsCheque INT = 1, @FiscalYearRef INT = 2, @FromDate DATE = NULL, @ToDate DATE = NULL

SELECT
    Trans.PartyDLRef
    ,DebitTransaction = SUM(CASE WHEN CreditDebit = 1 THEN AmountInBaseCurrency ELSE 0 END)
    ,CreditTransaction = SUM(CASE WHEN CreditDebit = -1 THEN AmountInBaseCurrency ELSE 0 END)
    ,Remaining = SUM(CreditDebit * AmountInBaseCurrency)
FROM GNR.fnGetPartyVendorTransactions (@PartyDLRef, @ContainsCheque, @FiscalYearRef, @FromDate, @ToDate) AS Trans
GROUP BY Trans.PartyDLRef
