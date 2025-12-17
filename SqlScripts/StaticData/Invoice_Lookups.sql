/*Invoice*/
exec FMK.spAddLookup 'InvoiceState',1,'ثبت','Registered',N'تۆماركردن',N'تسجيل','SLS',1,''
exec FMK.spAddLookup 'InvoiceState',2,'ابطال شده','Revoked',N'هەڵوەشێنراو',N'ملغي','SLS',2,''

exec FMK.spAddLookup 'InvoiceSettlementType',1,'نقدي','Cash',N'نەختي',N'النقد','SLS',1,''
exec FMK.spAddLookup 'InvoiceSettlementType',2,'نسيه','Credit',N'قەڕز',N'ائتمان','SLS',2,''
exec FMK.spAddLookup 'InvoiceSettlementType',3,'نقدي/نسيه','Cash/Credit',N'نەختي⁄قەڕز',N'النقد/ائتمان','SLS',3,''

/*Commission*/
exec FMK.spAddLookup 'CommissionCalculationBase',1,'حجم فروش كالا در يك فاكتور','InvoicePerItem',N'',N'مستوي بيع البضائع','SLS',1,''
exec FMK.spAddLookup 'CommissionCalculationBase',2,'حجم فروش در يك فاكتور','Invoice',N'',N'مستوي بيع البضائع','SLS',2,''
exec FMK.spAddLookup 'CommissionCalculationBase',3,'حجم فروش كالا در بازه','DatePeriodPerItem',N'',N'مستوي بيع البضائع في فترة زمنية محددة','SLS',3,''
exec FMK.spAddLookup 'CommissionCalculationBase',4,'سرجمع فروش فاكتورها در بازه','DatePeriod',N'',N'مجموع البيع للفاتورات في فترة زمنية معيّنة','SLS',4,''
exec FMK.spAddLookup 'CommissionCalculationBase',5,'ورود دستي','Manual',N'',N'','SLS',5,''
exec FMK.spAddLookup 'CommissionCalculationType',1,'ساده','Linear',N'',N'بسيط','SLS',1,''
exec FMK.spAddLookup 'CommissionCalculationType',2,'پلكاني','Stepped',N'',N'خطوة خطوة','SLS',2,''
exec FMK.spAddLookup 'CommissionSaleVolumeCalculationBase',1,'مقدار','Qunatity',N'',N'المقدار','SLS',1,''
exec FMK.spAddLookup 'CommissionSaleVolumeCalculationBase',2,'مبلغ','Price',N'',N'المبلغ','SLS',2,''
exec FMK.spAddLookup 'CommissionType',1,'درصدي','Percent',N'',N'النسبة المئوية','SLS',1,''
exec FMK.spAddLookup 'CommissionType',2,'مبلغي','Amount',N'',N'مبلغ','SLS',2,''
exec FMK.spAddLookup 'CommissionInvoiceSettlementState',1,'ثبت شده','Saved',N'',N'المسجّل','SLS',1,''
exec FMK.spAddLookup 'CommissionInvoiceSettlementState',2,'تسويه شده به شرط وصول چك','PayedIncludeCheque',N'',N'قبول تسوية الحساب شريطة دفع الشيك','SLS',2,''
exec FMK.spAddLookup 'CommissionInvoiceSettlementState',3,'تسويه شده','PayedExcludeCheque',N'',N'تمت تسوية الحساب','SLS',3,''
exec FMK.spAddLookup 'CommissionItemFilterType',1,'همه','All',N'',N'الكل','SLS',1,''
exec FMK.spAddLookup 'CommissionItemFilterType',2,'شامل كالاهاي زير باشد','Include',N'',N'ضمن العناصر أدناه','SLS',2,''
exec FMK.spAddLookup 'CommissionItemFilterType',3,'تمامي كالا ها به جز','Exclude',N'',N'كل بند باستثناء','SLS',3,''

/*CustomsDeclaration*/

exec FMK.spAddLookup 'CustomsDeclarationState',1,'ثبت','Registered',N'تۆماركردن',N'تسجيل','SLS',1,''
exec FMK.spAddLookup 'CustomsDeclarationState',2,'ابطال شده','Revoked',N'هەڵوەشێنراو',N'ملغي','SLS',2,''


