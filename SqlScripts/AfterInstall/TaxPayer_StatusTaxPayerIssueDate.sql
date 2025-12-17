UPDATE S
SET TaxPayerBillIssueDateTime = S.[ConfirmationDate]
FROM [CNT].[Status] AS [S]
WHERE TaxPayerBillIssueDateTime IS NULL

GO
