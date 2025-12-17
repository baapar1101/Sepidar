If Object_ID('SLS.vwCommissionBroker') Is Not Null
	Drop View SLS.vwCommissionBroker
GO
CREATE VIEW SLS.vwCommissionBroker
AS
SELECT CB.CommissionBrokerId,
	CB.CommissionRef,
	CB.PartyRef,
	P.DLTitle PartyDLTitle,
	P.DLTitle_En PartyDLTitle_En,
	P.DLRef PartyDLRef,
	P.DLCode PartyDLCode
FROM SLS.CommissionBroker CB
	INNER JOIN GNR.vwParty P ON CB.PartyRef = P.PartyId