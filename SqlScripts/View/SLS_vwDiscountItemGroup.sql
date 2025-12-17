If Object_ID('SLS.vwDiscountItemGroup') Is Not Null
	Drop View SLS.vwDiscountItemGroup
GO
CREATE VIEW SLS.vwDiscountItemGroup
AS
SELECT	*
FROM   SLS.DiscountItemGroup 
		