
exec FMK.spAddLookup 'WeighingState',1,N'بارگيري','Lading',N'',N'','INV',1,''
exec FMK.spAddLookup 'WeighingState',2,N'تخليه','Unloading',N'',N'','INV',2,''
exec FMK.spAddLookup 'WeighingState',3,N'اتمام توزين','Weighing Finished',N'',N'','INV',3,''
exec FMK.spAddLookup 'WeighingState',4,N'خاتمه يافته','Voucher Finished',N'',N'','INV',4,''
exec FMK.spAddLookup 'WeighingState',5,N'ابطال شده','Revoked',N'',N'','INV',5,''

exec FMK.spAddLookup 'WeighingType',1,N'ورود','Entrance',N'',N'','INV',1,''
exec FMK.spAddLookup 'WeighingType',2,N'خروج','Exit',N'',N'','INV',2,''


exec FMK.spAddLookup 'WeighingVchType',1,N'رسيد انبار','Receipt',N'',N'','INV',1,''
exec FMK.spAddLookup 'WeighingVchType',2,N'برگشت رسيد انبار','ReceiptReturn',N'',N'','INV',2,''
exec FMK.spAddLookup 'WeighingVchType',3,N'خروج انبار','Delivery',N'',N'','INV',3,''
exec FMK.spAddLookup 'WeighingVchType',4,N'برگشت خروج انبار','DeliveryReturn',N'',N'','INV',4,''





