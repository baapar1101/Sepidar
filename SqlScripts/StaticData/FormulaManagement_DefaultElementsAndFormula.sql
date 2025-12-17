IF NOT EXISTS (SELECT 1 FROM GNR.CalculationElement WHERE Title = 'قطر')
BEGIN
	INSERT INTO GNR.CalculationElement 
	SELECT ISNULL(MAX(CalculationElementID), 0) + 1, 'D', 'قطر', 'قطر', 1 FROM GNR.CalculationElement
END
GO

IF NOT EXISTS (SELECT 1 FROM GNR.CalculationElement WHERE Title = 'طول')
BEGIN
	INSERT INTO GNR.CalculationElement 
	SELECT ISNULL(MAX(CalculationElementID), 0) + 1, 'B', 'طول', 'طول', 1 FROM GNR.CalculationElement
END
GO

IF NOT EXISTS (SELECT 1 FROM GNR.CalculationElement WHERE Title = 'عرض')
BEGIN
	INSERT INTO GNR.CalculationElement 
	SELECT ISNULL(MAX(CalculationElementID), 0) + 1, 'A', 'عرض', 'عرض', 1 FROM GNR.CalculationElement
END
GO

IF NOT EXISTS (SELECT 1 FROM GNR.CalculationElement WHERE Title = 'تعداد')
BEGIN
	INSERT INTO GNR.CalculationElement 
	SELECT ISNULL(MAX(CalculationElementID), 0) + 1, 'C', 'تعداد', 'تعداد', 1 FROM GNR.CalculationElement
END
GO

IF NOT EXISTS(SELECT * FROM GNR.CalculationFormula WHERE CalculationFormulaID = -1)
BEGIN
	INSERT INTO GNR.CalculationFormula 
	SELECT -1, -1,
		(SELECT CAST(Symbol AS VARCHAR) FROM GNR.CalculationElement WHERE Title = 'عرض') + '*' + 
		(SELECT CAST(Symbol AS VARCHAR) FROM GNR.CalculationElement WHERE Title = 'طول') + '*' + 		 
		(SELECT CAST(Symbol AS VARCHAR) FROM GNR.CalculationElement WHERE Title = 'تعداد' ) + '*' + '(d/d)',
		1, GetDate(), 1, GetDate(), 1
END		 
		
IF NOT EXISTS(SELECT * FROM GNR.FormulaElement WHERE FormulaElementID = -1)
BEGIN
	INSERT INTO GNR.FormulaElement 
	SELECT -1,
		(SELECT CalculationFormulaID FROM GNR.CalculationFormula WHERE CalculationFormulaID = -1), 
		(SELECT CalculationElementID FROM GNR.CalculationElement WHERE Title = 'عرض')
END

IF NOT EXISTS(SELECT * FROM GNR.FormulaElement WHERE FormulaElementID = -2)
BEGIN
	INSERT INTO GNR.FormulaElement 
	SELECT -2,
		(SELECT CalculationFormulaID FROM GNR.CalculationFormula WHERE CalculationFormulaID = -1), 
		(SELECT CalculationElementID FROM GNR.CalculationElement WHERE Title = 'طول')
END		
		
IF NOT EXISTS(SELECT * FROM GNR.FormulaElement WHERE FormulaElementID = -3)
BEGIN
	INSERT INTO GNR.FormulaElement 
	SELECT -3,
		(SELECT CalculationFormulaID FROM GNR.CalculationFormula WHERE CalculationFormulaID = -1), 
		(SELECT CalculationElementID FROM GNR.CalculationElement WHERE Title = 'قطر')
END

IF NOT EXISTS(SELECT * FROM GNR.FormulaElement WHERE FormulaElementID = -4)
BEGIN
	INSERT INTO GNR.FormulaElement 
	SELECT -4,
		(SELECT CalculationFormulaID FROM GNR.CalculationFormula WHERE CalculationFormulaID = -1), 
		(SELECT CalculationElementID FROM GNR.CalculationElement WHERE Title = 'تعداد')
END

IF EXISTS (SELECT 1 FROM FMK.IDGeneration WHERE TableName = 'GNR.CalculationElement')	
	UPDATE FMK.IDGeneration SET LastId = (SELECT MAX(CalculationElementID) + 1 FROM GNR.CalculationElement) WHERE TableName = 'GNR.CalculationElement'
ELSE 
	INSERT INTO FMK.IDGeneration SELECT 'GNR.CalculationElement', MAX(CalculationElementID) + 1 FROM GNR.CalculationElement