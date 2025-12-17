IF OBJECT_ID('FMK.StringSplit') IS NOT NULL
	DROP FUNCTION [FMK].StringSplit
GO
CREATE FUNCTION [FMK].StringSplit(@String  VARCHAR(MAX), @RemoveEmptyItems bit)
	RETURNS @RESULT TABLE(GeneratedValueEEE VARCHAR(MAX))
AS
BEGIN     
	--DECLARE @xml xml SET @xml = '<root><row>' + REPLACE(@String ,@Separator , '</row><row>') + '</row></root>'
	--SELECT x.y.GeneratedValueEEE('.', 'VARCHAR(MAX)') GeneratedValueEEE FROM @xml.nodes('//*[text()]') AS x(y)

    DECLARE @Separator VARCHAR(1) , @SeparatorEscape VARCHAR(10)
    
	SET @RemoveEmptyItems = ISNULL(@RemoveEmptyItems, 1)  /*TODO*/

	IF @String = null OR LEN(@String) = 0
	BEGIN	    
		IF @RemoveEmptyItems = 0
			INSERT INTO @RESULT VALUES(REPLACE(@String, @SeparatorEscape , @Separator))
		RETURN
	END

	SELECT  @Separator = ',' , @SeparatorEscape = '&comma&'
	DECLARE @SeparatorPosition INT = CHARINDEX(@Separator, @String), @Value VARCHAR(MAX), @StartPosition INT = 1

	IF @SeparatorPosition = 0  
	BEGIN
		IF @RemoveEmptyItems = 0 OR @String <> ''
		   INSERT INTO @RESULT VALUES(REPLACE(@String, @SeparatorEscape , @Separator))
		RETURN
	END

	SET @String = @String + @Separator
	WHILE @SeparatorPosition > 0
	BEGIN
		SET @Value = SUBSTRING(@String , @StartPosition, @SeparatorPosition - @StartPosition)

		IF @RemoveEmptyItems = 0 OR @Value <> ''
		BEGIN
			INSERT INTO @RESULT VALUES(REPLACE(@Value, @SeparatorEscape , @Separator))
		END

		SET @StartPosition = @SeparatorPosition + 1
		SET @SeparatorPosition = CHARINDEX(@Separator, @String , @StartPosition)
	END      
	RETURN
END
GO
