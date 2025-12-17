exec FMK.spAddLookup 'InterestRateTypes',1,N'ماهيانه','Monthly',N'مانگانە',N'',GNR,1,''
exec FMK.spAddLookup 'InterestRateTypes',2,N'ساليانه','Yearly',N'ساڵانە',N'',GNR,2,''

exec FMK.spAddLookup 'Shredables',1,N'فاكتور فروش','Invoice',N'پسولەي فرۆش',N'فاتورة المبيعات',GNR,1,''
exec FMK.spAddLookup 'Shredables',2,N'فاكتور خريد','Purchase Invoice',N'داواكاري',N'فاتورة الشراء',GNR,2,''
exec FMK.spAddLookup 'Shredables',3,N'رسيد انبار','Inventory Receipt',N'رەسيدي كۆگا',N'ايصالات التخزين',GNR,3,''
exec FMK.spAddLookup 'Shredables',4,N'وام كارمندي','Personel Loan',N'وامي كارمەندي',N'قروض الموظفين',GNR,''
exec FMK.spAddLookup 'Shredables',5,N'وام بانكي','Bank Loan',N'قەرزي بانكيي',N'القروض المصرفية',GNR, 5,''
exec FMK.spAddLookup 'Shredables',6,N'ساير - دريافتني','Other Receivable',N'ديكە_وەرگرتني',N'أخرى - التحميل',GNR, 6,''
exec FMK.spAddLookup 'Shredables',7,N'ساير - پرداختني','Other Payable',N'ديكە_پێداني',N'أخرى - تدفع',GNR, 7,''
exec FMK.spAddLookup 'Shredables',8,N'فاكتور خريد خدمات','Service Purchase Invoice',N'پسولەي كڕيني خزمەتگوزارييەكان',N'فاتورة شراء الخدمات',GNR,8,''

exec FMK.spAddLookup 'ShredItemStatus',1,N'تسويه شده','Paid',N'ساوكراو',N'تسوية',GNR,1,''
exec FMK.spAddLookup 'ShredItemStatus',2,N'تسويه نشده','Not Paid',N'ساونەكراو',N'غير التسوية',GNR,2,''

exec FMK.spAddLookup 'TransferRemainedAmountTypes',1,N'اولين قسط','First Shred',N'يەكەم قيست',N'أول قسط',GNR,1,''
exec FMK.spAddLookup 'TransferRemainedAmountTypes',2,N'آخرين قسط','Last Shred',N'دوايين قيست',N'آخر قسط',GNR,2,''




exec FMK.spCreateNumbering 'SG.General.ShredManagement.Common.ShredRow', 2, 1, null, 0, 0, 0, 0