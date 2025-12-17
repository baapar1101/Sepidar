IF Object_ID('DST.vwSaleTypeConstraintItem') IS NOT NULL
	DROP VIEW DST.vwSaleTypeConstraintItem
GO

CREATE VIEW DST.vwSaleTypeConstraintItem
AS
SELECT 
	CI.[SaleTypeConstraintItemId],
	CI.[SaleTypeConstraintRef],
	CI.[SaleTypeRef],
	S.Number AS SaleTypeNumber,
	S.Title AS SaleTypeTitle,
	S.Title_En AS SaleTypeTitle_En,
	CI.[Version]
FROM [DST].[SaleTypeConstraintItem] CI
INNER JOIN SLS.SaleType S On CI.SaleTypeRef = S.SaleTypeID  
