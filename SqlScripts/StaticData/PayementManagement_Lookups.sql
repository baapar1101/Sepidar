exec FMK.spAddLookup 'PaymentChequeState',1,'پرداخت شده','Payed',N'پێدراو',N'مدفوع','RPA',1,''
exec FMK.spAddLookup 'PaymentChequeState',2,'مسترد شده','Refunded',N'گێڕاوە',N'المستردّ','RPA',2,''
exec FMK.spAddLookup 'PaymentChequeState',4,'ابطال شده','Voided',N'هەڵوەشێنراو',N'ملغي','RPA',4,''
exec FMK.spAddLookup 'PaymentType',1,' به مشتري','Customer Payment',N'بۆ كڕيار',N'إلى الزبون','RPA',2,''
exec FMK.spAddLookup 'PaymentType',2,'پرداخت به ساير','Payment to ...',N'پێدان بە كەساني‌تر',N'المدفوعات إلى الآخر','RPA',4,''
exec FMK.spAddLookup 'PaymentType',4,'بانك به بانك','Bank to Bank',N'بانك بۆ بانك',N'مصرف للمصرف','RPA',5,''
exec FMK.spAddLookup 'PaymentType',8,'بانك به صندوق','Bank To Cash',N'بانك بۆ بوخچە',N'البنك للصندوق','RPA',6,''
exec FMK.spAddLookup 'PaymentType',16,'صندوق به بانك','Cash To Bank',N'بوخچە بۆ بانك',N'صندوق بنك','RPA',7,''
exec FMK.spAddLookup 'PaymentType',32,'صندوق به صندوق','Cash To Cash',N'بوخچە بۆ بوخچە',N'صندوق بالصناديق','RPA',8,''
exec FMK.spAddLookup 'PaymentType',64,'تضمين','Guarantee',N'مسۆگەر',N'ضمان','RPA',9,''
exec FMK.spAddLookup 'PaymentType',128,'پرداخت به واسط','Broker Payment',N'Broker Payment',N'Broker Payment','RPA',3,''
exec FMK.spAddLookup 'PaymentType',256,'به تامين كننده','Vendor Payment',N'Vendor Payment',N'لتوفير','RPA',1,''
exec FMK.spAddLookup 'PaymentType',1024,'كارمزد','Bankfee',N'Bankfee',N'','RPA',10,''
exec FMK.spAddLookup 'PaymentType',2048,'به تنخواه دار','PettyCash Payment',N'',N'','RPA',11,''



exec FMK.spAddLookup 'DurationType',0,' ',' ','',N'','RPA',0,''
exec FMK.spAddLookup 'DurationType',1,'مدت دار','Post Dated',N'ماوەدار',N'مدت دار','RPA',1,''
exec FMK.spAddLookup 'DurationType',2,'روز','Current',N'رۆژ',N'يوم','RPA',2,''

exec FMK.spAddLookup 'RefundType',1,'استرداد چك دريافتني','Refund ReceiptCheque',N'گەرانەوەي چەكي وەرگيراو ',N'استرداد الشيكات المستحقة للاستلام','RPA',1,''
exec FMK.spAddLookup 'RefundType',2,'استرداد چك پرداختني','Refund Payment Cheque',N'گەرانەوي چەكي پێدراو',N'اعادة شيكات المبالغ الفائضة المستحقة','RPA',2,''
exec FMK.spAddLookup 'RefundType',4,'برگشت چك خرج شده','Return Spended Cheque',N'هەڵگەڕانەوەي چەكي خەرج كراو',N'اعادة الشيك المستفاد','RPA',3,''


