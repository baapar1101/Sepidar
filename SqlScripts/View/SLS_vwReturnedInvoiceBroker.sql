If Object_ID('SLS.vwReturnedInvoiceBroker') Is Not Null
	Drop View SLS.vwReturnedInvoiceBroker
GO
CREATE VIEW SLS.vwReturnedInvoiceBroker
AS
SELECT SLS.ReturnedInvoiceBroker.ReturnedInvoiceBrokerID,
       SLS.ReturnedInvoiceBroker.ReturnedInvoiceRef,
       SLS.ReturnedInvoiceBroker.PartyRef,
       p.DLTitle         AS PartyDLTitle,
       p.DLTitle_En      AS PartyDLTitle_En,
       p.CommissionRate  AS PartyCommissionRate,
       p.DLCode			 AS PartyDLCode,
       SLS.ReturnedInvoiceBroker.Commission,
       SLS.ReturnedInvoiceBroker.Rate,
       SLS.ReturnedInvoiceBroker.CommissionInBaseCurrency,
       p.DLRef           AS PartyDLRef
FROM   SLS.ReturnedInvoiceBroker
       INNER JOIN GNR.vwParty p
            ON  SLS.ReturnedInvoiceBroker.PartyRef = p.PartyId