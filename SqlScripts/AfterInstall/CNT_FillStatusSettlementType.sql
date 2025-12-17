UPDATE S SET S.SettlementType = ISNULL((
    SELECT TOP 1 CASE WHEN SettlementTypeSetm = 0 THEN 1 ELSE SettlementTypeSetm END
    FROM GNR.TaxPayerBill B
    WHERE B.StatusRef = S.StatusID
    ORDER BY B.TaxPayerBillId DESC
), 1)
FROM CNT.[Status] AS S
WHERE S.SettlementType = 0