exec FMK.spAddLookup 'BillItemType',1,'1-فاكتور فروش','1.Sales Invoice',N'1-پسولەي فرۆش',N'1. فاتورة المبيعات','GNR',1,''
exec FMK.spAddLookup 'BillItemType',15,'2-حمل','2.Transport', N'2-قازانج و سزاي قيست بەندي' ,N'2. العملي','GNR',2,''
exec FMK.spAddLookup 'BillItemType',2,'3-فاكتور برگشتي','3.Sales Returned Invoice',N'3-گەرانەوەي پسولە',N'3.فاتورة الاسترداد','GNR',3,''
exec FMK.spAddLookup 'BillItemType',3,'10-اعلاميه بدهكار بستانكار','10.Debit Credit Note',N'10-رێك كردني حيسابي لايان مامڵەي',N'10. إعلان المدين الدائن','GNR',4,''
exec FMK.spAddLookup 'BillItemType',4,'1-رسيد انبار','1.Inventory Receipt',N'1-رەسيدي كۆگا',N'4.الاستلام','GNR',5,''
exec FMK.spAddLookup 'BillItemType',5,'3-برگشت رسيد ','3.Inventory Returned Receipt',N'2-هەڵگەڕاوەي رەسيد',N'3- عودة الايصال','GNR',6,''
exec FMK.spAddLookup 'BillItemType',6,'4-دريافت','4.Receipt',N'4-وەرگرتن',N'4. الخصم النقدي للاستلام','GNR',7,''
exec FMK.spAddLookup 'BillItemType',7,'5-پرداخت','5.Payment',N'5-پێدان',N'5. الدفع','GNR',8,''
exec FMK.spAddLookup 'BillItemType',10,'4-تخفيف نقدي دريافت','4.Receipt Discount',N'4-داشكاني نەختيي وەرگرتن',N'1. ايصال المستودع','GNR',11,''
exec FMK.spAddLookup 'BillItemType',11,'6-تخفيف نقدي پرداخت','6.Payment Discount',N'6-داشكاني نەختيي پێدان',N'6- الخصم النقدي للدفع','GNR',12,''
exec FMK.spAddLookup 'BillItemType',8,'7-استرداد چك پرداختي','7.Payment Refund Cheque',N'7-گەرانەوەي چەكي پێدراوە',N'7.استرداد الشيك الدفعي','GNR',9,''
exec FMK.spAddLookup 'BillItemType',9,'8-استرداد چك دريافتي','8.Receipt Refund Cheque',N'8-گەرانەوەي چەكي وەرگيراو',N'8. استرداد الشيك المتلقي','GNR',10,''
exec FMK.spAddLookup 'BillItemType',12,'9-برگشت چك خرج شده','9.Return Spended Cheque',N'9-گەڕانەوەي چەكي خەرج كراو',N'9.استرداد الشيك المستفاد','GNR',13,''
exec FMK.spAddLookup 'BillItemType',13,'10-فاكتور خريد خدمات','10.Service Inventory Purchase Invoice',N'10-پسولەي كڕيني خزمەتگوزارييەكان',N'10.فاتورة شراء الخدمات','GNR',14,''
exec FMK.spAddLookup 'BillItemType',14,'11-بهره و جريمه تقسيط','11.Shred Interest And Penaly', N'11-قازانج و سزاي قيست بەندي' ,N'11. الفوائد و غرامات الانقسام','GNR',15,''

exec FMK.spAddLookup 'BillItemType',16,'10-فاكتور خريد دارايي','10.Asset Purchase Invoice',N'',N'','GNR',16,''

exec FMK.spAddLookup 'BillItemType',17,'12-فاكتور خريد وارداتي','12.PurchaseInvoice',N'',N'','GNR',17,''
exec FMK.spAddLookup 'BillItemType',18,'12-بارنامه','12.BillOfLoading',N'',N'','GNR',18,''
exec FMK.spAddLookup 'BillItemType',19,'12-بيمه نامه','12.InsurancePolicy',N'',N'','GNR',19,''
exec FMK.spAddLookup 'BillItemType',20,'12-سفارش بازرگاني','12.CommercialOrder',N'',N'','GNR',20,''
exec FMK.spAddLookup 'BillItemType',21,'12-ترخيص','12.CustomsClearance',N'',N'','GNR',21,''



exec FMK.spAddLookup 'BillType',1,'فروش','Sale',N'فرۆش',N'مبيعات','GNR',1,''
exec FMK.spAddLookup 'BillType',2,'خريد','Buy',N'كڕين',N'الشراء','GNR',2,''
