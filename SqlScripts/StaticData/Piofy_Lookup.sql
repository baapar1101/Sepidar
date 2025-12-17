EXEC FMK.spAddLookup 'PiofyEmploymentType',0,N'هيچكدام','None',N'',N'','GNR',0,''
EXEC FMK.spAddLookup 'PiofyEmploymentType',1,N'رسمي','Official',N'رەسمي',N'الرسمي','GNR',1,''
EXEC FMK.spAddLookup 'PiofyEmploymentType',2,N'ساعتي','Hourly',N'كاتژمێريي',N'ساعة','GNR',2,''

EXEC FMK.spAddLookup 'PiofyAttendanceFactorMeasurementUnit',1,N'روز','Day',N'',N'','GNR',1,''
EXEC FMK.spAddLookup 'PiofyAttendanceFactorMeasurementUnit',2,N'ساعت - دقيقه','Hour - Minute',N'',N'','GNR',2,''
EXEC FMK.spAddLookup 'PiofyAttendanceFactorMeasurementUnit',3,N'روز - ساعت - دقيقه','Day - Hour - Minute',N'',N'','GNR',3,''

EXEC FMK.spAddLookup 'SendingState',1,N'انتظار','Waiting',N'',N'','GNR',1,''
EXEC FMK.spAddLookup 'SendingState',2,N'در حال ارسال','Sending',N'',N'','GNR',2,''
EXEC FMK.spAddLookup 'SendingState',3,N'ارسال شده','Sent',N'',N'','GNR',3,''
EXEC FMK.spAddLookup 'SendingState',4,N'خطا','Failed',N'',N'','GNR',4,''
EXEC FMK.spAddLookup 'SendingState',5,N'تعليق','Canceled',N'',N'','GNR',5,''
EXEC FMK.spAddLookup 'SendingState',6,N'ارسال شده','Sent',N'',N'','GNR',6,''

EXEC FMK.spAddLookup 'PiofyMonthlyCalculationState', 1, N'Unfinalized', 'غير قابل ويرايش', N'', N'', 'PAY', 1, ''
EXEC FMK.spAddLookup 'PiofyMonthlyCalculationState', 2, N'Finalized', 'قابل ويرايش', N'', N'', 'PAY', 2, ''

exec FMK.spAddLookup 'CommandType',1,N'جديد','New',N'',N'','GNR',1,''
exec FMK.spAddLookup 'CommandType',2,N'ويرايش','Edit',N'',N'','GNR',2,''
exec FMK.spAddLookup 'CommandType',3,N'حذف','Delete',N'',N'','GNR',3,''  
exec FMK.spAddLookup 'CommandType',4,N'غيرفعال','Disable',N'',N'','GNR',4,''  
exec FMK.spAddLookup 'CommandType',5,N'فعال','Enable',N'',N'','GNR',5,''  
exec FMK.spAddLookup 'CommandType',6,N'دريافت','Get',N'',N'','GNR',6,''  

exec FMK.spAddLookup 'PiofyEmploymentType',0,N'نامشخص','Unknown',N'',N'','GNR',0,''  
exec FMK.spAddLookup 'PiofyEmploymentType',1,N'رسمي','Official',N'',N'','GNR',1,''  
exec FMK.spAddLookup 'PiofyEmploymentType',2,N'ساعتي','Hourly',N'',N'','GNR',2,''  

EXEC FMK.spAddLookup 'CommunicationSystem', 1, N'پايوفاي', 'Piofy', N'', N'', 'GNR', 1, '';