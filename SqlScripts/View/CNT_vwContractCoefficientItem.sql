If Object_ID('CNT.vwContractCoefficientItem') Is Not Null
	Drop View CNT.vwContractCoefficientItem
GO
CREATE VIEW CNT.vwContractCoefficientItem
AS
SELECT     CC.ContractCoefficientID, CC.RowNumber, CC.CoefficientRef, CC.ContractRef,  CO.Code AS CoefficientCode, CO.Title AS CoefficientTitle, 
                      CO.Title_En AS CoefficientTitle_En, CC.[Percent], CO.[Type] AS [Type]  ,C.Title AS ContractTitle, C.Title_En AS ContractTitle_En
FROM         CNT.ContractCoefficientItem AS CC INNER JOIN
                      CNT.Contract AS C ON CC.ContractRef = C.ContractID INNER JOIN
                      CNT.Coefficient AS CO ON CC.CoefficientRef = CO.CoefficientID


