IF OBJECT_ID('GNR.vwSignature') IS NOT NULL
	DROP VIEW GNR.vwSignature
GO

CREATE VIEW GNR.vwSignature
AS
SELECT
    S.SignatureId,
    Null AS SignatureBlob,
    S.Version,
    S.Creator,
    S.CreationDate,
    S.LastModifier,
    S.LastModificationDate
FROM GNR.[Signature] S