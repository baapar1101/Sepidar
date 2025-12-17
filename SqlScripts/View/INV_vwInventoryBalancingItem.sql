If Object_ID('INV.vwInventoryBalancingItem') Is Not Null
	Drop View INV.vwInventoryBalancingItem
GO
CREATE VIEW [INV].[vwInventoryBalancingItem]
AS
SELECT		IBI.InventoryBalancingItemId, IBI.InventoryBalancingRef, IBI.ItemRef, 
			I.Code AS ItemCode, I.Title AS ItemTitle, I.Title_En AS ItemTitle_En,
			I.TracingCategoryRef, IBI.TagNumber, IBI.Quantity, IBI.TracingRef, T.Title AS TracingTitle,
			I.UnitRef, U.Title AS UnitTitle, U.Title_En AS UnitTitle_En, IBI.SecondaryQuantity,
			I.SecondaryUnitRef,US.Title AS SecondaryUnitTitle, US.Title_En AS SecondaryUnitTitle_En,
			I.IsUnitRatioConstant, I.UnitsRatio, I.BarCode
FROM INV.InventoryBalancingItem IBI
	JOIN INV.Item I ON I.ItemId = IBI.ItemRef
	JOIN INV.Unit U ON U.UnitId = I.UnitRef
	LEFT JOIN INV.Unit AS US ON I.SecondaryUnitRef = US.UnitID
	LEFT JOIN INV.Tracing T ON T.TracingId = IBI.TracingRef