If Object_ID('SLS.vwCommissionItem') Is Not Null
	Drop View SLS.vwCommissionItem
GO
CREATE VIEW SLS.vwCommissionItem
AS
SELECT CI.CommissionItemId,
	CI.CommissionRef,
	CI.ItemRef,
	I.Title ItemTitle,
	I.Title_En ItemTitle_En,
	I.Code ItemCode
FROM SLS.CommissionItem CI 
		INNER JOIN INV.Item I ON CI.ItemRef = I.ItemID
