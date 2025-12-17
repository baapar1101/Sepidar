If Object_ID('POM.vwPurchaseRequestItemVendor') Is Not Null
	Drop View POM.vwPurchaseRequestItemVendor
GO
CREATE VIEW POM.vwPurchaseRequestItemVendor
AS
SELECT 
	PRIV.[PurchaseRequestItemVendorID], 
	PRIV.[PurchaseRequestItemRef], 
	PRIV.[VendorDlRef],
	VDL.[Title] AS VendorDlTitle,
	VDL.[Title_En] AS VendorDlTitle_En,
	VDL.[Code] AS VendorDlCode,
	P.PartyId AS VendorPartyRef

FROM POM.PurchaseRequestItemVendor PRIV
--JOIN POM.PurchaseRequestItem II  ON II.PurchaseRequestItemID = OIAF.PurchaseRequestItemRef
JOIN ACC.DL VDL  ON VDL.DlID = PRIV.VendorDlRef
JOIN GNR.Party P  ON P.DLRef = PRIV.VendorDlRef

