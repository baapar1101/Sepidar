IF Object_ID('GNR.spTaxPayerGetBillSubmitLogs') IS NOT NULL
    DROP PROCEDURE GNR.spTaxPayerGetBillSubmitLogs
GO
CREATE PROCEDURE GNR.spTaxPayerGetBillSubmitLogs (
    @billNumber int)
AS
BEGIN
    SELECT
        SL.TaxPayerBillSubmitLogId,
        SL.TaxPayerBillRef,
        SL.TaxPayerBillId,
        (SELECT TOP 1 Title FROM FMK.Lookup WHERE [Type] = 'TaxPayerBillSubmitType' AND Code = SL.SubmitType) AS SubmitType,
        (SELECT TOP 1 Title FROM FMK.Lookup WHERE [Type] = 'BillSubmitLogRequestType' AND Code = SL.RequestType) AS RequestType,
        SL.Endpoint,
        SL.Request,
        SL.ResponseHttpStatusCode,
        SL.Response,
        SL.Exception,
        SL.ResultMessage,
        (SELECT TOP 1 Title FROM FMK.Lookup WHERE [Type] = 'TaxPayerBillState' AND Code = SL.ResultState) AS ResultState,
        (SELECT TOP 1 Title FROM FMK.Lookup WHERE [Type] = 'BillRelatedVoucherType' AND Code = SL.RelatedVoucherType) AS RelatedVoucherType,
        SL.RelatedVoucherId,
        SL.TaxId,
        SL.DateTime
    FROM GNR.vwTaxPayerBillSubmitLog SL
    INNER JOIN GNR.TaxPayerBill B ON ISNULL(SL.TaxPayerBillRef, SL.TaxPayerBillId) = B.TaxPayerBillId
    WHERE B.BillNumber = @billNumber
END
GO
