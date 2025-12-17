IF CAST(SERVERPROPERTY('productversion') AS VARCHAR(20)) >= '14.'
BEGIN
    EXEC SP_EXECUTESQL N'
IF (OBJECT_ID(''MRP.spGatherHash'',''P'') IS NOT NULL)
    DROP PROCEDURE [MRP].[spGatherHash]
'
END
GO
IF CAST(SERVERPROPERTY('productversion') AS VARCHAR(20)) >= '14.'
BEGIN
    EXEC SP_EXECUTESQL N'
CREATE PROCEDURE [MRP].[spGatherHash](
    @FactTableName VARCHAR(100),
    @GatheringId INT,
    @FromDate DATE, @ToDate DATE,
    @HashPeriodResulotion CHAR(1) = ''M''
)
AS
BEGIN
    DECLARE @DependentViews TABLE(ViewName VARCHAR(100), DateBased BIT)
    INSERT INTO @DependentViews(ViewName, DateBased)
    SELECT od.DependentView, od.DateBased
    FROM MRP.ObjectDependency od
    WHERE od.FactTableName = @FactTableName

    DECLARE @DependentView VARCHAR(100)
    DECLARE @DateBased BIT
    DECLARE Object_Cursor CURSOR FOR SELECT ViewName, DateBased FROM @DependentViews

    OPEN Object_Cursor
    FETCH NEXT FROM Object_Cursor INTO @DependentView, @DateBased
    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @QUERY NVARCHAR(MAX)
        BEGIN TRY
            EXEC [MRP].[spGenerateObjectHashQuery]
                @ObjectName = @DependentView,
                @FromDate = @FromDate,
                @ToDate = @ToDate,
                @DateBased = @DateBased,
                -- @GatheringId = @GatheringId,
                @HashPeriodResulotion = @HashPeriodResulotion,
                @BUILD_HASH_QUERY = @QUERY OUTPUT
            SET @QUERY = ''INSERT INTO MRP.ObjectHash(ObjectName, StartDate, EndDate, GatheringId, BaseFactTableName, [Hash])
                SELECT ObjectName, StartDate, EndDate, '' + CAST(@GatheringId AS VARCHAR(15)) + '' AS GatheringId,
                '''''' + @FactTableName + '''''' AS BaseFactTableName, [Hash] FROM (''+@QUERY +'') as Q ''
            EXEC SP_EXECUTESQL @QUERY
        END TRY
        BEGIN CATCH
            DECLARE @ErrorMsg NVARCHAR(200)
            SET @ErrorMsg = ERROR_MESSAGE()
            PRINT ''ERROR: '' + @ErrorMsg
        END CATCH
        FETCH NEXT FROM Object_Cursor INTO @DependentView, @DateBased
    END
    CLOSE Object_Cursor
    DEALLOCATE Object_Cursor

    INSERT INTO MRP.ObjectHash(ObjectName, StartDate, EndDate, GatheringId, BaseFactTableName, [Hash])
    SELECT ObjectName, StartDate, EndDate, GatheringId, BaseFactTableName, [Hash]
    FROM (
        SELECT
            [ObjectName] = @FactTableName,
            [StartDate] = gp.MinDate,
            [EndDate] = gp.MaxDate,
            [GatheringId] = @GatheringId,
            [BaseFactTableName] = NULL,
            [Hash] = HASHBYTES(''SHA2_256'', (
                SELECT [Hash]
                FROM MRP.ObjectHash
                WHERE BaseFactTableName = @FactTableName
                    AND GatheringID = @GatheringId
                    AND (
                        (MinDate IS NOT NULL AND MaxDate IS NOT NULL AND StartDate = MinDate AND EndDate = MaxDate)
                        OR (StartDate IS NULL AND EndDate IS NULL AND MinDate IS NULL AND MaxDate IS NULL)
                    )
                    ORDER BY StartDate, ObjectName
                    FOR JSON AUTO))
        FROM (
            SELECT DISTINCT StartDate AS MinDate, EndDate AS MaxDate
            FROM MRP.ObjectHash
            WHERE GatheringID = @GatheringId
                AND BaseFactTableName IS NOT NULL
        ) AS gp
    ) Q
    WHERE Q.[Hash] IS NOT NULL
END
'
END
GO