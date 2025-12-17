exec FMK.spAddLookup 'PreReceiptType',1,'علي الحساب','On Account',N'لەسەرژمێرە',N'علي الحساب','CNT',1,''
exec FMK.spAddLookup 'PreReceiptType',2,'پيش دريافت','Deposit',N'پێشەكي',N'الاستلام مقدماً','CNT',2,''
exec FMK.spAddLookup 'PreReceiptType',3,'علي الحساب پرداختي','On Account Paymnet',N'',N'','CNT',3,''
exec FMK.spAddLookup 'PreReceiptType',4,'پيش پرداخت','PrePayment',N'',N'','CNT',4,''

exec FMK.spAddLookup 'Regard',1,'انجام تعهدات قرارداد','CommitmentFulfillment',N'جێبەجێ كردني بەڵێنەكان',N'اجراء الالتزامات','CNT',3,''
exec FMK.spAddLookup 'Regard',2,'پيش دريافت / علي الحساب', 'Deposit',N'پێشەكي',N'التلقي مسبقا','CNT',4,''
exec FMK.spAddLookup 'Regard',3,'شركت در مناقصه','Tender',N'',N'','CNT',1,''
exec FMK.spAddLookup 'Regard',4,'صدور ضمانت نامه بانكي ', 'BankGuarantee',N'',N'','CNT',2,''
exec FMK.spAddLookup 'Regard',5,'پيش پرداخت / علي الحساب ', 'ReceivedGuarantee',N'',N'','CNT',5,''

exec FMK.spAddLookup 'StatusType',1,'موقت','Temporary',N'كاتيي',N'مؤقت','CNT',1,''
exec FMK.spAddLookup 'StatusType',2,'ماقبل قطعي','PreFinal',N'پێش بڕاوە',N'قبل النهائي','CNT',2,''
exec FMK.spAddLookup 'StatusType',3,'قطعي','Final',N'بڕاوە',N'قاطع','CNT',3,''


exec FMK.spAddLookup 'StatusRelationType',1,'عادي','Ordinary',N'ئاسايي',N'عادي','CNT',1,''
exec FMK.spAddLookup 'StatusRelationType',2,'تعديل افزايشي','Incremental Modified',N'',N'','CNT',2,''
exec FMK.spAddLookup 'StatusRelationType',3,'تعديل كاهشي','Decremental Modified',N'',N'','CNT',3,''

exec FMK.spAddLookup 'ChangeType',1,'الحاقيه','Rider',N'پاشكۆ',N'التعديلات','CNT',1,''
exec FMK.spAddLookup 'ChangeType',2,'دستوركار','Agenda',N'دەستووري كار',N'جدول الأعمال','CNT',2,''
exec FMK.spAddLookup 'ChangeType',3,'صورت جلسه','Minute',N'راپۆرتي كۆبوونەوە',N'المحضر','CNT',3,''
exec FMK.spAddLookup 'ChangeType',4,'متمم','Supplement',N'',N'','CNT',4,''
exec FMK.spAddLookup 'ChangeType',5,'قرارداد','Contract',N'',N'','CNT',5,''

exec FMK.spAddLookup 'ChangeAmountType',1,'افزايش درصدي','Growth Percent',N'زيادكردني لەسەديي',N'متزايد بالمائة','CNT',1,''
exec FMK.spAddLookup 'ChangeAmountType',2,'كاهش درصدي','Reduction Percent',N'كەم كردنەوەي لەسەديي',N'تقليل بالمائة','CNT',2,''
exec FMK.spAddLookup 'ChangeAmountType',3,'افزايش مبلغي','Growth Price',N'زيادكردني بڕ',N'زيادة كمية','CNT',4,''
exec FMK.spAddLookup 'ChangeAmountType',4,'كاهش مبلغي','Reduction Price',N'كەم كردنەوەي بڕ',N'تقليل كمية','CNT',5,''
exec FMK.spAddLookup 'ChangeAmountType',5,'مبلغ ثابت','Fixed Price',N'بڕە پارەي نەگۆڕ',N'المبلغ الثابت','CNT',6,''

exec FMK.spAddLookup 'TimeUnit',1,'روز','Day',N'رۆژ',N'يوم','CNT',1,''
exec FMK.spAddLookup 'TimeUnit',30,'ماه','Month',N'مانگ',N'الشهر','CNT',2,''
exec FMK.spAddLookup 'TimeUnit',365,'سال','Year',N'ساڵ',N'عام','CNT',3,''

exec FMK.spAddLookup 'CoefficientType',1,'افزاينده','Additive',N'زيادكەرەوە',N'متزايد','CNT',1,''
exec FMK.spAddLookup 'CoefficientType',2,'كاهنده','Reductive',N'كەم كەرەوە',N'المنخفض','CNT',1,''


exec FMK.spAddLookup 'CostStatementType',1,'نقدي','In Cash',N'نەختيي',N'نقد','CNT',1,''
exec FMK.spAddLookup 'CostStatementType',2,'اعتباري','Credit',N'قەرزي',N'ائتمان','CNT',2,''


exec FMK.spAddLookup 'CostStatementItemType',1,'مواد مصرفي','Consumable',N'كەرستەي بەكارهێنان',N'المواد الاستهلاكية','CNT',1,''
exec FMK.spAddLookup 'CostStatementItemType',2,'دستمزد','Wage',N'حەقدەست',N'أجرة','CNT',2,''
exec FMK.spAddLookup 'CostStatementItemType',3,'سربار','Overload',N'سەربار',N'الزائد','CNT',3,''
exec FMK.spAddLookup 'CostStatementItemType',4,'ساير','Other',N'ديكە',N'الآخر','CNT',4,''

exec FMK.spAddLookup 'CostStatementVoucherType',1,'دفتر مركزي','Main Office',N'نووسينگەي ناوەندي',N'المكتب المركزي','CNT',1,''
exec FMK.spAddLookup 'CostStatementVoucherType',2,'كارگاهي','Workshop',N'كارگەيي',N'ورشة','CNT',2,''

exec FMK.spAddLookup 'SettlementType',1,'صورت وضعيت پيمانكاري','Demand',N'',N'','CNT',1,''
exec FMK.spAddLookup 'SettlementType',2,'صورت هزينه','Debt',N'قەرزەكان',N'دين','CNT',2,''
exec FMK.spAddLookup 'SettlementType',3,'صورت وضعيت پيمانكارجزء','OwnershipStatus',N'',N'','CNT',3,''

exec FMK.spAddLookup 'GuaranteeState',1,'ثبت شده','Registered',N'',N'','CNT',1,''
exec FMK.spAddLookup 'GuaranteeState',2,'آزاد شده', 'Reduced',N'',N'','CNT',2,''


exec FMK.spAddLookup 'GuaranteeOperationType',1,'تمديد','Extension',N'',N'','CNT',1,''
exec FMK.spAddLookup 'GuaranteeOperationType',2,'تقليل', 'Reduce',N'',N'','CNT',2,''
exec FMK.spAddLookup 'GuaranteeOperationType',3,'آزاد سازي', 'Release',N'',N'','CNT',3,''

exec FMK.spAddLookup 'ContractPriceListCategoryType',1,'رشته','Field',N'',N'','CNT',1,''
exec FMK.spAddLookup 'ContractPriceListCategoryType',2,'فصل', 'Chapter',N'',N'','CNT',2,''
exec FMK.spAddLookup 'ContractPriceListCategoryType',3,'رسته', 'Class',N'',N'','CNT',3,''

exec FMK.spAddLookup 'StatusConfirmationStateType',1,'ارسالي','Register',N'',N'','CNT',1,''
exec FMK.spAddLookup 'StatusConfirmationStateType',2,'تاييد نهايي','Decisive Confirmed',N'',N'','CNT',2,''
exec FMK.spAddLookup 'StatusConfirmationStateType',3,'ابطالي','Revoked',N'',N'','CNT',3,''


exec FMK.spAddLookup 'ContractAffectedChange',1,'مفاد','AgreementItem',N'',N'','CNT',1,''
exec FMK.spAddLookup 'ContractAffectedChange',2,'قرارداد','Contract',N'',N'','CNT',2,''

exec FMK.spAddLookup 'ContractNature',1,'پيمانكاري','Contracting',N'',N'','CNT',1,''
exec FMK.spAddLookup 'ContractNature',2,'پيمانكارجزء','Ownership',N'',N'','CNT',2,''

exec FMK.spAddLookup 'GuaranteeNature',1,'ضمانت نامه پرداختي','Paid',N'',N'','CNT',1,''
exec FMK.spAddLookup 'GuaranteeNature',2,'ضمانت نامه دريافتي','Received',N'',N'','CNT',2,''

exec FMK.spAddLookup 'StatusNature',1,'پيمانكاري','Contracting',N'',N'','CNT',1,''
exec FMK.spAddLookup 'StatusNature',2,'پيمانكارجزء','Ownership',N'',N'','CNT',2,''

exec FMK.spAddLookup 'CoefficientNature',1,'پيمانكاري','Contracting',N'',N'تعاقد','CNT',1,''
exec FMK.spAddLookup 'CoefficientNature',2,'پيمانكارجزء','Ownership',N'',N'تعاقد الجزئي','CNT',2,''

exec FMK.spAddLookup 'ContractActivationStateType',0,'غير فعال','DeActive',N'',N'','CNT',0,''
exec FMK.spAddLookup 'ContractActivationStateType',1,'فعال','Active',N'',N'','CNT',1,''

exec FMK.spAddLookup 'StatusSettlementType',1,'نقدي','Cash',N'نەختي',N'النقد','CNT',1,''
exec FMK.spAddLookup 'StatusSettlementType',2,'نسيه','Credit',N'قەڕز',N'ائتمان','CNT',2,''
exec FMK.spAddLookup 'StatusSettlementType',3,'نقدي/نسيه','Cash/Credit',N'نەختي⁄قەڕز',N'النقد/ائتمان','CNT',3,''
