IF EXISTS (
		SELECT OBJECT_ID FROM sys.objects O WHERE   O.name LIKE 'vwUseable' 
												  AND O.schema_id = (
																	SELECT schema_id FROM sys.schemas sch WHERE sch.name LIKE 'AST'))
DROP VIEW AST.vwUseable
GO

CREATE VIEW AST.vwUseable
AS(
	SELECT  
		 o.[UseableId]
		,o.[Number]
		,o.[Date]
		,o.[Description]
		,o.[Description_En]
		,o.[FiscalYearRef]
		,o.[Version]
		,o.[Creator]
		,o.[CreationDate]
		,o.[LastModifier]
		,o.[LastModificationDate]
		,u.Name AS CreatorName
		,u.Name_En AS CreatorName_En
	FROM AST.Useable o
	LEFT JOIN FMK.[User] u ON u.UserID = o.Creator
	 
  )
   