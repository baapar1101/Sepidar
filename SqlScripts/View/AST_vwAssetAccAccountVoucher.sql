If Object_ID('AST.vwAssetAccAccountVoucher') Is Not Null
BEGIN
    DROP VIEW [AST].vwAssetAccAccountVoucher
END

GO

CREATE VIEW [AST].vwAssetAccAccountVoucher
AS

SELECT  v.VoucherId AS AssetAccAccountVoucherId
       ,v.Number
       ,v.[Date]
       ,v.[Description]
FROM   Acc.Voucher v
						WHERE  v.IssuerSystem = 10 
								AND EXISTS (SELECT D.AssetRef
								              FROM AST.Depreciation d WHERE d.VoucherRef = v.VoucherId) 


