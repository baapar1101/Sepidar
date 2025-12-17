If Object_ID('SLS.vwProductPackDiscount') Is Not Null
	Drop View SLS.vwProductPackDiscount
GO
CREATE VIEW SLS.vwProductPackDiscount
AS
SELECT	DI.ProductPackDiscountID, DI.DiscountRef ,		DI.ProductPackRef,
		PP.Title AS ProductPackTitle, PP.Title_En AS ProductPackTitle_En		
FROM   SLS.ProductPackDiscount AS DI		
		LEFT JOIN SLS.ProductPack PP ON DI.ProductPackRef = pp.ProductPackId