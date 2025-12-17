IF Object_ID('GNR.spSudoTaxPayerDeleteBill') IS NOT NULL
    DROP PROCEDURE GNR.spSudoTaxPayerDeleteBill
GO
CREATE PROCEDURE GNR.spSudoTaxPayerDeleteBill (
    @billNumber int)
AS
BEGIN
    BEGIN TRY
        DECLARE @id int = null, @logid int, @statusRef int = null, @customsDeclarationRef int = null, @invoiceRef int = null, @taxid VARCHAR(256), @query NVARCHAR(MAX), @relatedVoucherType int, @relatedVoucherId int;
        SELECT @id = [TaxPayerBillId], @taxid = UniqueBillCodeTaxid, @statusRef = StatusRef, @customsDeclarationRef = CustomsDeclarationRef, @invoiceRef = ISNULL(InvoiceRef, ExportServiceInvoiceRef) FROM GNR.TaxPayerBill WHERE BillNumber = @billNumber
        IF @id IS NULL
        BEGIN
            SELECT 'Bill not found'
            RETURN
        END

        BEGIN TRANSACTION
        EXEC GNR.spCreateTaxpayerBillInsertQuery @id, @query OUTPUT

        IF @statusRef IS NOT NULL
        BEGIN
            SET @relatedVoucherType = 2;
            SET @relatedVoucherId = @statusRef;
        END
        ELSE IF @customsDeclarationRef IS NOT NULL
        BEGIN
            SET @relatedVoucherType = 3;
            SET @relatedVoucherId = @customsDeclarationRef;
        END
        ELSE
        BEGIN
            SET @relatedVoucherType = 1;
            SET @relatedVoucherId = @invoiceRef;
        END

        EXEC FMK.spGetNextId 'GNR.TaxPayerGeneralLog', @logid OUTPUT, 1
        INSERT INTO GNR.TaxPayerGeneralLog ([TaxPayerGeneralLogId], [Type], [TaxPayerBillRef], [RelatedVoucherType], [RelatedVoucherId], [TaxId], [Creator], [CreationDate], [Value])
            VALUES (@logid, 1, @id, @relatedVoucherType, @relatedVoucherId, @taxid, -1, GETDATE(), @query);

        DELETE FROM GNR.TaxPayerBill where TaxPayerBillId = @id
        SELECT 'Successfully deleted the bill'
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
    END CATCH
END
GO

IF Object_ID('GNR.spTaxPayerDeleteBill') IS NOT NULL
    DROP PROCEDURE GNR.spTaxPayerDeleteBill
GO
CREATE PROCEDURE GNR.spTaxPayerDeleteBill (
    @billNumber int)
AS
BEGIN
    DECLARE @state int = 0;
    SELECT @state = [State] FROM GNR.TaxPayerBill WHERE BillNumber = @billNumber
    IF @state <> 3 /* Error state */
    BEGIN
        SELECT 'The bill must be in the Error state'
        RETURN
    END

    EXEC GNR.spSudoTaxPayerDeleteBill @billNumber
END
GO
