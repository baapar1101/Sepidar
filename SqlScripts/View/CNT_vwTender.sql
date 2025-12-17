If Object_ID('CNT.vwTender') Is Not Null
	Drop View CNT.vwTender
GO
CREATE VIEW CNT.vwTender
AS
SELECT        T.TenderID, T.Date, T.Title, T.Title_En, T.TenderPartyRef, PD.Code AS TenderDLCode, PD.Title AS TenderDLTitle, PD.Title_En AS TenderDLTitle_En, PD.DLId AS TenderDLRef, P.Name + ' ' + P.LastName AS TenderFullName, 
			  T.StartDate, T.EndDate, T.DLRef, D.Code AS DLCode, D.Title AS DLTitle, D.Title_En AS DLTitle_En, 
			  T.Description, T.Description_En, T.DocumentNumber, T.IsActive, T.Version, T.Creator, T.CreationDate, T.LastModifier, T.LastModificationDate, 
              T.FiscalYearRef, cnt.DocumentNumber ContractNumber , cnt.title ContractTitle , cnt.Title_En  ContractTitle_En
FROM            CNT.Tender AS T
               INNER JOIN           ACC.DL AS D ON D.DLId = T.DLRef 
             INNER JOIN            GNR.Party AS P ON T.TenderPartyRef = P.PartyId 
			INNER JOIN ACC.DL AS PD ON P.DLRef = PD.DLId 
			Left outer join cnt.vwcontract cnt on T.TenderID = cnt.TenderRef


					 