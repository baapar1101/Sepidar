If Object_ID('SLS.vwQuotationCommissionBroker') Is Not Null
	Drop View SLS.vwQuotationCommissionBroker
GO
CREATE VIEW SLS.vwQuotationCommissionBroker
AS
SELECT  
		 QCB.QuotationCommissionBrokerID
		,QCB.QuotationRef
		,QCB.PartyRef
		,P.DLTitle AS PartyDLTitle
		,P.DLTitle_En AS PartyDLTitle_En
		,P.DLRef AS PartyDLRef
		,p.DLCode AS PartyDLCode
		,QCB.SalePortionPercent  
FROM  SLS.QuotationCommissionBroker QCB
	 INNER JOIN	 GNR.vwParty P 
	 ON QCB.PartyRef = P.PartyId