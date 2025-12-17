If Object_ID('SLS.vwProductPack') Is Not Null
	Drop View SLS.vwProductPack
GO
CREATE VIEW SLS.vwProductPack
AS
SELECT	PP.*
FROM   SLS.ProductPack AS PP
		

