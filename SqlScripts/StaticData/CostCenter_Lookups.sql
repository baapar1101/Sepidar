exec FMK.spAddLookup 'CostCenterType',1,'توليد','Production',N'وەبەرهێنان',N'الإنتاج','RPA',1,''
exec FMK.spAddLookup 'CostCenterType',2,'اداري و تشكيلاتي','Ministerial and Institutional',N'ئيداري و رێكخراوەيي',N'إداري','RPA',2,''
DELETE FMK.[Lookup] WHERE [Type] = 'CostCenterType' AND Code = 3
exec FMK.spAddLookup 'CostCenterType',4,'خدماتي و عمومي','Service and Public',N'خزمەتگوزاريي و گشتيي',N'الخدمة و العامة','RPA',4,''

