IF CAST(SERVERPROPERTY('productversion') AS VARCHAR(20)) >= '14.'
BEGIN
    EXEC SP_EXECUTESQL N'
IF OBJECT_ID(''MRP.fnGetPeriods'') IS NOT NULL
    DROP FUNCTION MRP.fnGetPeriods
'
END
GO

IF CAST(SERVERPROPERTY('productversion') AS VARCHAR(20)) >= '14.'
BEGIN
    EXEC SP_EXECUTESQL N'
CREATE FUNCTION MRP.fnGetPeriods(@FromDate DATE, @ToDate DATE, @IsPersianCalendar INT, @PeriodType INT)
    RETURNS TABLE
AS
RETURN
    SELECT CAST(MIN(DD.Miladi) AS DATETIME) AS StartDate, DATEADD(SECOND, -1, DATEADD(DAY, 1, CAST(MAX(DD.Miladi) AS DATETIME))) AS EndDate,
        CASE
            WHEN @IsPersianCalendar = 1 THEN
                CASE
                    WHEN @PeriodType = 1 THEN MIN(RIGHT(DD.Jalali_1, 5))
                    WHEN @PeriodType = 2 THEN ''هفته '' + FORMAT(MIN(DD.JWeekN), ''00'')
                    WHEN @PeriodType = 3 THEN ''ماه '' + FORMAT(MIN(DD.JMonthN), ''00'')
                    WHEN @PeriodType = 4 THEN ''سه ماهه '' + CAST(MIN(DD.JQuarterN) AS VARCHAR(10))
                    WHEN @PeriodType = 5 THEN ''سال '' + CAST(MIN(DD.JYear) AS VARCHAR(10))
                    ELSE NULL
                END
            ELSE
                CASE
                    WHEN @PeriodType = 1 THEN FORMAT(MIN(DD.Miladi), ''MM/dd'')
                    WHEN @PeriodType = 2 THEN ''Week '' + FORMAT(MIN(DD.MWeekN), ''00'')
                    WHEN @PeriodType = 3 THEN ''Month '' + FORMAT(MIN(DD.MMonthN), ''00'')
                    WHEN @PeriodType = 4 THEN ''Quarter '' + CAST(MIN(DD.MQuarterN) AS VARCHAR(10))
                    WHEN @PeriodType = 5 THEN ''Year '' + CAST(MIN(DD.MYear) AS VARCHAR(10))
                    ELSE NULL
                END
        END AS [Period]
    FROM GNR.DimDate DD
    WHERE Miladi BETWEEN @FromDate AND @ToDate
    GROUP BY
    CASE
        WHEN @IsPersianCalendar = 1 THEN
            CASE
                WHEN @PeriodType = 1 THEN CAST(CAST(DD.Miladi AS DATETIME) AS FLOAT)
                WHEN @PeriodType = 2 THEN DD.JYear * 100 + DD.JWeekN
                WHEN @PeriodType = 3 THEN DD.JYear * 100 + DD.JMonthN
                WHEN @PeriodType = 4 THEN DD.JYear * 10 + DD.JQuarterN
                WHEN @PeriodType = 5 THEN DD.JYear
            END
        ELSE
            CASE
                WHEN @PeriodType = 1 THEN CAST(CAST(DD.Miladi AS DATETIME) AS FLOAT)
                WHEN @PeriodType = 2 THEN DD.MYear * 100 + DD.MWeekN
                WHEN @PeriodType = 3 THEN DD.MYear * 100 + DD.MMonthN
                WHEN @PeriodType = 4 THEN DD.MYear * 10 + DD.MQuarterN
                WHEN @PeriodType = 5 THEN DD.MYear
            END
        END
'
END
GO