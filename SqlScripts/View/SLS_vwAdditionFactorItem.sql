If Object_ID('SLS.vwAdditionFactorItem') Is Not Null
	Drop View SLS.vwAdditionFactorItem
GO
CREATE VIEW SLS.vwAdditionFactorItem
AS
SELECT AFI.*
FROM SLS.AdditionFactorItem AS AFI
