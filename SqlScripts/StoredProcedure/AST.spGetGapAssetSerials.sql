IF EXISTS (
       SELECT *
       FROM   sys.objects
       WHERE  TYPE         = 'P'
              AND NAME     = 'spGetGapAssetSerials'
   )
    DROP PROCEDURE AST.spGetGapAssetSerials
GO

CREATE PROCEDURE AST.spGetGapAssetSerials
	@ClassId INT
	 ,
	@GroupId INT
	 ,
	@Method INT
	,
	@PlatingBegining INT

AS
	DECLARE @maxSerial INT;
	
	DECLARE @tempTable TABLE
	        (PlaqueSerial INT)
	

	IF @Method = 0 -- ÿ»ﬁÂ
	BEGIN
	    SELECT @maxSerial = MAX(PlaqueSerial)
	    FROM   AST.Asset a
	           LEFT JOIN AST.AssetGroup g
	                ON  g.AssetGroupID = a.AssetGroupRef
	    WHERE  g.AssetClassRef = @ClassId;

		WITH tempTable
			AS
			   ( SELECT @PlatingBegining AS PlaqueSerial
				 
				 UNION ALL
				
				 SELECT PlaqueSerial +1 AS PlaqueSerial
				 FROM tempTable
				 WHERE tempTable.PlaqueSerial < @maxSerial
			   )
			   
		 SELECT t.PlaqueSerial AS gapSerial 
		 FROM tempTable t
		 WHERE NOT Exists(SELECT * 
						  FROM  AST.Asset a
						  LEFT JOIN AST.AssetGroup g ON  g.AssetGroupID = a.AssetGroupRef
						WHERE  g.AssetClassRef = @ClassId
						  And a.PlaqueSerial = t.PlaqueSerial )
		OPTION (MAXRECURSION 0)
	END	   
	
	IF @Method = 1 -- ê—ÊÂ
	BEGIN
	    SELECT @maxSerial = MAX(PlaqueSerial)
	    FROM   AST.Asset a
	    WHERE  a.AssetGroupRef = @GroupId;
		
		WITH tempTable
			AS
			   ( SELECT @PlatingBegining AS PlaqueSerial
				 
				 UNION ALL
				
				 SELECT PlaqueSerial +1 AS PlaqueSerial
				 FROM tempTable
				 WHERE tempTable.PlaqueSerial < @maxSerial
			   )
			   
		 SELECT t.PlaqueSerial AS gapSerial 
		 FROM tempTable t
		 WHERE NOT Exists(SELECT * 
						  FROM  AST.Asset a
						  WHERE a.PlaqueSerial = t.PlaqueSerial and a.AssetGroupRef = @GroupId )
		 option (maxrecursion 0);
	END	  
	
	IF @Method = 2 -- »œÊ‰ —Ê‘
	BEGIN
	    SELECT @maxSerial = MAX(PlaqueSerial)
	    FROM   AST.Asset a;
	    
		WITH tempTable
			AS
			   ( SELECT @PlatingBegining AS PlaqueSerial
				 
				 UNION ALL
				
				 SELECT PlaqueSerial +1 AS PlaqueSerial
				 FROM tempTable
				 WHERE tempTable.PlaqueSerial < @maxSerial
			   )
			   
		 SELECT t.PlaqueSerial AS gapSerial  
		 FROM tempTable t
		 WHERE NOT Exists(SELECT * 
						  FROM  AST.Asset a
						  WHERE a.PlaqueSerial = t.PlaqueSerial )
		option (maxrecursion 0);
						  
	END