IF Object_ID('SLS.fnGetCommissionCalculationRemainingAmount') IS NOT NULL
	DROP FUNCTION SLS.fnGetCommissionCalculationRemainingAmount
GO

CREATE FUNCTION SLS.fnGetCommissionCalculationRemainingAmount (@CommissionCalculationID INT)
RETURNS decimal(19, 4) AS 
BEGIN
	DECLARE @RemainingAmount decimal(19, 4)
	SELECT @RemainingAmount = RemainingAmount
	FROM SLS.fnCommissionCalculationRemaining()
	    WHERE CommissionCalculationID = @CommissionCalculationID		  

	RETURN @RemainingAmount
END
GO