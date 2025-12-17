If Object_ID('ACC.vwGLVoucher') Is Not Null
	Drop View ACC.vwGLVoucher
GO
CREATE VIEW ACC.vwGLVoucher
AS
SELECT GLVoucherId, Number, Date, GLVI.FromVoucherNumber, GLVI.ToVoucherNumber, GLVI.FromVoucherDate, GLVI.ToVoucherDate, 
	 FiscalYearRef, Version, Creator, CreationDate, LastModifier, LastModificationDate
FROM  ACC.GLVoucher GLV
	 OUTER APPLY 
	 (
		SELECT MIN(VoucherDate) FromVoucherDate, MAX(VoucherDate) ToVoucherDate,
			  MIN(VoucherNumber) FromVoucherNumber, MAX(VoucherNumber) ToVoucherNumber
		FROM  ACC.vwGLVoucherItem  
		WHERE GLV.GLVoucherId = GLVoucherRef 
	 )GLVI
