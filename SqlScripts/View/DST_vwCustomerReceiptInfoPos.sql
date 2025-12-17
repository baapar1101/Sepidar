IF OBJECT_ID('DST.vwCustomerReceiptInfoPos') IS NOT NULL
	DROP VIEW DST.vwCustomerReceiptInfoPos
GO

CREATE VIEW DST.vwCustomerReceiptInfoPos
AS

SELECT
    CRIP.CustomerReceiptInfoPosId
    ,CRIP.CustomerReceiptInfoRef
    ,CRIP.Amount
    ,CRIP.TrackingCode
FROM DST.CustomerReceiptInfoPos AS CRIP
