If Object_ID('POM.vwCommercialOrder') Is Not Null
	Drop View POM.vwCommercialOrder
GO
CREATE VIEW POM.vwCommercialOrder
AS
SELECT     
	  CO.CommercialOrderId,  CO.DlRef, 
      CO.Number, CO.Date, CO.ValidityDate, CO.Description, 	  
      Co.PurchaseOrderRef, PO.date PurchaseOrderDate, PO.DlCode PurchaseOrderNumber, 
	  po.DLTitle PurchaseOrderDlTitle, po.DLTitle_En PurchaseOrderDlTitle_En,
	  
	  CO.SharingMethod,
	  
	  DL.Code AS DlCode, DL.Title AS DlTitle, DL.Title_En AS DLTitle_En, 
	  
	  CO.IncustomsRef, InC.Code AS InCustomsCode, InC.Title AS InCustomsTitle, InC.Title_En AS InCustomsTitle_En, 
	  CO.OutcustomsRef, OutC.Code AS OutCustomsCode, OutC.Title AS OutCustomsTitle, OutC.Title_En AS OutCustomsTitle_En, 
	  CO.LoadingPlace,
	  CO.OriginCountryRef, l.Title OriginCountryTitle, l.Title_en OriginCountryTitle_En,

	  CO.SlRef, Account.FullCode AS AccountCode,     Account.Title AS AccountTitle, Account.Title_En AS AccountTitle_En, 
	  CO.RegisterFee, 
	  CO.FiscalYearRef, 
	  co.PaymentHeaderRef , ph.Number PaymentNumber, ph.Date PaymentDate, 
	  ISNULL(CO.RegisterFee,0) - ISNULL(Ph.TotalAmountInBaseCurrency,0) - ISNULL(Ph.Discount,0)  Remaining,
	  CO.VoucherRef, ACC.Voucher.Number AS VoucherNumber,  ACC.Voucher.Date AS VoucherDate,
	  CO.Creator, UC.Name AS CreatorName, UC.Name_En AS CreatorName_En,	CO.LastModifier, ULM.Name AS LastModifierName, ULM.Name_En AS LastModifierName_En,
	  CO.LastModificationDate, CO.CreationDate, CO.Version
FROM  POM.CommercialOrder CO INNER JOIN
	  POM.vwPurchaseOrder PO ON  Co.PurchaseOrderRef = po.purchaseOrderID	inner join 
      ACC.DL DL ON CO.DlRef = DL.DLId LEFT OUTER JOIN	  
	  POM.Customs InC ON CO.IncustomsRef = inC.CustomsId LEFT OUTER JOIN	  
	  POM.Customs OutC ON CO.OutcustomsRef = OutC.CustomsId LEFT OUTER JOIN	 
	  GNR.Location L ON CO.OriginCountryRef = L.LocationId LEFT OUTER JOIN	       
	  FMK.[User] AS UC ON CO.Creator = UC.UserID LEFT OUTER JOIN
	  FMK.[User] AS ULM ON CO.LastModifier = ULM.UserID LEFT OUTER JOIN
      ACC.Voucher ON CO.VoucherRef = ACC.Voucher.VoucherId LEFT OUTER JOIN
      ACC.vwAccount AS Account ON CO.SlRef = Account.AccountId LEFT OUTER JOIN
	  RPA.PaymentHeader PH On PH.PaymentHeaderId = Co.PaymentHeaderRef

      