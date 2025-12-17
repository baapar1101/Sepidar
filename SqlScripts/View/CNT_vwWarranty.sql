If Object_ID('CNT.vwWarranty') Is Not Null
	Drop View CNT.vwWarranty
GO
CREATE VIEW [CNT].[vwWarranty]
AS
SELECT W.warrantyID, W.Title, W.Title_En, W.Version, W.Creator, W.CreationDate, W.LastModifier, W.LastModificationDate
FROM
CNT.Warranty  W
