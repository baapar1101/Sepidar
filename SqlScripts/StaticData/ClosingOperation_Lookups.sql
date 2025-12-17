exec FMK.spAddLookup 'ClosingGroup',0,' ',' ','',N'','GNR',1,''
exec FMK.spAddLookup 'ClosingGroup',1,'دريافت و پرداخت','Receipt And Payment',N'وەرگرتن و پێدان',N'التلقي و الدفع','GNR',1,''
exec FMK.spAddLookup 'ClosingGroup',2,'انبار','Stocks',N'كۆگا',N'المستودع','GNR',3,''
exec FMK.spAddLookup 'ClosingGroup',4,'مشتريان و فروش','Customers And Sale',N'كڕياران و فرۆش',N'الزبائن و المبيعات','GNR',2,''
exec FMK.spAddLookup 'ClosingGroup',8,'تامين كنندگان','Vendors',N'دابينكاران',N'المزودين','GNR',4,''
exec FMK.spAddLookup 'ClosingGroup',16,'دارايي ثابت','Fixed Asset',N'',N'','GNR',5,''


exec FMK.spAddLookup 'ClosingState',0,'باز','Open',N'كراوە',N'المفتوح','GNR',1,''
exec FMK.spAddLookup 'ClosingState',1,'بسته','Close',N'داخراو',N'مغلق','GNR',2,''
exec FMK.spAddLookup 'ClosingState',2,'نامشخص','Undefined',N'ناڕوون',N'غير محدد','GNR',3,''
