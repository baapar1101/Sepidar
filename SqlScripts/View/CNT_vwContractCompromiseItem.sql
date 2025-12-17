If Object_ID('CNT.vwContractCompromiseItem') Is Not Null
	Drop View CNT.vwContractCompromiseItem
GO
CREATE VIEW CNT.vwContractCompromiseItem
AS
SELECT    
	ContractCompromiseItemID,
	ContractRef,
	Date,
	Description,
	Description_En

FROM  CNT.ContractCompromiseItem 
                      