If Object_ID('CNT.vwEmployerMaterialsItem') Is Not Null
	Drop View CNT.vwEmployerMaterialsItem
GO
CREATE VIEW [CNT].[vwEmployerMaterialsItem]
AS
SELECT E.EmployerMaterialsID, E.ContractRef, E.RowNumber, E.ItemRef, E.Quantity, E.Fee,
		I.Title AS ItemTitle, I.Title_En AS ItemTitle_En, I.Code AS ItemCode,
		U.Title AS UnitTitle, U.Title_En AS UnitTitle_En

FROM
CNT.ContractEmployerMaterialsItem AS E INNER JOIN
INV.Item AS I ON I.ItemID = E.ItemRef INNER JOIN
INV.Unit AS U ON U.UnitID = I.UnitRef