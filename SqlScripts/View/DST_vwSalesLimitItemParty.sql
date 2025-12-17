If Object_ID('DST.vwSalesLimitItemParty') Is Not Null
	Drop View DST.vwSalesLimitItemParty
GO

CREATE view DST.vwSalesLimitItemParty as 
	SELECT [SalesLimitItemPartyId]
		  ,[SalesLimitItemRef]
		  ,[PartyRef],  p.DLCode, p.FullName,	p.DLTitle,	p.DLTitle_En
		  , Quantity
		  ,SecondaryQuantity
		  , I.UnitRef, U1.Title AS UnitTitle, U1.Title_En AS UnitTitle_En, I.SecondaryUnitRef, U2.Title AS SecondaryUnitTitle
          , U2.Title_En AS SecondaryUnitTitle_En,  I.IsUnitRatioConstant, I.UnitsRatio
	  FROM [DST].[SalesLimitItemParty] SLP
		INNER JOIN  [DST].[SalesLimitItem]  SLI ON SLP.SalesLimitItemRef = SLI.SalesLimitItemID
		INNER JOIN Inv.Item I On SLI.ItemRef = I.ItemID  
		INNER JOIN GNR.vwParty p ON	 SLP.PartyRef =	p.PartyId	
		LEFT OUTER JOIN  INV.Unit AS U1 ON I.UnitRef = U1.UnitID 
		LEFT OUTER JOIN  INV.Unit AS U2 ON I.SecondaryUnitRef = U2.UnitID  
				