If Object_ID('INV.vwProducedItemPrice') Is Not Null
	Drop View INV.vwProducedItemPrice
GO

CREATE VIEW [INV].[vwProducedItemPrice]
AS
SELECT     PIP.ProducedItemPriceID, PIP.StockRef, PIP.ItemRef, PIP.Price, PIP.FiscalYearRef, PIP.Version, I.Code, I.Title, I.Title_En, U1.Title AS UnitTitle, 
                      U1.Title_En AS UnitTitle_En, U2.Title AS SecondaryUnitTitle, U2.Title_En AS SecondaryUnitTitle_En
FROM         INV.ProducedItemPrice AS PIP INNER JOIN
                      INV.Item AS I ON PIP.ItemRef = I.ItemID INNER JOIN
                      INV.Unit AS U1 ON I.UnitRef = U1.UnitID LEFT JOIN
                      INV.Unit AS U2 ON I.SecondaryUnitRef = U2.UnitID

GO