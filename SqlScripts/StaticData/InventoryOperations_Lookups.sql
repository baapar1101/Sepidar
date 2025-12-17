exec FMK.spAddLookup 'InventoryDeliveryType',1,'فروش','Sale',N'فرۆش',N'مبيعات','INV',1,''
exec FMK.spAddLookup 'InventoryDeliveryType',2,'مصرف','Consume',N'بەكارهێنان',N'الاستهلاك','INV',2,''
exec FMK.spAddLookup 'InventoryDeliveryType',3,'ساير',N'Other',N'ديكە',N'الآخر','INV',3,''
exec FMK.spAddLookup 'InventoryDeliveryType',4,'انتقال بين انبار','Inventory Transfer',N'گواستنەوەي نێوان كۆگا',N'التحويل بين مستودعات','INV',4,''

exec FMK.spAddLookup 'InventoryReceiptType',1,'خريد','Purchase',N'كڕين',N'الشراء','INV',1,''
exec FMK.spAddLookup 'InventoryReceiptType',2,'توليد','Production',N'وەبەرهێنان',N'الإنتاج','INV',2,''
exec FMK.spAddLookup 'InventoryReceiptType',3,'ساير','Other',N'ديكە',N'الآخر','INV',3,''
exec FMK.spAddLookup 'InventoryReceiptType',4,'ابتداي دوره','Opening',N'سەرەتاي خولەكە',N'بداية الفترة','INV',4,''
exec FMK.spAddLookup 'InventoryReceiptType',5,'انتقال بين انبار','Inventory Transfer',N'گواستنەوەي نێوان كۆگا',N'التحويل بين مستودعات','INV',5,''

exec FMK.spAddLookup 'InventoryVoucherType',1,'رسيد','Receipt',N'رەسيد',N'ايصال','INV',1,''
exec FMK.spAddLookup 'InventoryVoucherType',2,'برگشت رسيد','Receipt Return',N'گەڕانەوەي رەسيد',N'عودة الايصال','INV',2,''
exec FMK.spAddLookup 'InventoryVoucherType',3,'خروج','Delivery',N'دەرچوون',N'خروج','INV',3,''
exec FMK.spAddLookup 'InventoryVoucherType',4,'برگشت خروج','Delivery Return',N'گەڕانەوەي دەرچوون',N'إعادة الخروج ','INV',4,''
exec FMK.spAddLookup 'InventoryVoucherType',5,'فاكتور خريد خدمات','Service Inventory Purchase Invoice',N'پسولەي كڕيني خزمەتگوزارييەكان',N'فاتورة خدمات ترتيب','INV',5,''

exec FMK.spAddLookup 'InventoryReceiptPurchaseType',1,'خريد (داخلي)','Purchase (Domestic)',N'كڕين( ناوخۆ)',N'الشراء (الداخلية)','INV',1,''
exec FMK.spAddLookup 'InventoryReceiptPurchaseType',2,'خريد (وارداتي)','Purchase (Import)',N'كڕيني (ده‌ره‌كي)',N'الشراء (المستوردة)','INV',2,''
DELETE FROM FMK.[Lookup] WHERE [Type]='InventoryReceiptPurchaseType' AND [Code]=3

exec FMK.spAddLookup 'FormCreator',1,'انبار','Inventory',N'كۆگا',N'المستودع','CNT',1,''
exec FMK.spAddLookup 'FormCreator',2,'قرارداد','Contract',N'گرێبەست',N'العقد','CNT',2,''
exec FMK.spAddLookup 'FormCreator',3,'انبارگرداني','Balancing',N'پشكنيني كۆگا',N'رصيد المخزون','CNT',3,''
exec FMK.spAddLookup 'FormCreator',4,'توليد','Work Order',N'وەبەرهێنان',N'الإنتاج','CNT',4,''
exec FMK.spAddLookup 'FormCreator',5,'درخواست كالا از انبار','ItemRequest',N'ItemRequest',N'ItemRequest','CNT',4,''

exec FMK.spAddLookup 'InventoryBalancingState',1,'فاقد تگ','UnTagged',N'بێ تەگ',N'دون العلامة','INV',1,''
exec FMK.spAddLookup 'InventoryBalancingState',2,'داراي تگ','Tagged',N'خاوەني تەگ',N'لها العلامة','INV',2,''
exec FMK.spAddLookup 'InventoryBalancingState',3,'تأييد شمارش','Accepted Counting',N'ئەرێ كردني ژماردن',N'موافق العدد','INV',3,''
exec FMK.spAddLookup 'InventoryBalancingState',4,'ثبت اسناد كسري/اضافي','Difference Documents Issued',N'تۆماري بەڵگەنامە كەميەكان/ زيادە',N'تسجيل الوثالئق الاقتطاعية /إضافية','INV',4,''
exec FMK.spAddLookup 'InventoryBalancingState',5,'ثبت اسناد حسابداري مغايرت','Difference Voucher Issued',N'تۆماري بەڵگەنامە ژمێريارييەكاني جياوازيي',N'تسجيل وثائق المحاسبة تتعارض','INV',5,''

exec FMK.spAddLookup 'InventoryPurchaseInvoiceType',1,'عادي','Normal',N'ئاسايي',N'عادي','INV',1,''
exec FMK.spAddLookup 'InventoryPurchaseInvoiceType',2,'خدمات','Service',N'خزمەتگوزارييەكان',N'الخدمات','INV',2,''
exec FMK.spAddLookup 'InventoryPurchaseInvoiceType',3,'دارايي','Asset purchase',N'',N'','INV',2,''

exec FMK.spAddLookup 'CostType',0, N'','',N'', N'', 'INV', 0, ''
exec FMK.spAddLookup 'CostType',1, N'ساير هزينه هاي تسهميم نشده دوره مالي قبل','OtherUnallocatedCostsOfThePreviousFiscalyear',N'OtherUnallocatedCostsOfThePreviousFiscalyear', N'OtherUnallocatedCostsOfThePreviousFiscalyear', 'INV', 1, ''
exec FMK.spAddLookup 'CostType',2, N'ساير هزينه ها','OtherCosts',N'OtherCosts', N'OtherCosts', 'INV', 2, ''


exec FMK.spAddLookup 'CostAllotmentType',1, N'مقداري','Unit',N'مقداري', N'مقداري', 'INV', 1, ''
exec FMK.spAddLookup 'CostAllotmentType',2, N'مبلغي','Price',N'مبلغي', N'مبلغي', 'INV', 2, ''
exec FMK.spAddLookup 'CostAllotmentType',3, N'مساوي','Equal',N'به نسبت مساوي', N'به نسبت مساوي', 'INV', 3, ''
exec FMK.spAddLookup 'CostAllotmentType',4, N'دستي','Custom',N'دستي', N'دستي', 'INV', 4, ''
