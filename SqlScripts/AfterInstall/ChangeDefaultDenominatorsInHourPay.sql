
IF NOT EXISTS (SELECT 1 FROM PAY.Calculation)
BEGIN

	UPDATE PAY.Element
	SET Denominators = 220
	WHERE ElementId = 98 AND Denominators = 1	
	
END