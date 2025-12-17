IF EXISTS (
       SELECT *
       FROM   sys.objects
       WHERE  TYPE         = 'P'
              AND NAME     = 'spGetFixedAssetMaxCode'
   )
    DROP PROCEDURE AST.spGetFixedAssetMaxCode

GO

CREATE PROCEDURE AST.spGetFixedAssetMaxCode
	@ClassId	INT
	,@GroupId	INT
	,@Method	INT
	,@Length	INT

AS
BEGIN
	DECLARE @MaxSerial INT
	
	IF @Method = 0 -- ÿ»ﬁÂ
	BEGIN
	SET @MaxSerial = (SELECT Max(PlaqueSerial) MaxSerial
					    FROM   AST.ASSET a
					   LEFT JOIN AST.AssetGroup g ON g.AssetGroupID = a.AssetGroupRef
					   WHERE g.AssetClassRef = @ClassId)
	       
	END
	
		IF @Method = 1 -- ê—ÊÂ
	BEGIN
	SET @MaxSerial = (SELECT Max(PlaqueSerial) MaxSerial
	           FROM   AST.ASSET a
	           WHERE @GroupId = a.AssetGroupRef)
	END
	
	IF @Method = 2 -- »œÊ‰ —Ê‘
	BEGIN
	SET @MaxSerial = ( SELECT Max(PlaqueSerial) MaxSerial
							FROM   AST.ASSET a)
	END

	SELECT ISNULL(@MaxSerial, 0) AS PlaqueSerial
END
GO
