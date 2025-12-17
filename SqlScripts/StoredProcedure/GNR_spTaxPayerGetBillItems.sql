IF Object_ID('GNR.spTaxPayerGetBillItems') IS NOT NULL
    DROP PROCEDURE GNR.spTaxPayerGetBillItems
GO
CREATE PROCEDURE GNR.spTaxPayerGetBillItems (
    @billNumber int)
AS
BEGIN
    SELECT BI.*
    FROM GNR.vwTaxPayerBillItem BI
    INNER JOIN GNR.TaxPayerBill B ON BI.TaxPayerBillRef = B.TaxPayerBillId
    WHERE B.BillNumber = @billNumber
END
GO
