IF Object_ID('DST.vwSalesLimit') IS NOT NULL
	DROP VIEW DST.vwSalesLimit
GO

CREATE VIEW DST.vwSalesLimit
AS
SELECT 
	   SL.[SalesLimitId]
	  ,SL.[FiscalYearRef]
      ,SL.[Code]
      ,SL.[Title]
      ,SL.[Title_En]
      ,SL.[ControlType]
      ,SL.[StartDate]
      ,SL.[EndDate]
      ,SL.[IsActive]
      ,SL.[Version]
      ,SL.[Creator]
      ,SL.[CreationDate]
      ,SL.[LastModifier]
      ,SL.[LastModificationDate]
	  ,CU.Name CreatorName
      ,MU.Name LastModifierName
   FROM [DST].[SalesLimit] SL
   INNER JOIN FMk.[User] CU ON SL.Creator = CU.UserID
   INNER JOIN FMk.[User] MU ON SL.LastModifier = MU.UserID
