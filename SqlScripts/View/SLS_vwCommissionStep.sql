If Object_ID('SLS.vwCommissionStep') Is Not Null
	Drop View SLS.vwCommissionStep
GO
CREATE VIEW SLS.vwCommissionStep
AS
SELECT CS.CommissionStepId,
	CS.CommissionRef,
	CS.FromValue,
	CS.ToValue,
	CS.Amount
FROM SLS.CommissionStep CS