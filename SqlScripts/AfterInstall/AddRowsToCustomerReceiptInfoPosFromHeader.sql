IF EXISTS (SELECT 1 FROM sys.columns WHERE [object_id]=OBJECT_ID('DST.CustomerReceiptInfo') AND [name] = 'ReceiptPosAmount')
BEGIN
    DECLARE @sql nvarchar(max);

    IF EXISTS (SELECT 1 FROM sys.columns WHERE [object_id]=OBJECT_ID('DST.CustomerReceiptInfo') AND [name] = 'ReceiptPosTrackingCode')
    BEGIN
        SET @sql = N'
            INSERT INTO DST.CustomerReceiptInfoPos 
            (
                CustomerReceiptInfoPosId, 
                CustomerReceiptInfoRef, 
                Amount, 
                TrackingCode
            )
            SELECT 
                ROW_NUMBER() OVER(ORDER BY CRI.CustomerReceiptInfoId),
                CRI.CustomerReceiptInfoId,
                CRI.ReceiptPosAmount,
                CRI.ReceiptPosTrackingCode
            FROM DST.CustomerReceiptInfo CRI
            WHERE CRI.ReceiptPosAmount != 0;
        ';
    END
    ELSE
    BEGIN
        SET @sql = N'
            INSERT INTO DST.CustomerReceiptInfoPos 
            (
                CustomerReceiptInfoPosId, 
                CustomerReceiptInfoRef, 
                Amount, 
                TrackingCode
            )
            SELECT 
                ROW_NUMBER() OVER(ORDER BY CRI.CustomerReceiptInfoId),
                CRI.CustomerReceiptInfoId,
                CRI.ReceiptPosAmount,
                NULL
            FROM DST.CustomerReceiptInfo CRI
            WHERE CRI.ReceiptPosAmount != 0;
        ';
    END

    EXEC sys.sp_executesql @sql;

    IF NOT EXISTS (
        SELECT 1 
        FROM FMK.IDGeneration 
        WHERE TableName = 'DST.CustomerReceiptInfoPos'
    )
    BEGIN
        INSERT INTO FMK.IDGeneration (TableName, LastId)
        SELECT 
            'DST.CustomerReceiptInfoPos',
            ISNULL(MAX(CustomerReceiptInfoPosId), 0)
        FROM DST.CustomerReceiptInfoPos;
    END

    IF EXISTS (
        SELECT 1
        FROM sys.columns
        WHERE [object_id]=OBJECT_ID('DST.CustomerReceiptInfo')
          AND [name] = 'ReceiptPosAmount'
    )
        ALTER TABLE DST.CustomerReceiptInfo DROP COLUMN ReceiptPosAmount;

    IF EXISTS (
        SELECT 1
        FROM sys.columns
        WHERE [object_id]=OBJECT_ID('DST.CustomerReceiptInfo')
          AND [name] = 'ReceiptPosTrackingCode'
    )
        ALTER TABLE DST.CustomerReceiptInfo DROP COLUMN ReceiptPosTrackingCode;
END
GO
