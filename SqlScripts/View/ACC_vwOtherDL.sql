If Object_ID('ACC.vwOtherDL') Is Not Null
	Drop View ACC.vwOtherDL
GO
/*Other */
CREATE VIEW ACC.vwOtherDL
AS
SELECT     DLId, Code, Title, Title_En, Type, IsActive, Version, Creator, CreationDate, LastModifier, LastModificationDate
FROM         ACC.DL
WHERE     (Type = 1)

