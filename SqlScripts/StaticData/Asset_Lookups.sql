
/*AssetState*/
exec FMK.spAddLookup 'AssetState',1,'جاري','Current',N'',N'','AST',1,''
exec FMK.spAddLookup 'AssetState',2,'بلا استفاده','Unused',N'',N'','AST',2,''
exec FMK.spAddLookup 'AssetState',3,'فروش رفته','Sold',N'',N'','AST',3,''
exec FMK.spAddLookup 'AssetState',4,'اسقاط شده','Salvaged',N'',N'','AST',4,''
exec FMK.spAddLookup 'AssetState',5,'حذف شده','Deleted',N'',N'','AST',5,''

/*CostPartType*/
exec FMK.spAddLookup 'CostPartType',1,'تحصيل','Acquisition',N'',N'','AST',1,''
exec FMK.spAddLookup 'CostPartType',2,'گسترش و الحاق','Extend',N'',N'','AST',2,''
exec FMK.spAddLookup 'CostPartType',3,'تعميرات اساسي','IncreaseValue',N'',N'','AST',3,''

/*CostPartDepreciationState*/

exec FMK.spAddLookup 'CostPartDepreciationState',1,'مستهلك شده','Depreciated',N'',N'','AST',1,''
exec FMK.spAddLookup 'CostPartDepreciationState',2,'مستهلك نشده','Not depreciated',N'',N'','AST',2,''

/*AquisitionReceiptType*/
exec FMK.spAddLookup 'AcquisitionReceiptType',1,'خريد داخلي','Domestic Purchase',N'',N'','AST',1,''
exec FMK.spAddLookup 'AcquisitionReceiptType',2,'ساخت','Product',N'',N'','AST',2,''
exec FMK.spAddLookup 'AcquisitionReceiptType',3,'ساير','Other',N'',N'','AST',3,''
exec FMK.spAddLookup 'AcquisitionReceiptType',4,'استقرار','Initial',N'',N'','AST',4,''
exec FMK.spAddLookup 'AcquisitionReceiptType',5,'خريد وارداتي','Import Purchase',N'',N'','AST',5,''

/*PurchaseType*/
exec FMK.spAddLookup 'PurchaseType',1,'خريد داخلي','Domestic Purchase',N'',N'','AST',1,''
exec FMK.spAddLookup 'PurchaseType',2,'خريد وارداتي','Import Purchase',N'',N'','AST',2,''


/*TransactionType*/

exec FMK.spAddLookup 'AssetTransactionType',1,'تحصيل دارايي','Acquisition Receipt',N'',N'','AST',1,''
exec FMK.spAddLookup 'AssetTransactionType',2,'استقرار','Initial',N'',N'','AST',2,''
exec FMK.spAddLookup 'AssetTransactionType',3,'نقل و انتقال','Transport',N'',N'','AST',3,''
exec FMK.spAddLookup 'AssetTransactionType',4,'حذف','Elimination',N'',N'','AST',4,''
exec FMK.spAddLookup 'AssetTransactionType',5,'فروش','Sale',N'',N'','AST',5,''
exec FMK.spAddLookup 'AssetTransactionType',6,'اسقاط','Salvage',N'',N'','AST',6,''
exec FMK.spAddLookup 'AssetTransactionType',7,'بلااستفاده','Unused',N'',N'','AST',7,''
exec FMK.spAddLookup 'AssetTransactionType',8,'استفاده مجدد','ReUsed',N'',N'','AST',8,''
exec FMK.spAddLookup 'AssetTransactionType',9,'تغيير نرخ و روش','Change Depreciation Method',N'',N'','AST',9,''
exec FMK.spAddLookup 'AssetTransactionType',10,'مخارج پس از تحصيل','Repair',N'',N'','AST',10,''
exec FMK.spAddLookup 'AssetTransactionType',99,'محاسبه استهلاك','Depreciation Calculation',N'',N'','AST',99,''


/*AssetItemTypeRelatedToPurchaseInvoice*/

exec FMK.spAddLookup 'AssetRelatedItemType',1,'تحصيل','Aquisition',N'',N'','AST',1,''
exec FMK.spAddLookup 'AssetRelatedItemType',2,'تعمير','Repair',N'',N'','AST',2,''


/*SettlementType*/
exec FMK.spAddLookup 'AssetSaleSettlementType',1,'نقدي','Cash',N'نەختي',N'النقد','AST',1,''
exec FMK.spAddLookup 'AssetSaleSettlementType',2,'نسيه','Credit',N'قەڕز',N'ائتمان','AST',2,''
exec FMK.spAddLookup 'AssetSaleSettlementType',3,'نقدي/نسيه','Cash/Credit',N'نەختي⁄قەڕز',N'النقد/ائتمان','AST',3,''
