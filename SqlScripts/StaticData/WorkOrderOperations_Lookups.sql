
EXEC FMK.spAddLookup 'ProductOrderState',0,'','None',N'',N'','WKO',0,''
EXEC FMK.spAddLookup 'ProductOrderState',1,'درحال توليد','UnderProduction',N'لە حاڵي وەبەرهێناندا',N'في حالة الانتاج','WKO',1,''
EXEC FMK.spAddLookup 'ProductOrderState',2,'اتمام توليد','ProductionEnd',N'كۆتايي وەبەرهێنان',N'إنهاء الانتاج','WKO',2,''
EXEC FMK.spAddLookup 'ProductOrderState',3,'محاسبه شده','Calculated',N'ژمێركاري كراو',N'محسوب','WKO',3,''


EXEC FMK.spAddLookup 'ProductionForecastDisplayMethod',1,'نمايش مواد اوليه','RawMaterials',N'',N'','WKO',1,''
EXEC FMK.spAddLookup 'ProductionForecastDisplayMethod',2,'نمايش مواد نيمه ساخته','SemiMades',N'',N'','WKO',2,''
EXEC FMK.spAddLookup 'ProductionForecastDisplayMethod',3,'نمايش هر دو','Both',N'',N'','WKO',3,''
