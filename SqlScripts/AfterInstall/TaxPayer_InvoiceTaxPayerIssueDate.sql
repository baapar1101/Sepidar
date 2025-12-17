UPDATE I
SET TaxPayerBillIssueDateTime = CASE
                                    WHEN TPB.ActionTypeIns IS NULL THEN I.Date
                                    WHEN TPB.ActionTypeIns = 1 AND IsEdited = 0 THEN I.Date
                                    WHEN TPB.ActionTypeIns = 1 AND IsEdited = 1 THEN I.LastModificationDate
                                    WHEN TPB.ActionTypeIns = 2 AND IsEdited = 0 THEN TPB.IssueDateIndatim
                                    WHEN TPB.ActionTypeIns = 2 AND IsEdited = 1 THEN I.LastModificationDate
                                    WHEN TPB.ActionTypeIns = 3 AND TPB.State = 4 THEN TPB.IssueDateIndatim
                                    WHEN TPB.ActionTypeIns = 3 THEN I.LastModificationDate
                                    ELSE I.Date
                                END
FROM SLS.Invoice I
LEFT JOIN (
    SELECT *
    FROM
        (SELECT *,
                RowNumber = ROW_NUMBER() over (PARTITION BY InvoiceRef ORDER BY TaxPayerBillId DESC)
         FROM GNR.TaxPayerBill
         WHERE InvoiceRef IS NOT NULL
           AND ReturnedInvoiceRef IS NULL) a
    WHERE RowNumber = 1
) TPB ON TPB.InvoiceRef = I.InvoiceId
WHERE TaxPayerBillIssueDateTime IS NULL

GO

UPDATE sls.ReturnedInvoice SET TaxPayerBillIssueDateTime = Date WHERE TaxPayerBillIssueDateTime IS NULL