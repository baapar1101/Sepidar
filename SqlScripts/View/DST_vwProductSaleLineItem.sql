--<<FileName:DST_vwProductSaleLineItem.sql>>--

IF OBJECT_ID('DST.vwProductSaleLineItem') IS NOT NULL
	DROP VIEW DST.vwProductSaleLineItem
GO

CREATE VIEW DST.vwProductSaleLineItem
AS

SELECT
	pit.ProductSaleLineItemId
   ,pit.ProductSaleLineRef
   ,p.Code AS LineCode
   ,p.Title AS LineTitle
   ,p.Title_En AS LineTitle_En
   ,pit.ItemRef
   ,i.Code AS ItemCode
   ,i.Title AS ItemTitle
   ,i.Title_En AS ItemTitle_En
   ,i.Type AS ItemType
   ,i.SaleGroupRef
   ,i.SaleGroupTitle
   ,i.SaleGroupTitle_En
   ,i.PurchaseGroupRef
   ,i.PurchaseGroupTitle
   ,i.PurchaseGroupTitle_En
   ,i.CodingGroupRef
   ,i.CodingGroupTitle
   ,i.CodingGroupTitle_En
FROM DST.ProductSaleLineItem pit
LEFT JOIN DST.ProductSaleLine p
	ON pit.ProductSaleLineRef = p.ProductSaleLineId
LEFT JOIN INV.vwItem i
	ON pit.ItemRef = i.ItemID
