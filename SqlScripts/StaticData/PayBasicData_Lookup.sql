exec FMK.spAddLookup 'NationalityType',1,'ايراني','Iranian',N'ئێراني',N'إيراني','PAY',1,''
exec FMK.spAddLookup 'NationalityType',2,'غير ايراني','Other',N'غەيرە ئێراني',N'غير الإيرانية','PAY',2,''

exec FMK.spAddLookup 'MarriageStatus',0,' ',' ','',N'','PAY',0,''
exec FMK.spAddLookup 'MarriageStatus',1,'مجرد','Single',N'زگورتي',N'عزب','PAY',1,''
exec FMK.spAddLookup 'MarriageStatus',2,'متاهل','Married',N'هاوسەردار',N'متزوج','PAY',2,''
exec FMK.spAddLookup 'MarriageStatus',3,'معيل','Divorced',N'خێزاندار',N'المعدل','PAY',3,''

exec FMK.spAddLookup 'EducationDegree',0,' ',' ','',N'','PAY',0,''
exec FMK.spAddLookup 'EducationDegree',1,'بيسواد','Uneducated',N'نەخوێندەوار',N'أمي','PAY',1,''
exec FMK.spAddLookup 'EducationDegree',2,'كم سواد','Undergraduate Elementary',N'خوێندەواريي كەم',N'الملمين بالقراءة و الكتابة منخفضة','PAY',2,''
exec FMK.spAddLookup 'EducationDegree',3,'ابتدايي','Elementary',N'سەرەتايي',N'المدارس الابتدائية','PAY',3,''
exec FMK.spAddLookup 'EducationDegree',4,'سيكل','Postgraduate Elementary',N'سيكل',N'دورة الثلث في المدارس الإعدادية','PAY',4,''
exec FMK.spAddLookup 'EducationDegree',5,'زير ديپلم','Undergraduate Diploma',N'ژێر ديپلۆم',N'قبل دبلوم','PAY',5,''
exec FMK.spAddLookup 'EducationDegree',6,'ديپلم يا معادل آن','Diploma',N'ديپلۆم يان هاوتاي',N'دبلوم أو ما يعادلها','PAY',6,''
exec FMK.spAddLookup 'EducationDegree',7,'كارشناسي يا معادل آن','Bachelor Degree',N'كارناسيي يان هاوتاي',N'البكالوريوس أو ما يعادلها','PAY',8,''
exec FMK.spAddLookup 'EducationDegree',8,'كارشناسي ارشد يا معادل آن','Master Degree',N'كارناسي باڵا يان هاوتاي',N'الماجستير أو ما يعادلها','PAY',9,''
exec FMK.spAddLookup 'EducationDegree',9,'دكتري يا معادل آن','Doctoral Degree',N'دوكتۆري يان هاوتاي',N'الدكتوراه أو ما يعادلها','PAY',10,''
exec FMK.spAddLookup 'EducationDegree',10,'فوق دكتري يا معادل آن','Post Doctoral Degree',N'پسپۆڕيي يان هاوتاي',N'فوق دكتري يا معادل آن','PAY',11,''
exec FMK.spAddLookup 'EducationDegree',11,'فوق ديپلم','Super Diploma',N'بان ديپلۆم',N'شهادة جامعية بدرجة الزمالة','PAY',7,''

exec FMK.spAddLookup 'MilitaryStatus',0,' ',' ','',N'','PAY',0,''
exec FMK.spAddLookup 'MilitaryStatus',1,'انجام داده','Done',N'ئەنجام دراو',N'القيام به','PAY',1,''
exec FMK.spAddLookup 'MilitaryStatus',2,'انجام نداده','Still Not Done',N'ئەنجام نەدراو',N'لم تفعل','PAY',2,''
exec FMK.spAddLookup 'MilitaryStatus',3,'معافيت پزشكي','Medical Exemption',N'بەخشراويي پزيشكي',N'الإعفاء الطبي','PAY',3,''
exec FMK.spAddLookup 'MilitaryStatus',4,'معافيت غير پزشكي','Other Exemption',N'بەخشراويي غەيرە پزيشكي',N'الإعفاءات غير طبية','PAY',4,''
exec FMK.spAddLookup 'MilitaryStatus',5,'خريد خدمت','Boughten',N'كڕيني خزمەت',N'شراءخدمة النظام','PAY',5,''
exec FMK.spAddLookup 'MilitaryStatus',6,'جانباز','Victimd of War',N'گيانباز',N'المصابون في الحرب','PAY',6,''
exec FMK.spAddLookup 'MilitaryStatus',7,'آزاده','Prison of War',N'ئازادە',N'الحرّ','PAY',7,''
exec FMK.spAddLookup 'MilitaryStatus',8,'ايثارگر','War Veteran',N'ئيسارگەر',N'قدامى المحاربين','PAY',8,''


exec FMK.spAddLookup 'ElementClass',1,'كاركرد','Working Time',N'كاركرد',N'العمل','PAY',1,''
exec FMK.spAddLookup 'ElementClass',2,'مزايا','Bonus',N'سەربەشيي',N'فوائد','PAY',2,''
exec FMK.spAddLookup 'ElementClass',3,'كسور','Leakage',N'داشكاوەكان',N'الخصومات','PAY',3,''
exec FMK.spAddLookup 'ElementClass',4,'تعهدات كارفرما','Employer Commitment',N'بەڵێنەكاني خاوەنكار',N'التزامات صاحب العمل','PAY',4,''

exec FMK.spAddLookup 'ElementTaxType',0,'','',N'',N'','PAY',0,'';
exec FMK.spAddLookup 'ElementTaxType',15,'(مبلغ حق الزحمه/حق مشاوره/حق حضور/حق نظارت/حق التاليف/ حق فني/ پاداش شوراي حل اختلاف (ستون شماره 15','Consulting and Advisory Fee (Column number 15)',N'مبلغ حق الزحمه/حق مشاوره/حق حضور/حق نظارت/حق التاليف/ حق فني/ پاداش شوراي حل اختلاف',N'رسوم الاستشارة والإشراف والمكافآت','PAY',1,'';
exec FMK.spAddLookup 'ElementTaxType',16,'(مبلغ قراردادهاي پژوهشي (ستون شماره 16','Research Contract Amount (Column number 16)',N'مبلغ قراردادهاي پژوهشي',N'مبالغ عقود البحث','PAY',2,'';
exec FMK.spAddLookup 'ElementTaxType',17,'(اضافه كاري (ستون شماره 17','Overtime (Column number 17)',N'اضافه كاري',N'عمل إضافي','PAY',3,'';
exec FMK.spAddLookup 'ElementTaxType',18,'(هزينه سفر (ستون شماره 18','Travel Expenses (Column number 18)',N'هزينه سفر',N'نفقات السفر','PAY',4,'';
exec FMK.spAddLookup 'ElementTaxType',19,'(فوق العاده مسافرت (ماموريت) (ستون شماره 19','Travel Allowance (Column number 19)',N'(فوق العاده مسافرت (ماموريت',N'(فوق العاده مسافرت (ماموريت','PAY',5,'';
exec FMK.spAddLookup 'ElementTaxType',20,'(كارانه (ستون شماره 20','Performance Bonus (Column number 20)',N'كارانه',N'مكافأة الأداء','PAY',6,'';
exec FMK.spAddLookup 'ElementTaxType',21,'(پاداش (به استثناي پاداش آخر سال و پاداش پايان خدمت و پاداش بهره وري) (ستون شماره 21','Reward Excluding Year-End and Service Completion (Column number 21)',N'پاداش )به استثناي پاداش آخر سال و پاداش پايان خدمت و پاداش بهره وري)',N'مكافآت باستثناء مكافآت نهاية العام والخدمة','PAY',7,'';
exec FMK.spAddLookup 'ElementTaxType',24,'(پاداش پايان خدمت (ستون شماره 24','Service Completion Bonus (Column number 24)',N'پاداش پايان خدمت',N'مكافأة نهاية الخدمة','PAY',8,'';
exec FMK.spAddLookup 'ElementTaxType',25,'(خسارت اخراج (ستون شماره 25','Dismissal Compensation (Column number 25)',N'خسارت اخراج',N'تعويض الإقالة','PAY',9,'';
exec FMK.spAddLookup 'ElementTaxType',26,'(بازخريد خدمت (ستون شماره 26','Service Buyback (Column number 26)',N'بازخريد خدمت',N'شراء مدة الخدمة','PAY',10,'';
exec FMK.spAddLookup 'ElementTaxType',36,'(حق التدريس/حق التحقيق/ حق پژوهش (ستون شماره 36','Teaching and Research Fee (Column number 36)',N'حق التدريس/حق التحقيق/ حق پژوهش',N'رسوم التدريس والبحث','PAY',11,'';
exec FMK.spAddLookup 'ElementTaxType',37,'(حق كشيك (ستون شماره 37','On-Call Duty Fee (Column number 37)',N'حق كشيك',N'رسوم المناوبة','PAY',12,'';
exec FMK.spAddLookup 'ElementTaxType',38,'(رفاهي و انگيزشي و بهره وري (ستون شماره 38','Welfare, Motivational and Productivity (Column number 38)',N'رفاهي و انگيزشي و بهره وري',N'الرفاهية والتحفيز والإنتاجية','PAY',13,'';
exec FMK.spAddLookup 'ElementTaxType',39,'(حق السعي (به استثناي مزد، حقوق، پاداش) (ستون شماره 39','Wage Right Excluding Salary and Bonus (Column number 39)',N'حق السعي (به استثناي مزد، حقوق، پاداش',N'حق السعي (به استثناي مزد، حقوق، پاداش','PAY',14,'';


exec FMK.spAddLookup 'ElementType',1,'كاركرد-روز','Working Day',N'كاركرد_ رۆژ',N'العمل-اليوم','PAY',1,''
exec FMK.spAddLookup 'ElementType',2,'كاركرد-ساعت و دقيقه','Working Hours',N'كاركرد_ كاتژمێر و خولەك',N'العمل -ساعة و دقيقة.','PAY',2,''
exec FMK.spAddLookup 'ElementType',3,'كاركرد- درصدي','Working Percent',N'كاركرد_لەسەديي',N'التشغيل والعمل- في المئة','PAY',3,''
exec FMK.spAddLookup 'ElementType',4,'قراردادي-ثابت','Contract',N'بە گرێبەست_ نەگۆڕ',N'عقدي-ثابت','PAY',4,''
exec FMK.spAddLookup 'ElementType',5,'محاسباتي','Calculated',N'ژمێركاري',N'الحاسبات','PAY',5,''
exec FMK.spAddLookup 'ElementType',6,'ورود دستي','Manual Entry',N'تۆماري دەستيي',N'الإدخال اليدوي','PAY',6,''

exec FMK.spAddLookup 'ElementNormalType',1,'عادي','Normal',N'ئاسايي',N'عادي','PAY',1,''
exec FMK.spAddLookup 'ElementNormalType',2,'فوق العاده','Unexpected',N'تايبەت',N'استثنائي','PAY',2,''

exec FMK.spAddLookup 'ElementCalcType',0,'','','',N'','PAY',1,''
exec FMK.spAddLookup 'ElementCalcType',1,'روزانه','Daily',N'رۆژانە',N'يوميا','PAY',2,''
exec FMK.spAddLookup 'ElementCalcType',2,'ساعتي','Hourly',N'كاتژمێريي',N'ساعة','PAY',3,''
exec FMK.spAddLookup 'ElementCalcType',3,'درصد/عدد','PercentNumber',N'لەسەد/ ژمارە',N'في المئة / عدد','PAY',4,''


exec FMK.spAddLookup 'ElementDenominatorsType',0,'','','',N'','PAY',1,''
exec FMK.spAddLookup 'ElementDenominatorsType',1,'عدد ثابت','FixPoint',N'ژمارەي نەگۆڕ',N'رقم ثابت','PAY',2,''
exec FMK.spAddLookup 'ElementDenominatorsType',2,'روزهاي ماه','MonthDay',N'رۆژەكاني مانگ',N'أيام الشهر','PAY',3,''

if ((Select count(0) from Fmk.Lookup Where  Type = 'TaxGroupType') > 9)
begin    
    delete from Fmk.Lookup Where Type =  'TaxGroupType'   

    update Pay.TaxGroup Set Type= 0 Where Type = 1
    update Pay.TaxGroup Set Type= 3 Where Type = 2
    update Pay.TaxGroup Set Type= 2 Where Type = 3
    update Pay.TaxGroup Set Type= 1 Where Type = 4
    update Pay.TaxGroup Set Type= 4 Where Type = 5
    update Pay.TaxGroup Set Type= 4 Where Type = 6
    update Pay.TaxGroup Set Type= 5 Where Type = 7
    update Pay.TaxGroup Set Type= 1 Where Type in (8, 9, 10, 11)
    update Pay.TaxGroup Set Type= 6 Where Type = 12
end

exec FMK.spAddLookup 'TaxGroupType',0,'عدم معافيت','Normal(Taxable)',N'نەبووني بەخشراويي',N'عدم الإعفاء','PAY',1,''
exec FMK.spAddLookup 'TaxGroupType',1,'شاغلين در مناطق محروم','Leakage',N'ئيشكەراني ناوچە هەژارەكان',N'الممارسين في المناطق المحرومة','PAY',2,''
exec FMK.spAddLookup 'TaxGroupType',2,'آزادگان','Prison of War',N'ئازادەكان',N'الأحرار','PAY',3,''
exec FMK.spAddLookup 'TaxGroupType',3,'جانباز','Victimd of War',N'گيانباز',N'المصابون في الحرب','PAY',4,''
exec FMK.spAddLookup 'TaxGroupType',4,'پرسنل نيروهاي مسلح ','Military',N'ئەنداماني هێزە سەربازيەكان',N'موظفو القوات المسلحة','PAY',5,''
exec FMK.spAddLookup 'TaxGroupType',5,'وزارت اطلاعات','InformationMiministry',N'وەزارەتي هەواڵگري (ئيتڵاعات)',N'وزارة المعلومات','PAY',7,''
exec FMK.spAddLookup 'TaxGroupType',6,'مناطق آزاد تجاري-صنعتي','Free Land',N'ناوچەكاني ئازادي بازرگاني_ پيشەسازي',N'المناطق الحرة للتجارية-الصناعية','PAY',8,''
exec FMK.spAddLookup 'TaxGroupType',7,'آزاده و جانباز','Prison & Victimd of War',N'ئازادە و گيانباز',N'الحرّ و المعاق','PAY',9,''
exec FMK.spAddLookup 'TaxGroupType',8,'بازنشسته ، وظيفه و مستمري بگير','Retired',N'خانەنشين، كادێر و مووچەخۆر',N' المتقاعد، واجب الموظف و أصحاب المعاشات التقاعدية','PAY',10,''

exec FMK.spAddLookup 'BranchType',1,'تامين اجتماعي','Social Security',N'دابينكاري كۆمەڵايەتي',N'الضمان الاجتماعي','PAY',1,''
exec FMK.spAddLookup 'BranchType',2,'وزارت دارايي','Ministry of Economy',N'وەزارەتي دارايي',N'وزارة المالية','PAY',2,''
exec FMK.spAddLookup 'BranchType',3,'بيمه تكميلي','Supporting Insurance',N'بيمەي تەواوكەرەوە',N'التأمين التكميلي','PAY',3,''


exec FMK.spAddLookup 'AdjustmentType',0,'','','',N'','PAY',0,''
exec FMK.spAddLookup 'AdjustmentType',1,'تعديل ماهانه','Monthly Adjustment',N'هاوسەنگي مانگانە',N'التعديل الشهري','PAY',1,''
exec FMK.spAddLookup 'AdjustmentType',2,'تعديل سالانه','Annual Adjustment',N'هاوسەنگي ساڵانە',N'التعديل السنوي','PAY',2,''
exec FMK.spAddLookup 'AdjustmentType',3,'بدون تعديل','No Adjustment',N'بەبێ هاوسەنگي',N'دون تعديل','PAY',3,''
exec FMK.spAddLookup 'AdjustmentType',4,'تعديل ماهانه در سطح ماه','Monthly Adjustment Base On Month',N'بەبێ هاوسەنگي',N'تعديل شهري على مستوى الشهر','PAY',4,''


Delete From Fmk.[Lookup] where [Type] = 'PrimaryTaxPayerType'
exec FMK.spAddLookup 'PrimaryTaxPayerType',1,'شخص حقيقي','Individual',N'كەسي حەقێقي',N'الشخص الحقيقي','PAY',1,''
exec FMK.spAddLookup 'PrimaryTaxPayerType',2,'شخص حقوقي','Company',N'كەسي حقۆقي',N'شخص قانوني','PAY',2,''



exec FMK.spAddLookup 'SecondaryTaxPayerType',1,'وزارت خانه', 'Ministry',N'وەزارەتخانە',N'وزارة', 'PAY',1,''
exec FMK.spAddLookup 'SecondaryTaxPayerType',2,'موسسه دولتي', 'Governmental Institute',N'رێكخراوەي حكوومي', N'مؤسسة حكومية','PAY',2,''
exec FMK.spAddLookup 'SecondaryTaxPayerType',3,'شركت دولتي', 'Governmental Company',N'كۆمپانياي حكوومي',N'الشركة الحومية','PAY',3,''
exec FMK.spAddLookup 'SecondaryTaxPayerType',4,'ساير دستگاه هاي دولتي', 'Other Governmental Systems',N'فەرمانگەكاني‌تري حكوومي', N'نظامات حكومية أخرى','PAY',4,''
exec FMK.spAddLookup 'SecondaryTaxPayerType',5,'نهادهاي عمومي غير دولتي', 'Non-Governmental Organizations',N'رێكخراوە گشتيە ناحكووميەكان', N'الهيئات العامة و المنظمات غير الحكومية', 'PAY',5,''
exec FMK.spAddLookup 'SecondaryTaxPayerType',6,'بخش خصوصي', 'Private Section',N'بەشي ئەهلي', N'قطاع خاص', 'PAY',6,''
exec FMK.spAddLookup 'SecondaryTaxPayerType',7,'ساير پرداخت كنندگان حقوق', 'Other Employers',N'پێدەرەكاني‌تري مووچە', N'آخر دافعي الرواتب ', 'PAY',7,''

exec FMK.spAddLookup 'SexType',1,'مرد','Male',N'پياو',N'رجل','PAY',1,''
exec FMK.spAddLookup 'SexType',2,'زن','Female',N'ژن',N'امرأة','PAY',2,''

if ((Select count(0) from Fmk.Lookup Where  Type = 'GuildType') < 19)
begin    
    delete from Fmk.Lookup Where Type =  'GuildType'   
    update Pay.Job Set GuildType = GuildType-1 Where GuildType is not null
end    
exec FMK.spAddLookup 'GuildType',0,'ساير','Other',N'ديكە',N'آخر','PAY',1,''
exec FMK.spAddLookup 'GuildType',1,'اداري مالي','Official&Financial',N'ئيداري ماڵيي',N'الإدارة المالية','PAY',2,''
exec FMK.spAddLookup 'GuildType',2,'آموزشي فرهنگي','Cultural&Didactic',N'راهێنانيي فەرهەنگي',N'التعليم الثقافي','PAY',3,''
exec FMK.spAddLookup 'GuildType',3,'امور اجتماعي','Social Tasks',N'بابەتە كۆمەڵايەتيەكان',N'الشؤون الاجتماعية','PAY',4,''
exec FMK.spAddLookup 'GuildType',4,'فناوري اطلاعات','Information Technology',N'تەكنۆلۆژياي زانياري',N'تكنولوجيا المعلومات','PAY',5,''
exec FMK.spAddLookup 'GuildType',5,'بهداشت و درمان','Hygiene&Treatment',N'تەندروستي و دەرمان',N'صحة و علاج','PAY',6,''
exec FMK.spAddLookup 'GuildType',6,'فني مهندسي','Engineering',N'تەكنيكي ئەندازياري',N'التقنية و الهندسة','PAY',7,''
exec FMK.spAddLookup 'GuildType',7,'خدمات','Services',N'خزمەتگوزارييەكان',N'الخدمات','PAY',8,''
exec FMK.spAddLookup 'GuildType',8,'كشاورزي و محيط زيست','Agronomy&Nature',N'كشتوكاڵ و ژينگە',N'الزراعة و البيئة','PAY',9,''
exec FMK.spAddLookup 'GuildType',9,'بازاريابي و فروش','Marketing&Sales',N'بازاڕدۆزينەوە و فرۆش',N'التسويق و المبيعات','PAY',10,''
exec FMK.spAddLookup 'GuildType',10,'حراست و نگهباني','Guarding',N'پاراستن',N'حراست و نگهباني','PAY',11,''
exec FMK.spAddLookup 'GuildType',11,'كارگري','Labor',N'كرێكاري',N'العمل','PAY',12,''
exec FMK.spAddLookup 'GuildType',12,'ترابري','Transport',N'گواستنەوەيي',N'النقل','PAY',13,''
exec FMK.spAddLookup 'GuildType',13,'توليدي','Production',N'وەبەرهێنان',N'ضبط الجودة','PAY',14,''
exec FMK.spAddLookup 'GuildType',14,'كنترل كيفي','QualityControl',N'كۆنترۆڵي كوالێتي',N'بحث','PAY',15,''
exec FMK.spAddLookup 'GuildType',15,'تحقيقات','Research',N'توێژينەوە',N'التخزين','PAY',16,''
exec FMK.spAddLookup 'GuildType',16,'انبارداري','Storekeeping',N'كۆگا داري',N'التخزين','PAY',17,''
exec FMK.spAddLookup 'GuildType',17,'قضات','Judgment',N'دادوەرەكان',N'القضاة','PAY',18,''
exec FMK.spAddLookup 'GuildType',18,'اعضاي هيئت علمي دانشگاه ها و موسسات آموزش عالي','University Teaching',N'ئەنداماني لێژنەي زانستيي زانكۆكان و رێكخراوەكاني خوێندني باڵا',N'أعضاء هيئة التدريس في الجامعات و مؤسسات التعليم العالي','PAY',19,''


exec FMK.spAddLookup 'EmployeeStatus',1,'عادي','Normal',N' ',N'عادي','PAY',1,''
exec FMK.spAddLookup 'EmployeeStatus',2,'جانباز','Handicapped In War',N' ',N'معاق','PAY',2,''
exec FMK.spAddLookup 'EmployeeStatus',3,'فرزند شهيد','Martyr''s Child',N' ',N'ابن شهيد','PAY',3,''
exec FMK.spAddLookup 'EmployeeStatus',4,'آزاده','Former PoW',N' ',N'الحرّ','PAY',4,''
exec FMK.spAddLookup 'EmployeeStatus',5,'نيروهاي مسلح(نظامي يا انتظامي)','Armed Forces(Military Or Police)',N' ',N'القوات المسلحة (قوات الأمن و القوات العسكرية)','PAY',5,''
exec FMK.spAddLookup 'EmployeeStatus',6,'ساير مشمولين بند 14 ماده 91','Others Subject To Clause 14 Art 91',N' ',N'سائر المشمولين بالبند 14 من المادة 91','PAY',6,''
exec FMK.spAddLookup 'EmployeeStatus',7,'اتباع خارجي مشمول قانون اجتناب از اخذ ماليات مضاعف','Foreign Nationals Subject To Double Taxation Avoidance',N' ',N'الرعايا الأجانب المشمولون بقانون تجنب استيفاء الضرائب المضاعفة','PAY',7,''
exec FMK.spAddLookup 'EmployeeStatus',10,'مشمولين ماده 25 قانون حمايت از حقوق معلولان','Persons with Disabilities Subject To Art 25',N'مشمولين ماده 25 قانون حمايت از حقوق معلولان',N'مشمولين ماده 25 قانون حمايت از حقوق معلولان','PAY',8,''

exec FMK.spAddLookup 'TaxType',1,'حقوق','Salery',N' ',N'','PAY',1,''
exec FMK.spAddLookup 'TaxType',2,'عيدي','New Year Bonus',N' ',N'','PAY',2,''