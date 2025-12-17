IF OBJECT_ID('DST.vwCustomerReceiptInfo') IS NOT NULL
	DROP VIEW DST.vwCustomerReceiptInfo
GO

CREATE VIEW DST.vwCustomerReceiptInfo
AS

SELECT
    CRI.CustomerReceiptInfoId
    ,CRI.CustomerPartyRef
    ,CRI.PartyAccountSettlementRef
    ,CRI.DebtCollectionListRef
    ,CRI.ColdDistributionRef
    ,CRI.CurrencyRef
    ,CRI.ReceiptAmount
    ,CRI.ReceiptDraftAmount
    ,DL.DLId CustomerDlRef
    ,DL.Title CustomerDlTitle
FROM DST.CustomerReceiptInfo as CRI
JOIN GNR.Party P on p.PartyId = CRI.CustomerPartyRef
JOIN ACC.DL DL on DL.DLId = p.DLRef