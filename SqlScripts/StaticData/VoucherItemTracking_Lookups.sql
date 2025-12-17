EXEC FMK.spAddLookup 'VoucherItemTrackingVoucherType',1 /*@Code*/,'فاكتور فروش'       /*@Title*/,'Sales Invoice'                 /*@Title_En*/,N'پسولەي فرۆش'        /*@Title_ku*/,N'فاتورة المبيعات'  /*@Title_ar*/,'INV',1 /*@DisplayOrder*/,'' /*@Extra*/
EXEC FMK.spAddLookup 'VoucherItemTrackingVoucherType',2 /*@Code*/,'فاكتور برگشتي'     /*@Title*/,'Sales Returned Invoice'        /*@Title_En*/,N'گەرانەوەي پسولە'   /*@Title_ku*/,N'فاتورة الاسترداد'  /*@Title_ar*/,'INV',2 /*@DisplayOrder*/,'' /*@Extra*/
EXEC FMK.spAddLookup 'VoucherItemTrackingVoucherType',3 /*@Code*/,'رسيد انبار'        /*@Title*/,'Inventory Receipt'             /*@Title_En*/,N'رەسيدي كۆگا'        /*@Title_ku*/,N'الاستلام'            /*@Title_ar*/,'INV',3 /*@DisplayOrder*/,'' /*@Extra*/
EXEC FMK.spAddLookup 'VoucherItemTrackingVoucherType',4 /*@Code*/,'برگشت رسيد انبار' /*@Title*/,'Inventory Returned Receipt '   /*@Title_En*/,N'هەڵگەڕاوەي رەسيد'  /*@Title_ku*/,N'عودة الايصال'       /*@Title_ar*/,'INV',4 /*@DisplayOrder*/,'' /*@Extra*/
EXEC FMK.spAddLookup 'VoucherItemTrackingVoucherType',5 /*@Code*/,'خروج انبار'        /*@Title*/,'Inventory Delivery'            /*@Title_En*/,N'دەرچووني كۆگا'  /*@Title_ku*/,N'خروج الأوراق المالية من المستودع'       /*@Title_ar*/,'INV',5 /*@DisplayOrder*/,'' /*@Extra*/
EXEC FMK.spAddLookup 'VoucherItemTrackingVoucherType',6 /*@Code*/,'برگشت خروج انبار' /*@Title*/,'Inventory Delivery Return'     /*@Title_En*/,N'گەڕانەوەي دەرچووني كۆگا'  /*@Title_ku*/,N'إعادة خروج الأوراق المالية من مستودع'       /*@Title_ar*/,'INV',6 /*@DisplayOrder*/,'' /*@Extra*/

/*
select a.Code, a.Title , Title_en = b.Title , Title_ku = c.Title , Title_ar = d.Title 
from fmk.lookup a
left join fmk.lookuplocale b on a.LookupID = b.LookupRef and b.LocaleName = 'en'
left join fmk.lookuplocale c on a.LookupID = c.LookupRef and c.LocaleName = 'ku'
left join fmk.lookuplocale d on a.LookupID = d.LookupRef and d.LocaleName = 'ar'
where Type like '%VoucherItemTrackingVoucherType%'
*/
