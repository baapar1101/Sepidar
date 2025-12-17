UPDATE SLS.SaleType SET SaleTypeMarket = 1 
WHERE SaleTypeMarket IS NULL

alter table SLS.SaleType alter column SaleTypeMarket int NOT NULL 
