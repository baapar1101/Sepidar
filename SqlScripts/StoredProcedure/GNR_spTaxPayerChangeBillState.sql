IF Object_ID('GNR.spTaxPayerSetStateSended') IS NOT NULL
    DROP PROCEDURE GNR.spTaxPayerSetStateSended
GO

IF Object_ID('GNR.spTaxPayerSetStateSent') IS NOT NULL
    DROP PROCEDURE GNR.spTaxPayerSetStateSent
GO

CREATE PROCEDURE GNR.spTaxPayerSetStateSent (
    @billNumber int)
AS
BEGIN
    BEGIN TRY
        DECLARE @id int = null, @logid int, @state int = null, @statusRef int = null, @customsDeclarationRef int = null, @invoiceRef int = null, @taxid VARCHAR(256), @relatedVoucherType int, @relatedVoucherId int;
        SELECT @id = [TaxPayerBillId], @state = [State], @taxid = UniqueBillCodeTaxid, @statusRef = StatusRef, @customsDeclarationRef = CustomsDeclarationRef, @invoiceRef = ISNULL(InvoiceRef, ExportServiceInvoiceRef) FROM GNR.TaxPayerBill WHERE BillNumber = @billNumber
        IF @id IS NULL
        BEGIN
            SELECT 'Bill not found'
            RETURN
        END

        BEGIN TRANSACTION
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
            VALUES (@logid, 2, @id, @relatedVoucherType, @relatedVoucherId, @taxid, -1, GETDATE(), '{"from":'+CAST(@state AS NVARCHAR(50))+',"to":4}');

        UPDATE GNR.TaxPayerBill SET [State] = 4 WHERE TaxPayerBillId = @id
        SELECT 'Changed state from ''' + (SELECT Title FROM FMK.Lookup WHERE [Type] = 'TaxPayerBillState' AND Code = @state)
            + ''' to ''' + (SELECT Title FROM FMK.Lookup WHERE [Type] = 'TaxPayerBillState' AND Code = 4) + ''''
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
    END CATCH
END
GO

IF Object_ID('GNR.spTaxPayerSetStateError') IS NOT NULL
    DROP PROCEDURE GNR.spTaxPayerSetStateError
GO
CREATE PROCEDURE GNR.spTaxPayerSetStateError (
    @billNumber int)
AS
BEGIN
    BEGIN TRY
        DECLARE @id int = null, @logid int, @state int = null, @statusRef int = null, @customsDeclarationRef int = null, @invoiceRef int = null, @taxid VARCHAR(256), @relatedVoucherType int, @relatedVoucherId int;
        SELECT @id = [TaxPayerBillId], @state = [State], @taxid = UniqueBillCodeTaxid, @statusRef = StatusRef, @customsDeclarationRef = CustomsDeclarationRef, @invoiceRef = ISNULL(InvoiceRef, ExportServiceInvoiceRef) FROM GNR.TaxPayerBill WHERE BillNumber = @billNumber
        IF @id IS NULL
        BEGIN
            SELECT 'Bill not found'
            RETURN
        END

        BEGIN TRANSACTION
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
            VALUES (@logid, 3, @id, @relatedVoucherType, @relatedVoucherId, @taxid, -1, GETDATE(), '{"from":'+CAST(@state AS NVARCHAR(50))+',"to":3}');

        UPDATE GNR.TaxPayerBill SET [State] = 3 WHERE TaxPayerBillId = @id
        SELECT 'Changed state from ''' + (SELECT Title FROM FMK.Lookup WHERE [Type] = 'TaxPayerBillState' AND Code = @state)
            + ''' to ''' + (SELECT Title FROM FMK.Lookup WHERE [Type] = 'TaxPayerBillState' AND Code = 3) + ''''
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
    END CATCH
END
GO
