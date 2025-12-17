If Object_ID('PAY.vwContractElementOther') Is Not Null
	Drop View PAY.vwContractElementOther
GO
CREATE VIEW PAY.vwContractElementOther
AS
SELECT     PAY.ContractElement.ContractElementId, PAY.ContractElement.ContractRef, PAY.ContractElement.Value, E.Title AS ElementTitle, E.Title_En AS ElementTitle_En,
           PAY.ContractElement.ElementRef, E.DisplayOrder
FROM         PAY.ContractElement INNER JOIN
                      PAY.Element AS E ON PAY.ContractElement.ElementRef = E.ElementId
WHERE     (E.Class = 3 OR
                      E.Class = 4) AND (E.Type = 4) AND (E.IsActive=1)

