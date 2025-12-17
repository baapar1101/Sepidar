IF Object_ID('GNR.spSaveGeneralLog') IS NOT NULL
DROP PROCEDURE GNR.spSaveGeneralLog
GO
CREATE PROCEDURE GNR.spSaveGeneralLog(
    @Type INT,
    @billId INT,
    @voucherType INT,
    @voucherId INT,
    @taxId VARCHAR(250),
    @creator INT,
    @message NVARCHAR(MAX))
AS
    BEGIN

    DECLARE @logId INT
    EXEC FMK.spGetNextId 'GNR.TaxPayerGeneralLog', @logId OUTPUT, 1
    INSERT INTO GNR.TaxPayerGeneralLog ([TaxPayerGeneralLogId], [Type], [TaxPayerBillRef], [RelatedVoucherType], [RelatedVoucherId], [TaxId], [Creator], [CreationDate], [Value])
    VALUES (@logId, @Type, @billId, @voucherType, @voucherId, @taxId, @creator, GETDATE(), @message);

    END
GO
