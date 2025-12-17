IF EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('SLS.InvoiceReceiptInfo') AND [name] = 'PosAmount')
BEGIN
    DECLARE @sql nvarchar(max);

    IF EXISTS (SELECT 1 FROM sys.columns WHERE [object_id] = OBJECT_ID('SLS.InvoiceReceiptInfo') AND [name] = 'PosTrackingCode')
    BEGIN
        SET @sql = N'
            INSERT INTO SLS.InvoiceReceiptPosInfo 
            (
                InvoiceReceiptPosInfoId, 
                InvoiceRef, 
                Amount, 
                TrackingCode,
                PartyAccountSettlementItemRef
            )
            SELECT 
                ROW_NUMBER() OVER(ORDER BY IRI.InvoiceReceiptInfoId),
                IRI.InvoiceRef,
                IRI.PosAmount,
                IRI.PosTrackingCode,
                IRI.PartyAccountSettlementItemRef
            FROM SLS.InvoiceReceiptInfo IRI
            WHERE IRI.PosAmount <> 0;
        ';
    END
    ELSE
    BEGIN
        SET @sql = N'
            INSERT INTO SLS.InvoiceReceiptPosInfo 
            (
                InvoiceReceiptPosInfoId, 
                InvoiceRef, 
                Amount, 
                TrackingCode,
                PartyAccountSettlementItemRef
            )
            SELECT 
                ROW_NUMBER() OVER(ORDER BY IRI.InvoiceReceiptInfoId),
                IRI.InvoiceRef,
                IRI.PosAmount,
                NULL,
                IRI.PartyAccountSettlementItemRef
            FROM SLS.InvoiceReceiptInfo IRI
            WHERE IRI.PosAmount <> 0;
        ';
    END

    EXEC sys.sp_executesql @sql;

    IF NOT EXISTS (
        SELECT 1 
        FROM FMK.IDGeneration 
        WHERE TableName = 'SLS.InvoiceReceiptPosInfo'
    )
    BEGIN
        INSERT INTO FMK.IDGeneration (TableName, LastId)
        SELECT 
            'SLS.InvoiceReceiptPosInfo',
            ISNULL(MAX(InvoiceReceiptPosInfoId), 0)
        FROM SLS.InvoiceReceiptPosInfo;
    END

    IF EXISTS (
        SELECT 1
        FROM sys.columns
        WHERE [object_id] = OBJECT_ID('SLS.InvoiceReceiptInfo')
          AND [name] = 'PosAmount'
    )
        ALTER TABLE SLS.InvoiceReceiptInfo DROP COLUMN PosAmount;

    IF EXISTS (
        SELECT 1
        FROM sys.columns
        WHERE [object_id] = OBJECT_ID('SLS.InvoiceReceiptInfo')
          AND [name] = 'PosTrackingCode'
    )
        ALTER TABLE SLS.InvoiceReceiptInfo DROP COLUMN PosTrackingCode;
END
GO
