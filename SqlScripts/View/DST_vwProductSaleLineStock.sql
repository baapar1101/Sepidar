--<<FileName:DST_vwProductSaleLineStock.sql>>--

IF OBJECT_ID('DST.vwProductSaleLineStock') IS NOT NULL
	DROP VIEW DST.vwProductSaleLineStock
GO

CREATE VIEW DST.vwProductSaleLineStock
AS

SELECT
	[PSLS].[ProductSaleLineStockId]
   ,[PSLS].[ProductSaleLineRef]
   ,[PSLS].[StockRef]
   ,[S].[Code] AS [StockCode]
   ,[S].[Title] AS [StockTitle]
   ,[S].[Title_En] AS [StockTitle_En]
FROM [DST].[ProductSaleLineStock] AS [PSLS]
JOIN [INV].[Stock] AS [S]
	ON [PSLS].[StockRef] = [S].[StockID]