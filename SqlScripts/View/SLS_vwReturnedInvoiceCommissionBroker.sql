IF OBJECT_ID('SLS.vwReturnedInvoiceCommissionBroker') IS NOT NULL
    DROP VIEW SLS.vwReturnedInvoiceCommissionBroker
GO
CREATE VIEW SLS.vwReturnedInvoiceCommissionBroker
AS

SELECT RICB.ReturnedInvoiceCommissionBrokerID,
       RICB.ReturnedInvoiceRef,
       RICB.PartyRef,
       p.DLTitle     AS PartyDLTitle,
       p.DLTitle_En  AS PartyDLTitle_En,
       p.DLRef       AS PartyDLRef,
       p.DLCode      AS PartyDLCode,
       p.BrokerGroupingRef,
       p.BrokerGroupingCode,
       p.BrokerGroupingTitle,
       p.BrokerGroupingTitle_En,
       RICB.SalePortionPercent,
	   RICB.ManualCommissionAmount
FROM   SLS.ReturnedInvoiceCommissionBroker RICB
       INNER JOIN GNR.vwParty p
            ON  RICB.PartyRef = p.PartyId