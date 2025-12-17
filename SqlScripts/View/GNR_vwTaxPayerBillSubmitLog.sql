IF OBJECT_ID('GNR.vwTaxPayerBillSubmitLog') IS NOT NULL
    DROP VIEW GNR.vwTaxPayerBillSubmitLog
GO
CREATE VIEW GNR.vwTaxPayerBillSubmitLog
AS
SELECT TPBSL.[TaxPayerBillSubmitLogId]
     , TPBSL.[TaxPayerBillRef]
     , TPBSL.[TaxPayerBillId]
     , TPBSL.[SubmitType]
     , TPBSL.[RequestType]
     , TPBSL.[Endpoint]
     , TPBSL.[Request]
     , TPBSL.[ResponseHttpStatusCode]
     , TPBSL.[Response]
     , TPBSL.[Exception]
     , TPBSL.[ResultMessage]
     , TPBSL.[ResultState]
     , TPBSL.[RelatedVoucherType]
     , TPBSL.[RelatedVoucherId]
     , TPBSL.[TaxId]
     , TPBSL.[DateTime]
FROM GNR.TaxPayerBillSubmitLog TPBSL