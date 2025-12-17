if not exists (select top 1 1  from fmk.Configuration where [key] like '%ParentChildInGrouping%')
begin
	begin	
	 if exists (select top 1 1  from gnr.Grouping )
		exec [FMK].[spSetConfiguration] 'ParentChildInGrouping','False';
	 else 
		exec [FMK].[spSetConfiguration] 'ParentChildInGrouping','True';
	end
end
GO

if exists  (SELECT TOP  1 1 FROM GNR.Grouping WHERE FullCode='' ) 
BEGIN
if  exists (SELECT top 1 1  FROM fmk.Configuration where [key] like '%ParentChildInGrouping%')
BEGIN
	if(( SELECT top 1 Value  FROM fmk.Configuration where [key] like '%ParentChildInGrouping%')='True')
	BEGIN
	declare @sql nvarchar(MAX)='
		;
	with BaseGrouping
	As
	(
	SELECT
		G.GroupingID, G.EntityType, G.Code, G.Title, G.Title_En, G.Version,
		G.Creator, G.CreationDate, G.LastModifier, G.LastModificationDate,
		G.CalculationFormulaRef, F.Code AS FormulaCode, F.Text AS FormulaText,
		G.ParentGroupRef AS ParentGroupRef, G2.Code AS ParentGroupCode, G2.Title AS ParentGroupTitle, G2.Title_En AS ParentGroupTitle_En,
		0 AS GroupImageIndex, G.MaximumCredit, G.HasCredit, G.CreditCheckingType
	FROM
		GNR.Grouping AS G LEFT OUTER JOIN
		GNR.CalculationFormula AS F ON G.CalculationFormulaRef = F.CalculationFormulaID LEFT OUTER JOIN
		GNR.Grouping AS G2 ON G.ParentGroupRef = G2.GroupingID
	)
	,cte_Grouping AS (
		SELECT
		   [GroupingID]
		  ,[EntityType]
		  ,Code
		  ,cast(Code as varchar) AS FullCode 
		  ,[Title]
		  ,[Title_En]
		  ,[Version]
		  ,[Creator]
		  ,[CreationDate]
		  ,[LastModifier]
		  ,[LastModificationDate]
		  ,[CalculationFormulaRef]
		  ,[FormulaCode]
		  ,[FormulaText]
		  ,[ParentGroupRef]
		  ,[ParentGroupCode]
		  ,[ParentGroupTitle]
		  ,[ParentGroupTitle_En]
		  ,[GroupImageIndex]
		  ,[MaximumCredit]
		  ,[HasCredit]
		  ,[CreditCheckingType]
			FROM       
			BaseGrouping
		WHERE [ParentGroupRef] IS  NULL

		UNION ALL

		SELECT 
		   e.[GroupingID]
		  ,e.[EntityType]
		  ,e.code
		  ,
	  
			CAST (CAST(o.FullCode AS VARCHAR)+CAST(e.Code AS VARCHAR) AS VARCHAR)

			AS FullCode
		  ,e.[Title]
		  ,e.[Title_En]
		  ,e.[Version]
		  ,e.[Creator]
		  ,e.[CreationDate]
		  ,e.[LastModifier]
		  ,e.[LastModificationDate]
		  ,e.[CalculationFormulaRef]
		  ,e.[FormulaCode]
		  ,e.[FormulaText]
		  ,e.[ParentGroupRef]
		  ,e.[ParentGroupCode]
		  ,e.[ParentGroupTitle]
		  ,e.[ParentGroupTitle_En]
		  ,e.[GroupImageIndex]
		  ,e.[MaximumCredit]
		  ,e.[HasCredit]
		  ,e.[CreditCheckingType]

		FROM 
			BaseGrouping e
			INNER JOIN cte_Grouping o 
				ON e.ParentGroupRef= o.GroupingID)


		 UPDATE  g
		 SET g.fullCode=ISNULL
						((SELECT FullCode FROM cte_Grouping g2 where g2.GroupingID=g.ParentGroupRef),'''')
						+g.Code
		 FROM gnr.Grouping as g
		'
		EXEC sp_executesql @sql
END

	ELSE
BEGIN
	EXEC sp_executesql N'UPDATE gnr.Grouping 
					     SET fullCode=Code'					
END

END
END
GO

