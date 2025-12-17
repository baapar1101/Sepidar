IF Object_ID('SLS.fnGetFormulaElementValue') IS NOT NULL
	DROP FUNCTION [SLS].[fnGetFormulaElementValue]
GO

CREATE FUNCTION [SLS].[fnGetFormulaElementValue] (@elementID INT, @s VARCHAR(512))
RETURNS  INT
AS
BEGIN
	DECLARE @result INT
	DECLARE @startIdx INT, @endIdx INT
	SET @startIdx = CHARINDEX(CAST(@elementID AS VARCHAR(100))+ '=', @s) + LEN( CAST(@elementID AS VARCHAR(100))+ '=')
	SET @endIdx = CHARINDEX(',' , @s, @startIdx)
	IF ( @endIdx = 0)
	  SET @endIdx = LEN(@s)+ 1
	SET @result = CAST(SUBSTRING(@s, @startIdx, @endIdx- @startIdx) AS INT)
	RETURN @result
END
GO
