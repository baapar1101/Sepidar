IF Object_ID('SLS.fnGetInvoiceRemainingAmount') IS NOT NULL
	DROP FUNCTION SLS.fnGetInvoiceRemainingAmount
GO

CREATE FUNCTION SLS.fnGetInvoiceRemainingAmount (@InvoiceID INT)
RETURNS decimal(19, 4) AS 
BEGIN
	DECLARE @RemainingAmount decimal(19, 4)
	SELECT @RemainingAmount = RemainingAmount
	FROM SLS.fnInvoiceRemaining()
	    WHERE InvoiceID = @InvoiceID		  

	RETURN @RemainingAmount
END
GO