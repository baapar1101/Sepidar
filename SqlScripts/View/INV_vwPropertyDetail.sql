If Object_ID('INV.vwPropertyDetail') Is Not Null
	Drop View INV.vwPropertyDetail
GO
CREATE VIEW INV.vwPropertyDetail
AS
SELECT P.PropertyDetailID,						
	   P.Title,
	   P.PropertyRef,
	   P.[Version]

FROM INV.PropertyDetail P
	 