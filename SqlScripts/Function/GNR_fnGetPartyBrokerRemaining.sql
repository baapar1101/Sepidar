IF OBJECT_ID('GNR.fnGetPartyBrokerRemaining') IS NOT NULL
	DROP FUNCTION [GNR].[fnGetPartyBrokerRemaining]
GO

CREATE FUNCTION [GNR].[fnGetPartyBrokerRemaining] (@PartyDLRef INT = -1, @ContainsCheque INT = 1, @FiscalYearRef INT, @FromDate DATE = NULL, @ToDate DATE = NULL)
RETURNS TABLE

RETURN

--DECLARE @PartyDLRef INT = -1, @ContainsCheque INT = 1, @FiscalYearRef INT = 2, @FromDate DATE = NULL, @ToDate DATE = NULL

SELECT
    Trans.PartyDLRef
    ,DebitTransaction = SUM(CASE WHEN CreditDebit = 1 THEN AmountInBaseCurrency ELSE 0 END)
    ,CreditTransaction = SUM(CASE WHEN CreditDebit = -1 THEN AmountInBaseCurrency ELSE 0 END)
    ,Remaining = SUM(CreditDebit * AmountInBaseCurrency)
FROM GNR.fnGetPartyBrokerTransactions (@PartyDLRef, @ContainsCheque, @FiscalYearRef, @FromDate, @ToDate) AS Trans
GROUP BY Trans.PartyDLRef
