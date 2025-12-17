Update CC
set SLRef = AccountSLRef
FROM SLS.CommissionCalculation CC
              INNER JOIN ACC.Voucher
                 ON CC.AccountingVoucherRef = VoucherId
              INNEr JOIN ACC.VoucherItem 
                 ON VoucherRef = VoucherId
              WHERE Debit > 0
                 AND CC.SLRef IS NULL

