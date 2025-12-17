If Object_ID('CNT.vwWorkshop') Is Not Null
	Drop View CNT.vwWorkshop
GO
CREATE VIEW CNT.vwWorkshop
AS
SELECT     W.WorkshopID, W.Code, W.Title, W.Title_En, W.SupervisorRef, W.Description, W.Description_En, W.LastModifier, W.CreationDate, W.Creator, W.Version, 
                      ACC.DL.Code AS SupervisorDLCode, ACC.DL.Title AS SupervisorTitle, ACC.DL.Title_En AS SupervisorTitle_En, W.LastModificationDate
FROM         CNT.Workshop AS W INNER JOIN
                      GNR.Party AS P ON W.SupervisorRef = P.PartyId INNER JOIN
                      ACC.DL ON P.DLRef = ACC.DL.DLId

