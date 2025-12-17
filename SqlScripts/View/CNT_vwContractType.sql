If Object_ID('CNT.vwContractType') Is Not Null
	Drop View CNT.vwContractType
GO
CREATE VIEW [CNT].[vwContractType]
AS
SELECT C.ContractTypeID, C.Title, C.Title_En, C.Version, C.Creator, C.CreationDate, C.LastModifier, C.LastModificationDate
FROM
CNT.ContractType  C
