If Object_ID('CNT.vwContractPriceList') Is Not Null
    Drop View CNT.vwContractPriceList
GO
CREATE VIEW CNT.vwContractPriceList
AS
SELECT    
        C.[ContractPriceListID],
        C.[ContractPriceListFieldTitle],
        C.[ContractPriceListChapterTitle],
        C.[ContractPriceListClassTitle],
        C.[OperationalYear],
        C.[OperationCode],
        C.[OperationDescription],
        C.[OperationUnit],
        C.[OperationFee],
        C.[Version],
        C.[Creator],
        C.[CreationDate],
        C.[LastModifier] ,
        C.[LastModificationDate],
        C.[TaxPayerContractAgreementItemMapperRef],
        TM.[Serial] AS TaxPayerSerial,
        TM.[SerialTitle] AS TaxPayerSerialTitle,
        TM.[TaxRate] AS TaxPayerTaxRate

FROM  CNT.ContractPriceList AS C
    LEFT JOIN GNR.TaxPayerContractAgreementItemMapper TM ON C.TaxPayerContractAgreementItemMapperRef = TM.TaxPayerContractAgreementItemMapperID
