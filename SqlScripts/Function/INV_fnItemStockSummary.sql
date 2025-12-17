
If Object_ID('INV.fnItemStockSummary') Is Not Null
	Drop Function INV.fnItemStockSummary
GO


  
  
-- =============================================  
CREATE FUNCTION [INV].[fnItemStockSummary](@StockRef int, @ItemRef int, @TracingRef int = NULL, @FiscalYearRef INT)  
RETURNS @Table_Variable_ItemStockSummary TABLE   
(  
  ItemStockSummaryType int,  
  [Order] INT,
  UnitRef int,  
  UnitTitle nvarchar(255),  
  UnitTitle_En nvarchar(255),
  ItemMinimumAmount INT,
  ItemMaximumAmount INT,
    
  TotalQuantity decimal(19, 4),  
  StockQuantity decimal(19, 4),  
  TracingQuantity decimal(19, 4),  
  StockTracingQuantity decimal(19, 4)  
)  
AS  
BEGIN  
	DECLARE @EndDate AS DATETIME
DECLARE @EstablishYearFiscalRef AS INT
SET @EstablishYearFiscalRef = CAST(ISNULL((SELECT TOP 1 c.Value FROM FMK.Configuration c WHERE c.[Key] = 'InventoryInstallFiscalYear'), '0') AS INT)
 SET @EndDate = (SELECT TOP 1 fy.EndDate
                      FROM FMK.FiscalYear fy WHERE fy.FiscalYearId =	@EstablishYearFiscalRef)
DECLARE     
  @Temp_ItemStockSummary TABLE   
  (  
   ItemStockSummaryType int,  
   [Order] INT,
   UnitRef int,  
   UnitTitle nvarchar(255),  
   UnitTitle_En nvarchar(255),  
   ItemMinimumAmount INT,
   ItemMaximumAmount INT,

   TotalQuantity decimal(19, 4),  
   StockQuantity decimal(19, 4),  
   TracingQuantity decimal(19, 4),  
   StockTracingQuantity decimal(19, 4),  
  
   TotalSaleQuantity decimal(19, 4),  
   StockSaleQuantity decimal(19, 4),  
   TracingSaleQuantity decimal(19, 4),  
   StockTracingSaleQuantity decimal(19, 4),  
   
   TotalSaleWithReserveQuantity decimal(19, 4),
   StockSaleWithReserveQuantity decimal(19, 4),
   TracingSaleWithReserveQuantity decimal(19, 4),
   StockTracingSaleWithReserveQuantity decimal(19, 4)   
  )  
DECLARE @UnitRef int,  
  @UnitTitle varchar(255),  
  @UnitTitle_En varchar(255),  
    
  @TotalQuantity decimal(19, 4),  
  @StockQuantity decimal(19, 4),  
  @TracingQuantity decimal(19, 4),  
  @StockTracingQuantity decimal(19, 4),  
    
  @TotalSaleQuantity decimal(19, 4),  
  @StockSaleQuantity decimal(19, 4),  
  @TracingSaleQuantity decimal(19, 4),  
  @StockTracingSaleQuantity decimal(19, 4),
  
  @TotalSaleWithReserveQuantity decimal(19, 4),
  @StockSaleWithReserveQuantity decimal(19, 4),
  @TracingSaleWithReserveQuantity decimal(19, 4),
  @StockTracingSaleWithReserveQuantity decimal(19, 4)
    
  
 INSERT INTO @Temp_ItemStockSummary      
 SELECT   
  SS.ItemRef ,  
  [Order],
  SS.UnitRef ,   
  U.Title,  
  U.Title_En,  
  I.MinimumAmount ,
  I.MaximumAmount ,
  
--  -- Net  
  SUM(Quantity) TotalQuantity,    
  SUM(CASE WHEN StockRef = @StockRef THEN Quantity ELSE 0 END) StockQuantity,   
  SUM(CASE WHEN ISNULL(TracingRef,0) = ISNULL(@TracingRef,0) THEN Quantity ELSE 0 END) TracingQuantity,   
  SUM(CASE WHEN ISNULL(TracingRef,0) = ISNULL(@TracingRef,0) AND StockRef = @StockRef THEN Quantity ELSE 0 END) StockTracingQuantity,  
  --sale  
  SUM(SaleQuantity) TotalSaleQuantity,    
  SUM(CASE WHEN StockRef = @StockRef THEN SaleQuantity ELSE 0 END) StockSaleQuantity,   
  SUM(CASE WHEN ISNULL(TracingRef,0) = ISNULL(@TracingRef,0) THEN SaleQuantity ELSE 0 END) TracingSaleQuantity,   
  SUM(CASE WHEN ISNULL(TracingRef,0) = ISNULL(@TracingRef,0) AND StockRef = @StockRef THEN SaleQuantity ELSE 0 END) StockTracingSaleQuantity,
  --SaleWithReserve  
  SUM(SaleWithReserveQuantity) TotalSaleWithReserveQuantity,
  SUM(CASE WHEN StockRef = @StockRef THEN SaleWithReserveQuantity ELSE 0 END) StockSaleWithReserveQuantity,   
  SUM(CASE WHEN ISNULL(TracingRef,0) = ISNULL(@TracingRef,0) THEN SaleWithReserveQuantity ELSE 0 END) TracingSaleWithReserveQuantity,   
  SUM(CASE WHEN ISNULL(TracingRef,0) = ISNULL(@TracingRef,0) AND StockRef = @StockRef THEN SaleWithReserveQuantity ELSE 0 END) StockTracingSaleWithReserveQuantity 
 FROM   
  INV.Unit U   
  LEFT JOIN INV.ItemStockSummary SS ON UnitID = UnitRef  AND EXISTS (SELECT 1
                                                                FROM FMK.FiscalYear fy2 WHERE fy2.FiscalYearId = SS.FiscalYearRef AND (Fy2.StartDate > @EndDate OR Fy2.FiscalYearId = @EstablishYearFiscalRef))
  JOIN INV.Stock S ON StockID = StockRef  
  LEFT JOIN INV.Item I ON I.ItemID=@ItemRef AND I.UnitRef=SS.UnitRef
  LEFT JOIN INV.Tracing T ON TracingID = TracingRef  
 WHERE SS.FiscalYearRef=@FiscalYearRef
 GROUP BY SS.ItemRef , SS.UnitRef , U.Title, U.Title_En ,I.MinimumAmount,I.MaximumAmount , [Order]
 HAVING ItemRef = @ItemRef  
union  
select @itemref , 1, UnitRef, inv.unit.Title, inv.unit.Title_en ,MinimumAmount, MaximumAmount, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
 from inv.item   
 join inv.unit on unitref = unitid  
where itemid = @itemref and itemid not in (select itemref from INV.ItemStockSummary)  
union  
select @itemref , 2, SecondaryUnitRef, inv.unit.Title, inv.unit.Title_en  , NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
 from inv.item   
 join inv.unit on Secondaryunitref = unitid  
where itemid = @itemref and itemid not in (select itemref from INV.ItemStockSummary iss WHERE EXISTS (SELECT 1
                                                                FROM FMK.FiscalYear fy3 WHERE fy3.FiscalYearId = iss.FiscalYearRef AND (Fy3.StartDate > @EndDate OR Fy3.FiscalYearId = @EstablishYearFiscalRef)))  
  
     
 INSERT INTO @Table_Variable_ItemStockSummary  
 SELECT   
  1 ItemStockSummaryType,  
  [Order],
  UnitRef ,   
  UnitTitle,  
  UnitTitle_En,  
  ItemMinimumAmount,
  ItemMaximumAmount,
  TotalQuantity,    
  StockQuantity,   
  TracingQuantity,   
  StockTracingQuantity  
 FROM @Temp_ItemStockSummary  
 UNION   
  SELECT   
  2 ,  
  [Order],
  UnitRef ,   
  UnitTitle,  
  UnitTitle_En,  
  ItemMinimumAmount,
  ItemMaximumAmount,
  TotalQuantity - TotalSaleQuantity,    
  StockQuantity - StockSaleQuantity,   
  TracingQuantity - TracingSaleQuantity,   
  StockTracingQuantity - StockTracingSaleQuantity  
 FROM @Temp_ItemStockSummary  
  UNION 
  SELECT   
  3 ,  
  [Order],
  UnitRef ,   
  UnitTitle,  
  UnitTitle_En,  
  ItemMinimumAmount,
  ItemMaximumAmount,
  TotalQuantity - TotalSaleQuantity - TotalSaleWithReserveQuantity, 
  StockQuantity - StockSaleQuantity - StockSaleWithReserveQuantity,
  TracingQuantity - TracingSaleQuantity - TracingSaleWithReserveQuantity,
  StockTracingQuantity - StockTracingSaleQuantity - StockTracingSaleWithReserveQuantity
 FROM @Temp_ItemStockSummary  
 ORDER BY 1,2, 3
RETURN  
end
GO