If Object_ID('POS.vwCashier') Is Not Null
	Drop View POS.vwCashier
GO
CREATE VIEW POS.vwCashier
AS
SELECT     C.CashierID, C.Title, C.PartyRef, P.DLRef PartyDLRef, P.FullName AS PartyFullName, P.DLTitle AS PartyDLTitle, P.DLCode AS PartyDLCode, P.CustomerGroupingRef,P.CustomerGroupingTitle,
                      U.Name AS UserName, C.UserRef, C.IsActive, C.CanChangeDiscount, C.CanReceiveCash, C.CanReceiveCheque, C.CanReceivePos, 
                      C.CanReceiveOther, C.Version, C.Creator, C.CreationDate, C.LastModifier, C.LastModificationDate
FROM         POS.Cashier AS C INNER JOIN
                      FMK.[User] AS U ON C.UserRef = U.UserID AND C.UserRef = U.UserID INNER JOIN
                      GNR.vwParty P ON C.PartyRef = P.PartyId
