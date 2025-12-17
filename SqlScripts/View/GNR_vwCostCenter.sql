If Object_ID('GNR.vwCostCenter') Is Not Null
	Drop View GNR.vwCostCenter
GO
/* join dl*/
CREATE VIEW GNR.vwCostCenter
AS
SELECT     CC.CostCenterId, DL.Title AS DLTitle, DL.Title_En AS DLTitle_En,CC.DLRef, DL.[Type] DLType, CC.Version, DL.Code AS DLCode, CC.LastModificationDate, 
                      CC.LastModifier, CC.CreationDate, CC.Creator, CC.Type, DL.IsActive
FROM         GNR.CostCenter AS CC INNER JOIN
                      ACC.DL AS DL ON CC.DLRef = DL.DLId

