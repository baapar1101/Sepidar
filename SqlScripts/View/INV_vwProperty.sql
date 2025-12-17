If Object_ID('INV.vwProperty') Is Not Null
	Drop View INV.vwProperty
GO
CREATE VIEW INV.vwProperty
AS
SELECT P.PropertyID,						
	   P.Title,
	   P.Title_En,
	   p.IsSelectable,
	   P.IsActive,
	   P.Number,
	   P.Creator,
	   P.CreationDate,
	   P.LastModifier,
	   P.LastModificationDate,
	   P.[Version]

FROM INV.Property P
	 