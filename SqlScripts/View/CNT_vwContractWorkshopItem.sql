If Object_ID('CNT.vwContractWorkshopItem') Is Not Null
	Drop View CNT.vwContractWorkshopItem
GO
CREATE VIEW CNT.vwContractWorkshopItem
AS
SELECT     CW.ContractWorkshopItemID, CW.RowNumber, CW.ContractRef, CW.WorkshopRef, CW.Description, CW.Description_En, W.Code AS WorkshopCode, 
                      W.Title AS WorkshopTitle, W.Title_En AS WorkshopTitle_En, C.Date AS ContractDate, C.Title AS ContractTitle, 
                      ACC.DL.Title AS SupervisorDlTitle, ACC.DL.Title_En AS SupervisorDlTitle_En
FROM         CNT.Contract AS C INNER JOIN
                      CNT.ContractWorkshopItem AS CW ON C.ContractID = CW.ContractRef INNER JOIN
                      CNT.Workshop AS W ON CW.WorkshopRef = W.WorkshopID INNER JOIN
                      GNR.Party ON W.SupervisorRef = GNR.Party.PartyId INNER JOIN
                      ACC.DL ON GNR.Party.DLRef = ACC.DL.DLId AND GNR.Party.DLRef = ACC.DL.DLId AND GNR.Party.DLRef = ACC.DL.DLId

