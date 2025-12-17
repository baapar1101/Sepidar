
IF OBJECT_ID('SLS.vwInvoiceCommissionBroker') IS NOT NULL
    DROP VIEW SLS.vwInvoiceCommissionBroker
GO
CREATE VIEW SLS.vwInvoiceCommissionBroker
AS

SELECT ICB.InvoiceCommissionBrokerID,
       ICB.InvoiceRef,
       ICB.PartyRef,
       p.DLTitle     AS PartyDLTitle,
       p.DLTitle_En  AS PartyDLTitle_En,
       p.BrokerGroupingRef,
       p.BrokerGroupingCode,
       p.BrokerGroupingTitle,
       p.BrokerGroupingTitle_En,
       p.DLRef       AS PartyDLRef,
       p.DLCode	     AS PartyDLCode,
       ICB.SalePortionPercent,
	   ICB.ManualCommissionAmount
FROM   SLS.InvoiceCommissionBroker ICB
       INNER JOIN GNR.vwParty p
            ON  ICB.PartyRef = p.PartyId