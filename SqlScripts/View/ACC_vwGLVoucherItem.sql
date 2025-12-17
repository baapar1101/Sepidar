If Object_ID('ACC.vwGLVoucherItem') Is Not Null
	Drop View ACC.vwGLVoucherItem
GO

CREATE VIEW ACC.vwGLVoucherItem
AS
SELECT     ACC.GLVoucherItem.GLVoucherItemId, ACC.GLVoucherItem.GLVoucherRef, ACC.GLVoucherItem.VoucherRef, ACC.Voucher.Number AS VoucherNumber, 
                      ACC.Voucher.Date AS VoucherDate, ACC.GLVoucherItem.Version
FROM         ACC.GLVoucherItem INNER JOIN
                      ACC.Voucher ON ACC.GLVoucherItem.VoucherRef = ACC.Voucher.VoucherId
                      

