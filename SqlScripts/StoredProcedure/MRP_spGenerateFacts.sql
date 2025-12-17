IF CAST(SERVERPROPERTY('productversion') AS VARCHAR(20)) >= '14.'
BEGIN
    EXEC SP_EXECUTESQL N'
IF OBJECT_ID(''MRP.spGenerateFacts'', ''P'') IS NOT NULL
    DROP PROCEDURE MRP.spGenerateFacts
'
END
GO

IF CAST(SERVERPROPERTY('productversion') AS VARCHAR(20)) >= '14.'
BEGIN
    EXEC SP_EXECUTESQL N'
CREATE PROCEDURE MRP.spGenerateFacts
    @FromDate DATETIME,
    @ToDate DATETIME,
    @FactsTable VARCHAR(100),
    @GeneratorSP VARCHAR(100)
AS
BEGIN
    DECLARE @HashPeriodResulotion CHAR = ''M'';
    DECLARE @GatheringId INT = ISNULL((SELECT MAX(GatheringId) FROM MRP.ObjectHash WHERE ObjectName = @FactsTable), 0) + 1;
    DECLARE @Query NVARCHAR(500);
    EXEC MRP.spGetRangeStartEnd @FromDate, @ToDate, @HashPeriodResulotion, @FromDate OUTPUT, @ToDate OUTPUT

    EXEC MRP.spGatherHash @FactsTable, @GatheringId, @FromDate, @ToDate, ''M'';

    -- DELETE OUTDATED DATA
    DECLARE @IsDataInvalid BIT = 0;
    IF EXISTS (
        SELECT [Hash] FROM MRP.ObjectHash
        WHERE ObjectName = @FactsTable AND GatheringId = @GatheringId AND StartDate IS NULL AND EndDate IS NULL
        
        EXCEPT
        
        SELECT [Hash] FROM MRP.ObjectHash
        WHERE ObjectName = @FactsTable AND GatheringId <> @GatheringId AND StartDate IS NULL AND EndDate IS NULL
    )
    BEGIN
        SET @IsDataInvalid = 1;
    END

    DECLARE @StartDate DATE, @EndDate DATE;
    IF OBJECT_ID(@FactsTable, ''U'') IS NOT NULL
    BEGIN
        IF @IsDataInvalid = 1
        BEGIN
            SET @Query = ''TRUNCATE TABLE '' + @FactsTable
            EXEC SP_EXECUTESQL @Query;
        END
        ELSE
        BEGIN
            DECLARE Object_Cursor CURSOR FOR SELECT StartDate, EndDate FROM (
                SELECT StartDate, EndDate FROM (
                    SELECT StartDate, EndDate, [Hash] FROM MRP.ObjectHash
                    WHERE ObjectName = @FactsTable AND GatheringId <> @GatheringId AND StartDate IS NOT NULL AND EndDate IS NOT NULL
                    
                    EXCEPT
                    
                    SELECT StartDate, EndDate, [Hash] FROM MRP.ObjectHash
                    WHERE ObjectName = @FactsTable AND GatheringId = @GatheringId AND StartDate IS NOT NULL AND EndDate IS NOT NULL
                ) A

                UNION

                SELECT StartDate, EndDate FROM (
                    SELECT StartDate, EndDate, [Hash] FROM MRP.ObjectHash
                    WHERE ObjectName = @FactsTable AND GatheringId = @GatheringId AND StartDate IS NOT NULL AND EndDate IS NOT NULL
                    
                    EXCEPT
                    
                    SELECT StartDate, EndDate, [Hash] FROM MRP.ObjectHash
                    WHERE ObjectName = @FactsTable AND GatheringId <> @GatheringId AND StartDate IS NOT NULL AND EndDate IS NOT NULL
                ) B
            ) Q WHERE @FromDate <= StartDate AND @ToDate >= EndDate
            ORDER BY DATEDIFF(day, StartDate, EndDate) DESC

            OPEN Object_Cursor
            FETCH NEXT FROM Object_Cursor INTO @StartDate, @EndDate
            WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @Query = ''DELETE FROM '' + @FactsTable + '' WHERE [Date] BETWEEN '''''' +CAST(@StartDate AS NVARCHAR(40))+ '''''' AND '''''' +CAST(@EndDate AS NVARCHAR(40))+ '''''''';
                EXEC SP_EXECUTESQL @Query

                FETCH NEXT FROM Object_Cursor INTO @StartDate, @EndDate
            END
            CLOSE Object_Cursor
            DEALLOCATE Object_Cursor
        END
    END

    -- INSERT NEW DATA

    IF @IsDataInvalid = 1
    BEGIN
        SET @Query = @GeneratorSP + '''''''' +CAST(@FromDate AS NVARCHAR(40))+ '''''', '''''' +CAST(@ToDate AS NVARCHAR(40))+ '''''''';
        EXEC SP_EXECUTESQL @Query
    END
    ELSE
    BEGIN
        DECLARE Object_Cursor2 CURSOR FOR SELECT StartDate, EndDate FROM (
            SELECT StartDate, EndDate, [Hash] FROM MRP.ObjectHash
            WHERE ObjectName = @FactsTable AND GatheringId = @GatheringId AND StartDate IS NOT NULL AND EndDate IS NOT NULL

            EXCEPT

            SELECT StartDate, EndDate, [Hash] FROM MRP.ObjectHash
            WHERE ObjectName = @FactsTable AND GatheringId <> @GatheringId AND StartDate IS NOT NULL AND EndDate IS NOT NULL
        ) Q

        OPEN Object_Cursor2
        FETCH NEXT FROM Object_Cursor2 INTO @StartDate, @EndDate
        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @Query = @GeneratorSP + '''''''' +CAST(@StartDate AS NVARCHAR(40))+ '''''', '''''' +CAST(@EndDate AS NVARCHAR(40))+ '''''''';
            EXEC SP_EXECUTESQL @Query

            FETCH NEXT FROM Object_Cursor2 INTO @StartDate, @EndDate
        END
        CLOSE Object_Cursor2
        DEALLOCATE Object_Cursor2
    END

    IF @IsDataInvalid = 1
    BEGIN
        DELETE FROM MRP.ObjectHash WHERE (ObjectName = @FactsTable OR BaseFactTableName = @FactsTable)
            AND GatheringID <> @GatheringId
    END
    BEGIN
        DELETE FROM MRP.ObjectHash WHERE (ObjectName = @FactsTable OR BaseFactTableName = @FactsTable)
            AND GatheringID <> @GatheringId
            AND (
                (@FromDate <= StartDate AND EndDate <= @ToDate )
                OR
                (StartDate IS NULL AND EndDate IS NULL)
            )
    END
END
'
END
GO