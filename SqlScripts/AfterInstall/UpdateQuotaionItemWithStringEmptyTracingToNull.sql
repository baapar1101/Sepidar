
IF EXISTS (SELECT 1 FROM INV.Tracing WHERE Title = '')
BEGIN

	DECLARE @TracingID int = (SELECT TracingID FROM INV.Tracing WHERE Title = '')

	UPDATE SLS.QuotationItem
	SET TracingRef = null
	WHERE TracingRef = @TracingID
	
END
