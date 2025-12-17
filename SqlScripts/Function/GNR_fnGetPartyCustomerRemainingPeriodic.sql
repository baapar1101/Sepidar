IF OBJECT_ID('GNR.fnGetPartyCustomerRemainingPeriodic') IS NOT NULL
	DROP FUNCTION [GNR].[fnGetPartyCustomerRemainingPeriodic]
GO

CREATE FUNCTION [GNR].[fnGetPartyCustomerRemainingPeriodic] (@PeriodType INT, @Calendar INT = 0, @PartyDLRef INT = -1, @ContainsCheque INT = 1, @FiscalYearRef INT, @FromDate DATE = NULL, @ToDate DATE = NULL)
RETURNS TABLE

RETURN

--DECLARE @PeriodType INT = 1, @Calendar INT = 2, @PartyDLRef INT = -1, @ContainsCheque INT = 1, @FiscalYearRef INT = 2, @FromDate DATE = NULL, @ToDate DATE = NULL

SELECT
     Year = CASE WHEN @Calendar = 1 THEN DD.JYear ELSE DD.MYear END
    ,Period = CASE
                 WHEN @PeriodType = 2 THEN
                     CASE WHEN @Calendar = 1 THEN DD.JQuarterN ELSE DD.MQuarterN END
                 WHEN @PeriodType = 3 THEN
                     CASE WHEN @Calendar = 1 THEN DD.JMonthN ELSE DD.MMonthN END
             END
    ,DebitTransaction = SUM(CASE WHEN CreditDebit = 1 THEN AmountInBaseCurrency ELSE 0 END)
    ,CreditTransaction = SUM(CASE WHEN CreditDebit = -1 THEN AmountInBaseCurrency ELSE 0 END)
    ,Remaining = SUM(CreditDebit * AmountInBaseCurrency)
FROM GNR.fnGetPartyCustomerTransactions (@PartyDLRef, @ContainsCheque, @FiscalYearRef, @FromDate, @ToDate) AS Trans
LEFT JOIN GNR.DimDate DD ON DD.Miladi = CAST(Trans.Date AS DATE)
GROUP BY
    CASE WHEN @Calendar = 1 THEN DD.JYear ELSE DD.MYear END,
    CASE
        WHEN @PeriodType = 2 THEN
            CASE WHEN @Calendar = 1 THEN DD.JQuarterN ELSE DD.MQuarterN END
        WHEN @PeriodType = 3 THEN
            CASE WHEN @Calendar = 1 THEN DD.JMonthN ELSE DD.MMonthN END
    END
