If Object_ID('PAY.vwContractElementBonus') Is Not Null
	Drop View PAY.vwContractElementBonus
GO
CREATE VIEW PAY.vwContractElementBonus
AS
SELECT     PAY.ContractElement.ContractElementId, PAY.ContractElement.ContractRef, PAY.ContractElement.Value, E.Title AS ElementTitle, E.Title_En As ElementTitle_En,
           PAY.ContractElement.ElementRef, E.DisplayOrder
FROM         PAY.ContractElement INNER JOIN
                      PAY.Element AS E ON PAY.ContractElement.ElementRef = E.ElementId
WHERE     (E.Class = 2) AND (E.Type = 4) AND (E.IsActive=1)

