
IF OBJECT_ID('SLS.vwInvoiceBroker') IS NOT NULL
    DROP VIEW SLS.vwInvoiceBroker
GO
CREATE VIEW SLS.vwInvoiceBroker
AS

SELECT SLS.InvoiceBroker.BrokerID,
       SLS.InvoiceBroker.InvoiceRef,
       SLS.InvoiceBroker.PartyRef,
       p.DLTitle         AS PartyDLTitle,
       p.DLTitle_En      AS PartyDLTitle_En,
       p.CommissionRate  AS PartyCommissionRate,
       p.DLCode				   AS PartyDLCode,
       SLS.InvoiceBroker.Commission,
       SLS.InvoiceBroker.Rate,
       SLS.InvoiceBroker.CommissionInBaseCurrency,
       p.DLRef           AS PartyDLRef
FROM   SLS.InvoiceBroker
       INNER JOIN GNR.vwParty p
            ON  SLS.InvoiceBroker.PartyRef = p.PartyId