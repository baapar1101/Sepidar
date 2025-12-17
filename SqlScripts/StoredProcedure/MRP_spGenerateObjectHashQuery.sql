IF CAST(SERVERPROPERTY('productversion') AS VARCHAR(20)) >= '14.'
BEGIN
    EXEC SP_EXECUTESQL N'
IF OBJECT_ID(''MRP.spGenerateObjectHashQuery'',''P'') IS NOT NULL
    DROP PROCEDURE [MRP].[spGenerateObjectHashQuery]
'
END
GO
IF CAST(SERVERPROPERTY('productversion') AS VARCHAR(20)) >= '14.'
BEGIN
    EXEC SP_EXECUTESQL N'
CREATE PROCEDURE [MRP].[spGenerateObjectHashQuery]
    @ObjectName VARCHAR(100),
    @FromDate DATE, @ToDate DATE,
    @DateBased BIT,
    -- @GatheringId INT,
    @HashPeriodResulotion CHAR(1) = ''M'', -- هش ها در چه بازه زماني محاسبه شوند
    -- به صورت پيش فرض هش ها ماهانه حساب ميشوند ساير مقادير به صورت زير هستند
    -- ''W'' محاسبه هش به صورت هفتگي
    -- ''M'' محاسبه هش به صورت ماهانه
    -- ''D'' محاسبه هش به صورت روزانه
    -- ''Q'' محاسبه هش به صورت سه ماهه

    @BUILD_HASH_QUERY NVARCHAR(MAX) OUTPUT
AS
BEGIN
    -- DECLARE @GatheringId BIGINT
    -- DECLARE @DateBased BIT
    IF @DateBased = 1
    BEGIN
        SET @BUILD_HASH_QUERY = ''
        SELECT
            ''''''+ @ObjectName+'''''' AS ObjectName, StartDate, EndDate, [Hash]
        FROM
        (
            SELECT
                StartDate = gp.MinDate,
                EndDate = gp.MaxDate,
                [Hash] = HASHBYTES(''''SHA2_256'''', (SELECT [ID], [Version] FROM ''+ @ObjectName +'' WHERE [Date] Between MinDate AND DATEADD(SECOND, -1, DATEADD(DAY, 1, CAST(MaxDate AS DATETIME))) FOR JSON AUTO))
            FROM
            (
                SELECT MinDate = Min(Miladi), MaxDate = Max(Miladi)
                FROM GNR.DimDate dd
                WHERE Miladi BETWEEN '''''' + CAST(@FromDate AS NVARCHAR(25)) + '''''' AND '''''' + CAST(@ToDate AS NVARCHAR(25)) + ''''''
                GROUP BY 
                    DD.MYear * 100 + DD.MMonthN
                '' +
                -- CASE
                --     WHEN @HashPeriodResulotion = ''Q'' THEN ''DD.MYear * 10 + DD.MQuarterN''
                --     WHEN @HashPeriodResulotion = ''W'' THEN ''DD.MYear * 100 + DATEPART(WEEK, DD.Miladi)''
                --     WHEN @HashPeriodResulotion = ''D'' THEN ''DD.MYear * 1000 + DATEPART(DAYOFYEAR, DD.Miladi)''
                --     ELSE ''DD.MYear * 100 + DD.MMonthN''
                -- END + 
                ''
            ) AS gp
        ) AS Q
        WHERE [Hash] IS NOT NULL''
    END
    ELSE
    BEGIN
        SET @BUILD_HASH_QUERY  = ''
        SELECT *
        FROM (
            SELECT
                ObjectName = ''''''+ @ObjectName+'''''',
                StartDate = NULL,
                EndDate = NULL,
                [Hash] = HASHBYTES(''''SHA2_256'''', (SELECT [ID], Version FROM ''+ @ObjectName +'' FOR JSON AUTO))
        ) Q
        WHERE Q.[Hash] IS NOT NULL
        ''
    END    
END
'
END
GO