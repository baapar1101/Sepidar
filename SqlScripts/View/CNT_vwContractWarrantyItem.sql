If Object_ID('CNT.vwContractWarrantyItem') Is Not Null
	Drop View CNT.vwContractWarrantyItem
GO
CREATE VIEW [CNT].[vwContractWarrantyItem]
AS
SELECT CW.ContractWarrantyItemID, CW.ContractRef, CW.WarrantyRef , CW.RowNumber, CW.Regard, CW.DueDate, CW.Price, CW.DeliveryDate, CW.FurtherInfo, CW.Description, CW.Description_En, 
	C.Title AS ContractTitle, C.Title_En AS ContractTitle_En,
	W.Title AS WarrantyTitle, W.Title_En As WarrantyTitle_En 
FROM
CNT.ContractWarrantyItem AS CW	INNER JOIN 
CNT.Contract AS C ON CW.ContractRef = C.ContractID INNER JOIN 
CNT.Warranty AS W ON CW.WarrantyRef = W.WarrantyID
