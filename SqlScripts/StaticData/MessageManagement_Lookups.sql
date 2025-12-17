
EXEC FMK.spAddLookup 'MessageSendState',1,'ارسال نشده','NotSent',N'نەنێردراوە',N'غير المرسل','MSG',1,''
EXEC FMK.spAddLookup 'MessageSendState',2,'آماده ارسال','ReadyToSend',N'ئامادەي ناردن',N'المستعد لارسال','MSG',2,''
EXEC FMK.spAddLookup 'MessageSendState',3,'در حال ارسال','Pending',N'خەريكي ناردن',N'في حالة الإرسال','MSG',3,''
EXEC FMK.spAddLookup 'MessageSendState',4,'ارسال شده','Sent',N'نێردراوە',N'المرسل','MSG',4,''
EXEC FMK.spAddLookup 'MessageSendState',5,'ناموفق','Failed',N'ناسەركەتوو',N'غير ناجح','MSG',5,''
EXEC FMK.spAddLookup 'MessageSendState',6,'لغو شده','Canceled',N'هەڵوەشێنراوە',N'ألغيت','MSG',6,''
EXEC FMK.spAddLookup 'MessageSendState',7,'نامشخص','Unknown',N'ناڕوون',N'غير معروف','MSG',7,''

EXEC FMK.spAddLookup 'ContactType',0,'','None','',N'','FMK',0,''
EXEC FMK.spAddLookup 'ContactType',1,'طرف حساب','Party',N'لايەني مامەڵە',N'','FMK',1,''
EXEC FMK.spAddLookup 'ContactType',2,'كاربر','User',N'بەكارھەنەر',N'','FMK',2,''
EXEC FMK.spAddLookup 'ContactType',3,'ساير مخاطبين','CustomContact',N'بەردەنگەكانيتر',N'','FMK',3,''


EXEC FMK.spAddLookup 'SimpleFilterCondition',0,'بزرگتر','GreaterThan',N'گەورەتر',N'أكبر من','FMK',1,''
EXEC FMK.spAddLookup 'SimpleFilterCondition',1,'بزرگتر يا مساوي','GreaterOrEqual',N'گەورەتر يان بەرانبەر',N'أكبر من أو يساوي','FMK',2,''
EXEC FMK.spAddLookup 'SimpleFilterCondition',2,'كوچكتر','LessThan',N'بچووكتر',N'الأصغر','FMK',3,''
EXEC FMK.spAddLookup 'SimpleFilterCondition',3,'كوچكتر يا مساوي','LessOrEqual',N'بچووكتر يان بەرانبەر',N'أقل من أو يساوي','FMK',4,''
EXEC FMK.spAddLookup 'SimpleFilterCondition',4,'مشابه','Like',N'هاوچەشن',N'مماثل','FMK',5,''
EXEC FMK.spAddLookup 'SimpleFilterCondition',5,'مساوي','Equal',N'بەرانبەر',N'مساوي','FMK',7,''
EXEC FMK.spAddLookup 'SimpleFilterCondition',6,'نامساوي','NotEqual',N'نابەرانبەر',N'غير متساوي','FMK',8,''
EXEC FMK.spAddLookup 'SimpleFilterCondition',7,'خالي باشد','IsNull',N'خاڵي بێت',N'فارغ','FMK',9,''
EXEC FMK.spAddLookup 'SimpleFilterCondition',10,'نامشابه','NotLike',N'ناهاوچەشن',N'غير متشابه','FMK',6,''
EXEC FMK.spAddLookup 'SimpleFilterCondition',11,'خالي نباشد','IsNotNull',N'خاڵي نەبێت',N'ليس فارغا','FMK',10,''



EXEC FMK.spAddLookup 'FilterOperator',1,'و','AND',N'و',N'و','FMK',1,''
EXEC FMK.spAddLookup 'FilterOperator',2,'يا','OR',N'يان',N'','FMK',2,''