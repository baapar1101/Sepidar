If Object_ID('GNR.vwBill') Is Not Null
	Drop View GNR.vwBill
GO
CREATE VIEW GNR.vwBill
AS
SELECT     B.BillID, B.Type, B.PartyRef, P.DLRef AS PartyDLRef, B.Number, B.Date, B.LastRemainder, B.NewRemainder, B.RPARemainder,   
                      B.ReturnedRemainder, B.EnteryRemainder, B.OtherRemainder, P.DLTitle AS PartyDLTitle, P.DLTitle_En AS PartyDLTitle_En, P.DLCode AS PartyDLCode, B.Version, B.Creator,   
                      B.CreationDate, B.LastModifier, B.LastModificationDate, B.FiscalYearRef,  
       ISNULL((Select Top 1 Number from  GNR.Bill AS B2 where B.PartyRef = B2.PartyRef AND B.Date >= B2.Date AND B.Number > B2.Number ORDER BY B2.Date Desc), 0) LastBillNumber,  
       ISNULL((Select Top 1 Date from  GNR.Bill AS B2 where B.PartyRef = B2.PartyRef AND B.Date >= B2.Date AND B.Number > B2.Number ORDER BY B2.Date Desc), (SELECT TOP 1 StartDate FROM FMK.FiscalYear WHERE FiscalYearId = B.FiscalYearRef)) LastBillDate  
FROM         GNR.Bill AS B INNER JOIN  
                      GNR.vwParty AS P ON B.PartyRef = P.PartyId