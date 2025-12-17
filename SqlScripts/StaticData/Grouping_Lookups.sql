exec FMK.spAddLookup 'GroupingCreditCheckingType', 1, 'هشدار در صورت بيشتر شدن مانده از اعتبار', 'Warning', N'', N' التحذير في حالة ازدياد البقية من ائتمان الحساب','GNR', 1, ''
exec FMK.spAddLookup 'GroupingCreditCheckingType', 2, 'جلوگيري از عمليات در صورت بيشتر شدن مانده از اعتبار', 'Deny', N'', N'منع العملية  في حالة ازدياد البقية من ائتمان الحساب', 'GNR', 2, ''
exec FMK.spAddLookup 'GroupingCreditCheckingType', 3, 'هيچكدام', 'None',N'',N'لا شيء', 'GNR',3, ''
