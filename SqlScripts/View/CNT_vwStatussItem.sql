If Object_ID('CNT.vwStatusItem') Is Not Null
    Drop View CNT.vwStatusItem
GO
CREATE VIEW CNT.vwStatusItem
AS
SELECT
    SI.StatusItemID,
    SI.StatusRef,
    SI.RowNumber,
    SI.ItemRef,
    SI.ContractAgreementItemRef,
    I.Code AS ItemCode,
    CAI.OperationCode AS AgreementOperationCode,
    CASE
        WHEN SI.ItemTitle IS NOT NULL THEN SI.ItemTitle
        WHEN SI.ItemRef IS NOT NULL THEN I.Title
        WHEN SI.ContractAgreementItemRef IS NOT NULL THEN CAI.OperationDescription
        ELSE ''
    END AS ItemTitle,
    CASE
        WHEN SI.ItemTitle_En IS NOT NULL THEN SI.ItemTitle_En
        WHEN SI.ItemRef IS NOT NULL THEN I.Title_En
        ELSE ''
    END AS ItemTitle_En,
    SI.Quantity,
    SI.Fee,
    SI.Price,
    SI.ConfirmedPrice,
    SI.ConfirmedQuantity,
    SI.Description,
    SI.Description_En,
    SI.ConfirmedFee,
    SI.TaxPayerContractAgreementItemMapperRef,
    TM.Serial AS TaxPayerSerial,
    TM.SerialTitle AS TaxPayerSerialTitle,
    TM.TaxRate AS TaxPayerTaxRate

FROM CNT.StatusItem AS SI
    INNER JOIN CNT.Status AS S ON S.StatusID = SI.StatusRef
    LEFT JOIN INV.Item AS I ON SI.ItemRef = I.ItemID
    LEFT JOIN CNT.ContractAgreementItem CAI ON SI.ContractAgreementItemRef = CAI.ContractAgreementItemID
    LEFT JOIN GNR.TaxPayerContractAgreementItemMapper TM ON SI.TaxPayerContractAgreementItemMapperRef = TM.TaxPayerContractAgreementItemMapperID