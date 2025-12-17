If Object_ID('SLS.vwCommissionArea') Is Not Null
	Drop View SLS.vwCommissionArea
GO
CREATE VIEW SLS.vwCommissionArea
AS
SELECT CA.[CommissionAreaId]
	  ,CA.[CommissionRef]  
	  ,CA.[AreaRef]       
	  ,AP.Code
	  ,AP.Title
	  ,AP.Title_En
	
FROM SLS.CommissionArea CA
  INNER JOIN DST.AreaAndPath AP 
    ON AP.AreaAndPathId = CA.AreaRef