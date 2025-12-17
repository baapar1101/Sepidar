If Object_ID('CNT.vwProject') Is Not Null
	Drop View CNT.vwProject
GO
CREATE VIEW CNT.vwProject
AS
SELECT     	P.ProjectID, P.Code, P.Title, P.Title_En, P.[Version], P.Creator, P.CreationDate, P.LastModifier, P.LastModificationDate
FROM       CNT.Project P