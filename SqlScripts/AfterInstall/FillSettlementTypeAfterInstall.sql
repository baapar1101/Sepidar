UPDATE I SET I.SettlementType = ISNULL((
    SELECT TOP 1 CASE WHEN SettlementTypeSetm = 0 THEN 1 ELSE SettlementTypeSetm END
    FROM GNR.TaxPayerBill B
    WHERE B.InvoiceRef = I.InvoiceId
    ORDER BY B.TaxPayerBillId DESC
), 1)
FROM SLS.Invoice I
WHERE I.SettlementType = 0