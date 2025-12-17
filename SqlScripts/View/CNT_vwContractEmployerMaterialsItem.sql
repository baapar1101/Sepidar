If Object_ID('CNT.vwContractEmployerMaterialsItem') Is Not Null
	Drop View CNT.vwContractEmployerMaterialsItem
GO
CREATE VIEW CNT.vwContractEmployerMaterialsItem
AS
SELECT     E.EmployerMaterialsID, E.ContractRef, E.RowNumber, E.ItemRef, E.Quantity, E.SecondaryQuantity, E.Fee, E.TotalPrice,
					  I.Title AS ItemTitle, I.Title_En AS ItemTitle_En, I.Code AS ItemCode, I.UnitsRatio AS ItemUnitsRatio,I.IsUnitRatioConstant,
					  U.Title AS UnitTitle, U.Title_En AS UnitTitle_En, I.TracingCategoryRef,
					  U2.Title AS SecondaryUnitTitle,  U2.Title_En AS SecondaryUnitTitle_En, U2.UnitID SecondaryUnitRef,
                      E.ReceiptNumber, E.ReceiptRef, E.StockRef, INV.Stock.Code AS StockCode, 
                      INV.Stock.Title AS StockTitle, INV.Stock.Title_En AS StockTitle_En, E.Date, 
                      E.[Description], E.Description_En, E.TracingRef, T.Title AS TracingTitle,
					  E.InventoryDeliveryRef, INV.InventoryDelivery.Number InventoryDeliveryNumber, INV.InventoryDelivery.Date InventoryDeliveryDate
FROM         CNT.ContractEmployerMaterialsItem AS E INNER JOIN
                      INV.Item AS I ON I.ItemID = E.ItemRef INNER JOIN
                      INV.Unit AS U ON U.UnitID = I.UnitRef LEFT OUTER JOIN
                      INV.Unit AS U2 ON I.SecondaryUnitRef = U2.UnitID LEFT OUTER JOIN
                      INV.Tracing AS T ON E.TracingRef = T.TracingID LEFT OUTER JOIN
                      INV.Stock ON E.StockRef = INV.Stock.StockID LEFT OUTER JOIN
                      INV.InventoryReceipt ON E.ReceiptRef = INV.InventoryReceipt.InventoryReceiptID LEFT OUTER JOIN
                      INV.InventoryDelivery ON E.InventoryDeliveryRef = INV.InventoryDelivery.InventoryDeliveryID

