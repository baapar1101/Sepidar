If Object_ID('ACC.vwMergedVoucherReferenceNumber') Is Not Null
	Drop View ACC.vwMergedVoucherReferenceNumber
GO
CREATE VIEW ACC.vwMergedVoucherReferenceNumber
AS
SELECT MergedVoucherReferenceNumberId, VoucherRef, ReferenceNumber
FROM ACC.MergedVoucherReferenceNumber

