If Object_ID('SLS.vwPriceNoteItemDiscount') Is Not Null
	Drop View SLS.vwPriceNoteItemDiscount
GO
CREATE VIEW SLS.vwPriceNoteItemDiscount
AS
SELECT	PNID.*,
		D.Title AS DiscountTitle,D.Title_En AS DiscountTitle_En
FROM   SLS.PriceNoteItemDiscount AS PNID 
		INNER JOIN SLS.Discount AS D ON D.DiscountID = PNID.DiscountRef

