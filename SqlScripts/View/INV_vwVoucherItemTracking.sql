IF OBJECT_ID('INV.vwVoucherItemTracking') IS NOT NULL
	DROP VIEW INV.vwVoucherItemTracking
GO
CREATE VIEW INV.vwVoucherItemTracking
AS
with cte As (
	SELECT   A.VoucherItemTrackingID
			,A.Serial
			,Number = CASE 
			               WHEN A.InvoiceItemRef                   IS NOT NULL THEN BH.Number
			               WHEN A.ReturnedInvoiceItemRef           IS NOT NULL THEN CH.Number
			               WHEN A.InventoryReceiptItemRef          IS NOT NULL THEN DH.Number
			               WHEN A.InventoryDeliveryItemRef         IS NOT NULL THEN EH.Number
			          END
			,Date  = CASE 
			               WHEN A.InvoiceItemRef                   IS NOT NULL THEN BH.Date
			               WHEN A.ReturnedInvoiceItemRef           IS NOT NULL THEN CH.Date
			               WHEN A.InventoryReceiptItemRef          IS NOT NULL THEN DH.Date
			               WHEN A.InventoryDeliveryItemRef         IS NOT NULL THEN EH.Date
			          END
			,DLRef  = CASE 
			               WHEN A.InvoiceItemRef                   IS NOT NULL THEN PBH.DLRef
			               WHEN A.ReturnedInvoiceItemRef           IS NOT NULL THEN PCH.DLRef
			               WHEN A.InventoryReceiptItemRef          IS NOT NULL THEN DH.DelivererDLRef
			               WHEN A.InventoryDeliveryItemRef         IS NOT NULL THEN EH.ReceiverDLRef
			          END
			,ItemRef  = CASE
			               WHEN A.InvoiceItemRef                   IS NOT NULL THEN BI.ItemRef
			               WHEN A.ReturnedInvoiceItemRef           IS NOT NULL THEN CI.ItemRef
			               WHEN A.InventoryReceiptItemRef          IS NOT NULL THEN DI.ItemRef
			               WHEN A.InventoryDeliveryItemRef         IS NOT NULL THEN EI.ItemRef
			          END
			,VoucherType = CASE
			               WHEN A.InvoiceItemRef                   IS NOT NULL THEN 1
			               WHEN A.ReturnedInvoiceItemRef           IS NOT NULL THEN 2
			               WHEN A.InventoryReceiptItemRef          IS NOT NULL AND DH.IsReturn = 0 THEN 3
			               WHEN A.InventoryReceiptItemRef          IS NOT NULL AND DH.IsReturn = 1 THEN 4
			               WHEN A.InventoryDeliveryItemRef         IS NOT NULL AND EH.IsReturn = 0 THEN 5
			               WHEN A.InventoryDeliveryItemRef         IS NOT NULL AND EH.IsReturn = 1 THEN 6
			          END
			,IsReturn = CASE
			               WHEN A.InvoiceItemRef                   IS NOT NULL THEN cast(0 as bit)
			               WHEN A.ReturnedInvoiceItemRef           IS NOT NULL THEN cast(1 as bit)
			               WHEN A.InventoryReceiptItemRef          IS NOT NULL THEN DH.IsReturn
			               WHEN A.InventoryDeliveryItemRef         IS NOT NULL THEN EH.IsReturn
			          END
			,A.InvoiceItemRef
			,A.ReturnedInvoiceItemRef
			,A.InventoryReceiptItemRef
			,A.InventoryDeliveryItemRef
	FROM      INV.VoucherItemTracking    A
	LEFT JOIN SLS.InvoiceItem           BI  ON A.InvoiceItemRef                   = BI.InvoiceItemID
	LEFT JOIN SLS.Invoice               BH  ON BI.InvoiceRef                      = BH.InvoiceID
	LEFT JOIN GNR.Party                 PBH ON BH.CustomerPartyRef                = PBH.PartyId

	LEFT JOIN SLS.ReturnedInvoiceItem   CI  ON A.ReturnedInvoiceItemRef           = CI.ReturnedInvoiceItemID
	LEFT JOIN SLS.ReturnedInvoice       CH  ON CI.ReturnedInvoiceRef              = CH.ReturnedInvoiceID
	LEFT JOIN GNR.Party                 PCH ON CH.CustomerPartyRef                = PCH.PartyId

	LEFT JOIN INV.InventoryReceiptItem  DI  ON A.InventoryReceiptItemRef          = DI.InventoryReceiptItemID
	LEFT JOIN INV.InventoryReceipt      DH  ON DI.InventoryReceiptRef             = DH.InventoryReceiptID

	LEFT JOIN INV.InventoryDeliveryItem EI  ON A.InventoryDeliveryItemRef         = EI.InventoryDeliveryItemID
	LEFT JOIN INV.InventoryDelivery     EH  ON EI.InventoryDeliveryRef            = EH.InventoryDeliveryID
)
,voucherType AS (
	select a.Code, Title_fa = a.Title , Title_en = b.Title , Title_ku = c.Title , Title_ar = d.Title 
	from fmk.lookup a
	left join fmk.lookuplocale b on a.LookupID = b.LookupRef and b.LocaleName = 'en'
	left join fmk.lookuplocale c on a.LookupID = c.LookupRef and c.LocaleName = 'ku'
	left join fmk.lookuplocale d on a.LookupID = d.LookupRef and d.LocaleName = 'ar'
	where Type like '%VoucherItemTrackingVoucherType%'
)
	SELECT  A.*,
			D.Code     DLCode, 
			D.Title    DLTitle, 
			D.Title_En DLTitle_En,

			I.Code     ItemCode, 
			I.Title    ItemTitle, 
			I.Title_En ItemTitle_En, 

			I.UnitRef  ItemUnitRef, 
			U.Title    UnitTitle, 
			U.Title_En UnitTitle_En,

			VoucherTypeTitle_fa = VT.Title_fa , 
			VoucherTypeTitle_en = VT.Title_en , 
			VoucherTypeTitle_ku = VT.Title_ku , 
			VoucherTypeTitle_ar = VT.Title_ar
	FROM       cte      A
	LEFT  JOIN INV.Item I ON A.ItemRef = I.ItemID 
	LEFT  JOIN INV.Unit U ON I.UnitRef = U.UnitID
	LEFT  JOIN ACC.DL   D ON A.DLRef   = D.DLId 
	LEFT  JOIN voucherType VT ON A.VoucherType = VT.Code 
GO
