--<<FileName:vwProductSaleLine.sql>>--

IF Object_ID('DST.vwProductSaleLine') IS NOT NULL
	DROP VIEW DST.vwProductSaleLine
GO

CREATE VIEW DST.vwProductSaleLine
AS
SELECT ProductSaleLineId
		,	Code
		,	Title
		,	Title_En
		,	[Version]
		,	 Creator
		,	CreationDate
		,	LastModifier
		,	LastModificationDate
		,   ProductsState
		,	ServicesState
FROM DST.ProductSaleLine