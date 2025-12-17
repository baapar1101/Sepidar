DELETE FROM FMK.Lookup WHERE [Type] = 'MarketingDisketteType'
exec FMK.spAddLookup 'MarketingDisketteType',1,'خريد','Buy',N'كڕين',N'الشراء','GNR',1,''
exec FMK.spAddLookup 'MarketingDisketteType',2,'فروش','Sale',N'فرۆش',N'مبيعات','GNR',2,''
exec FMK.spAddLookup 'MarketingDisketteType',3,'خريد و فروش','Buy And Sales',N'كڕين و فرۆش',N'شراء و بيع','GNR',3,''
exec FMK.spAddLookup 'MarketingDisketteType',4,'صورت وضعيت','Status',N'پوختەي هەلومەرج',N'بيان الايصال','GNR',4,''
exec FMK.spAddLookup 'MarketingDisketteType',5,'خريد و صورت وضعيت','Buy And Status',N'كڕين و پوختەي هەلومەرج',N'البيع و بيانات الايصال','GNR',5,''
exec FMK.spAddLookup 'MarketingDisketteType',6,'فروش و صورت وضعيت','Sales And Status',N'فرۆشي و پوختەي هەلومەرج',N'شراء و بيانات الايصال','GNR',6,'' 
exec FMK.spAddLookup 'MarketingDisketteType',7,'همه','All',N'هه‌موو',N'كل','GNR',7,''
exec FMK.spAddLookup 'MarketingDisketteItemType',1,'فاكتور','Invoice',N'پسولە',N'الفاتورة','GNR',1,''
exec FMK.spAddLookup 'MarketingDisketteItemType',2,'رسيد انبار','Invoice',N'رەسيدي كۆگا',N'ايصالات المخزون','GNR',2,''
exec FMK.spAddLookup 'MarketingDisketteItemType',3,'فاكتور برگشتي','Returned Invoice',N'گەرانەوەي پسولە',N'فاتورة العودة','GNR',3,''
exec FMK.spAddLookup 'MarketingDisketteItemType',4,'برگشت رسيد','Invoice',N'گەڕانەوەي رەسيد',N'عودة الايصال','GNR',4,''
exec FMK.spAddLookup 'MarketingDisketteItemType',5,'فاكتور خريد خدمات','Service Inventory Purchase Invoice',N'پسولەي كڕيني خزمەتگوزارييەكان',N'فاتورة خدمات ترتيب','GNR',5,''
exec FMK.spAddLookup 'MarketingDisketteItemType',6,'صورت وضعيت','Status',N'پوختەي هەلومەرج',N'الفاتورة','GNR',6,''



DELETE FROM FMK.Lookup WHERE [Type] = 'PeriodType'
exec FMK.spAddLookup 'PeriodType',1,'فصلي','Season',N'Season',N'الفصلي','GNR',1,''
exec FMK.spAddLookup 'PeriodType',2,'ماهانه','Month',N'Month',N'شهريا','GNR',2,''

