If Object_ID('FMK.fn_GetLookupTitle') Is Not Null
	Drop Function FMK.fn_GetLookupTitle
GO

If Object_ID('FMK.fnGetLookupTitle') Is Not Null
	Drop Function FMK.fnGetLookupTitle
GO

CREATE FUNCTION FMK.fnGetLookupTitle
(
	@Type nvarchar(100), @Code int
)
RETURNS nvarchar(200)
AS
BEGIN
	RETURN 
	(SELECT Top 1 Title FROM FMK.lookup Where type = @type and Code = @Code)
END




