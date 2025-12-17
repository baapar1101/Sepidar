IF OBJECT_ID('MRP.vwPartyOpeningBalanceVersion', 'V') IS NOT NULL
    DROP VIEW MRP.vwPartyOpeningBalanceVersion
GO

CREATE VIEW MRP.vwPartyOpeningBalanceVersion
AS
    SELECT PartyOpeningBalanceId AS [ID], P.[Version], FY.StartDate AS [Date]
    FROM GNR.PartyOpeningBalance POB
    INNER JOIN GNR.Party P ON POB.PartyRef = P.PartyID
    INNER JOIN FMK.FiscalYear FY ON POB.FiscalYearRef = FY.FiscalYearId
GO
