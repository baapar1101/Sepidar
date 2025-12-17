If Object_ID('CNT.vwSettlement') Is Not Null
	Drop View CNT.vwSettlement
GO
CREATE VIEW CNT.vwSettlement
AS
SELECT     S.SettlementID, S.ContractRef, S.Date, S.Type, S.PaymentRef, S.PartyRef, S.Version, 
				  S.Creator, S.CreationDate, S.LastModifier, S.LastModificationDate, S.Number, S.ReceiptRef, S.FiscalYearRef,
				  D.Code AS ContractDLCode, C.Title AS ContractTitle, C.Title_En AS ContractTitle_En, 
                      C.ContractorPartyRef, CP.Name AS ContractorName, CP.LastName AS ContractorLastName,
                      CP.DLRef AS ContractorDLRef, CD.Title AS ContractorDlTitle,
                      RH.Number AS ReceiptNumber, RH.Date AS ReceiptDate,
                      P.Number AS PaymentNumber, P.Date AS PaymentDate, PA.DLRef AS PartyDLRef,
                      PA.FullName AS PartyFullname, PA.DLCode AS PartyDLCode, S.Description_En, S.Description
FROM				  CNT.Settlement AS S INNER JOIN
				  CNT.Contract AS C ON C.ContractID = S.ContractRef  INNER JOIN
				  ACC.DL AS D ON D.DLId = C.DLRef INNER JOIN
                      GNR.Party AS CP ON C.ContractorPartyRef = CP.PartyId INNER JOIN
                      ACC.DL AS CD ON CP.DLRef = CD.DLId LEFT OUTER JOIN
                      RPA.ReceiptHeader AS RH ON S.ReceiptRef = RH.ReceiptHeaderId LEFT OUTER JOIN
                      RPA.PaymentHeader P ON S.PaymentRef = P.PaymentHeaderId LEFT OUTER JOIN
                      GNR.vwParty PA ON PA.PartyId = S.PartyRef