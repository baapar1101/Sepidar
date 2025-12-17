If Object_ID('POS.vwQuickBarItem') Is Not Null
	Drop View [POS].[vwQuickBarItem]
GO
CREATE View [POS].[vwQuickBarItem]
AS
SELECT 
	Q.[QuickBarItemID],
	Q.[ItemIndex],
	Q.QuickBarRef,
	Q.[ItemRef],
	I.Code as ItemCode,
	I.Title as ItemTitle,
	I.Title_En as ItemTitle_En,
	I.Barcode as ItemBarcode,
	I.Type as ItemType,
	II.Image as ItemImage,
	Q.[Shortcut]
FROM 
	[POS].[QuickBarItem] Q JOIN 
	INV.Item I ON Q.ItemRef = ItemID LEFT JOIN
	INV.ItemImage II ON II.ItemRef = I.ItemID

