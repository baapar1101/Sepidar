IF CAST(SERVERPROPERTY('productversion') AS VARCHAR(20)) >= '14.'
BEGIN
    EXEC SP_EXECUTESQL N'
IF OBJECT_ID(''MRP.spGetRangeStartEnd'', ''P'') IS NOT NULL
    DROP PROCEDURE MRP.spGetRangeStartEnd
'
END
GO

IF CAST(SERVERPROPERTY('productversion') AS VARCHAR(20)) >= '14.'
BEGIN
    EXEC SP_EXECUTESQL N'
CREATE PROCEDURE MRP.spGetRangeStartEnd
    @FromDate DATE,
    @ToDate DATE,
    @HashPeriodResulotion CHAR,
    @RangeFromDate DATE OUTPUT,
    @RangeToDate DATE OUTPUT
AS
BEGIN
    SELECT @RangeFromDate = MAX([Date])
    FROM (
        SELECT TOP 1 RD.Miladi AS [Date]
        FROM GNR.DimDate RD
        JOIN GNR.DimDate FD ON FD.Miladi = @FromDate AND
        CASE
            WHEN @HashPeriodResulotion = ''Q'' THEN RD.MYear * 10 + RD.MQuarterN
            WHEN @HashPeriodResulotion = ''W'' THEN RD.MYear * 100 + DATEPART(WEEK, RD.Miladi)
            WHEN @HashPeriodResulotion = ''D'' THEN RD.MYear * 1000 + DATEPART(DAYOFYEAR, RD.Miladi)
            ELSE RD.MYear * 100 + RD.MMonthN
        END = CASE
            WHEN @HashPeriodResulotion = ''Q'' THEN FD.MYear * 10 + FD.MQuarterN
            WHEN @HashPeriodResulotion = ''W'' THEN FD.MYear * 100 + DATEPART(WEEK, FD.Miladi)
            WHEN @HashPeriodResulotion = ''D'' THEN FD.MYear * 1000 + DATEPART(DAYOFYEAR, FD.Miladi)
            ELSE FD.MYear * 100 + FD.MMonthN
        END
        ORDER BY RD.Miladi ASC
        UNION ALL
        -- TODO: may cause problems when comparing with previous fiscal years
        SELECT StartDate FROM FMK.FiscalYear WHERE @FromDate BETWEEN StartDate AND EndDate
    ) DATES
    
    SELECT @RangeToDate = MIN([Date])
    FROM (
        SELECT TOP 1 RD.Miladi AS [Date]
        FROM GNR.DimDate RD
        JOIN GNR.DimDate TD ON TD.Miladi = @ToDate AND
        CASE
            WHEN @HashPeriodResulotion = ''Q'' THEN RD.MYear * 10 + RD.MQuarterN
            WHEN @HashPeriodResulotion = ''W'' THEN RD.MYear * 100 + DATEPART(WEEK, RD.Miladi)
            WHEN @HashPeriodResulotion = ''D'' THEN RD.MYear * 1000 + DATEPART(DAYOFYEAR, RD.Miladi)
            ELSE RD.MYear * 100 + RD.MMonthN
        END = CASE
            WHEN @HashPeriodResulotion = ''Q'' THEN TD.MYear * 10 + TD.MQuarterN
            WHEN @HashPeriodResulotion = ''W'' THEN TD.MYear * 100 + DATEPART(WEEK, TD.Miladi)
            WHEN @HashPeriodResulotion = ''D'' THEN TD.MYear * 1000 + DATEPART(DAYOFYEAR, TD.Miladi)
            ELSE TD.MYear * 100 + TD.MMonthN
        END
        ORDER BY RD.Miladi DESC
        UNION ALL
        -- TODO: may cause problems when comparing with previous fiscal years
        SELECT EndDate FROM FMK.FiscalYear WHERE @ToDate BETWEEN StartDate AND EndDate
    ) DATES

END
'
END
GO