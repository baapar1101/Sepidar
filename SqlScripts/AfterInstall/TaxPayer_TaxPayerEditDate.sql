UPDATE TPB
SET TPB.EditDateTime = I.TaxPayerBillIssueDateTime
FROM GNR.TaxPayerBill TPB
JOIN SLS.Invoice I ON I.InvoiceId = TPB.InvoiceRef
WHERE TPB.EditDateTime IS NULL AND TPB.IsEdited = 1 