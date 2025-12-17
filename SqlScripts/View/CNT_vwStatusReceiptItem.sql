If Object_ID('CNT.vwStatusReceiptItem') Is Not Null
	Drop View CNT.vwStatusReceiptItem
GO
CREATE VIEW CNT.vwStatusReceiptItem
AS
SELECT     SRI.StatusReceiptItemID, SRI.RowNumber, SRI.StatusRef, SRI.Type, SRI.Fee, SRI.ReceiptRef, S.Date AS StatusDate, S.Number AS StatusNumber, S.ContractRef, 
                      R.Number AS ReceiptNumber, R.Date AS ReceiptDate, P.DLRef AS ContractorDlRef, C.ContractorPartyRef,
                      CASE 
						WHEN SRI.Type = 1 OR SRI.Type = 2 THEN 0
						WHEN SRI.Type = 3 THEN 1
                      END AS Remained 
                      
FROM         CNT.StatusReceiptItem AS SRI INNER JOIN
                      CNT.Status AS S ON SRI.StatusRef = S.StatusID INNER JOIN
                      CNT.Contract AS C ON S.ContractRef = C.ContractID AND S.ContractRef = C.ContractID INNER JOIN
                      GNR.Party AS P ON C.ContractorPartyRef = P.PartyId AND C.ContractorPartyRef = P.PartyId LEFT OUTER JOIN
                      RPA.ReceiptHeader AS R ON SRI.ReceiptRef = R.ReceiptHeaderId


