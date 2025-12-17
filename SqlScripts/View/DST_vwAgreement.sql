If Object_ID('DST.vwAgreement') IS NOT NULL
	Drop View DST.vwAgreement
GO

CREATE VIEW DST.vwAgreement
AS
SELECT
[A].[AgreementId],
[A].[Title],
[A].[Title_En],
[A].[Creator],
[A].[CreationDate],
[A].[LastModifier],
[A].[LastModificationDate],
[A].[Version]
FROM DST.Agreement AS A