IF Object_ID('SLS.vwItemAdditionFactorInfo') IS NOT NULL
	DROP VIEW SLS.vwItemAdditionFactorInfo
GO

CREATE VIEW SLS.vwItemAdditionFactorInfo AS
SELECT  
	RowID = ROW_NUMBER() OVER (ORDER BY AdditionFactorItemID), 
	
	AF.AdditionFactorID, AF.CustomerGroupingRef, AF.CurrencyRef, AF.SaleVolumeType, AF.Basis,
	AF.StartDate, AF.EndDate, AF.IsActive, AF.Number, AF.Title, AF.IsEffectiveOnVat,

	AF.SaleTypeRef, ST.Title AS SaleTypeTitle, 

	0 AS AppliedPrice, -- It is here intentionally. Just to prevent column not found errors.

	AFI.AdditionFactorItemID, AFI.FromValue, AFI.ToValue, AFI.AdditionType, AFI.Amount, 
	
	IAF.ItemRef, IAF.TracingRef, 
	I.IsActive AS ItemIsActive, I.Sellable AS ItemSellable

FROM 
	SLS.AdditionFactor AF		
	INNER JOIN SLS.AdditionFactorItem AFI ON AF.AdditionFactorID = AFI.AdditionFactorRef
	LEFT JOIN SLS.ItemAdditionFactor IAF ON IAF.AdditionFactorRef = AF.AdditionFactorID 
	LEFT JOIN INV.Item I ON I.ItemID = IAF.ItemRef
	LEFT JOIN SLS.SaleType ST ON AF.SaleTypeRef = ST.SaleTypeID
