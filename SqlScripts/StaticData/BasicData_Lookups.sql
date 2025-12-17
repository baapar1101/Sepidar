EXEC FMK.spAddLookup 'AreaAndPathType', 0, '   '	, '   '	, N'', N'', 'DST', 0, '' 
EXEC FMK.spAddLookup 'AreaAndPathType', 1, 'منطقه'	, 'Area', N'', N'', 'DST', 1, ''
EXEC FMK.spAddLookup 'AreaAndPathType', 2, 'مسير'	, 'Path', N'', N'', 'DST', 2, ''

EXEC FMK.spAddLookup 'OrderingScheduleRecurrenceType', 1, 'روزانه'	, 'Daily', N'', N'', 'DST', 1, ''
EXEC FMK.spAddLookup 'OrderingScheduleRecurrenceType', 2, 'هفتگي'	, 'Weekly', N'', N'', 'DST', 2, ''


EXEC FMK.spAddLookup 'SalesLimitControlType', 1, 'روزانه'	, 'Daily', N'', N'', 'DST', 1, ''
EXEC FMK.spAddLookup 'SalesLimitControlType', 2, 'دوره اي'	, 'Periodic', N'', N'', 'DST', 2, ''


EXEC FMK.spAddLookup 'ProductSaleLineProductsState', 1, 'همه كالاها'	, 'All products', N'', N'', 'DST', 1, ''
EXEC FMK.spAddLookup 'ProductSaleLineProductsState', 2, 'كالاهاي موجود در جدول پايين'	, 'Products in grid', N'', N'', 'DST', 2, ''
EXEC FMK.spAddLookup 'ProductSaleLineProductsState', 3, 'هيچ كدام از كالاها'	, 'None of products', N'', N'', 'DST', 3, ''


EXEC FMK.spAddLookup 'ProductSaleLineServicesState', 1, 'همه خدمات'	, 'All services', N'', N'', 'DST', 1, ''
EXEC FMK.spAddLookup 'ProductSaleLineServicesState', 2, 'خدمات موجود در جدول پايين'	, 'Services in grid', N'', N'', 'DST', 2, ''
EXEC FMK.spAddLookup 'ProductSaleLineServicesState', 3, 'هيچ كدام از خدمات'	, 'None of services', N'', N'', 'DST', 3, ''
