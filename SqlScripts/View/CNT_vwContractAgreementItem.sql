If Object_ID('CNT.vwContractAgreementItem') Is Not Null
	Drop View CNT.vwContractAgreementItem
GO
CREATE VIEW CNT.vwContractAgreementItem
AS
SELECT    
    C.[ContractAgreementItemID],
    C.[ContractRef],		
    C.[ContractPriceListFieldTitle],  
    C.[ContractPriceListChapterTitle],         
    C.[ContractPriceListClassTitle],  
    C.[OperationalYear],              
    C.[OperationCode],                
    C.[OperationDescription],         
    C.[OperationUnit],                
    C.[OperationFee],                 
    C.[Quantity],                     
    C.[Price],
    C.[PrvOperationFee],                 
    C.[PrvQuantity],                     
    C.[PrvPrice] ,
    C.[ContractAgreementItemRef],
    C.[TaxPayerContractAgreementItemMapperRef],
    TM.[Serial] AS TaxPayerSerial,
    TM.[SerialTitle] AS TaxPayerSerialTitle,
    TM.[TaxRate] AS TaxPayerTaxRate

FROM  CNT.ContractAgreementItem AS C 
    LEFT JOIN GNR.TaxPayerContractAgreementItemMapper TM ON C.TaxPayerContractAgreementItemMapperRef = TM.TaxPayerContractAgreementItemMapperID