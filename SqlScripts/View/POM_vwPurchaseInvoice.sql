
/****** Object:  View [POM].[vwPurchaseInvoice] ******/
IF OBJECT_ID('POM.vwPurchaseInvoice') IS NOT NULL
  DROP VIEW POM.[vwPurchaseInvoice]
GO
CREATE VIEW [POM].[vwPurchaseInvoice]
AS
SELECT
  PI.PurchaseInvoiceID
 ,PI.VendorDLRef
 ,VendorDL.Code AS VendorDLCode
 ,VendorDL.Title AS VendorDLTitle
 ,VendorDL.Title_En AS VendorDLTitle_En
 ,PI.[PurchasingAgentPartyRef]
	,Agent.DlCode AS PurchasingAgentDlCode, Agent.DlTitle AS PurchasingAgentDlTitle, Agent.DlTitle_En AS PurchasingAgentDlTitle_En
 ,PI.PurchaseOrderRef
 ,po.DLCode AS PurchaseOrderNumber
 ,PI.DLRef
 ,DL.Code AS DLCode
 ,DL.Title AS DLTitle
 ,DL.Title_En AS DLTitle_En
 ,PI.Number
 ,PI.PurchaseNumber AS PurchaseNumber
 ,PI.[Date]
 ,PI.CurrencyRef
 ,PI.Description
 ,C.Title AS CurrencyTitle
 ,C.Title_En AS CurrencyTitle_En
 ,C.PrecisionCount AS CurrencyPrecisionCount
 ,PI.CurrencyRate
 ,PI.Price
 ,PI.PriceInBaseCurrency
 ,PI.NetPrice
 ,PI.NetPriceInBaseCurrency
 ,PI.Discount
 ,PI.DiscountInBaseCurrency
 ,PI.Addition
 ,PI.AdditionInBaseCurrency
 ,PI.FiscalYearRef
 ,pi.BasePurchaseInvoiceRef
 ,PII.Number AS BaseInvoiceNumber
 ,BaseDL.Code As  BaseDLCode
 ,BaseDL.Title As BaseDLTitle
 ,PI.[CanTransferNextPeriod] 
 ,PI.[IsInitial] 
 ,PI.PaymentHeaderRef
 ,PH.Number PaymentNumber
 ,PH.Date PaymentDate
 ,PI.Creator
 ,U.Name AS CreatorName
 ,U.Name_En AS CreatorName_En
 ,PI.CreationDate
 ,PI.LastModifier
 ,PI.LastModificationDate
 ,PI.[Version]
FROM POM.PurchaseInvoice AS PI
INNER JOIN ACC.DL VendorDL
  ON PI.VendorDLRef = VendorDL.DLId
INNER JOIN ACC.DL DL
  ON PI.DLRef = DL.DLId
INNER JOIN POM.vwPurchaseOrder po
  ON PI.PurchaseOrderRef = po.PurchaseOrderID
INNER JOIN GNR.Currency C
  ON PI.CurrencyRef = C.CurrencyID
LEFT JOIN FMK.[User] AS U
  ON PI.Creator = U.UserID
LEFT JOIN POM.PurchaseInvoice AS PII
  ON PI.BasePurchaseInvoiceRef = PII.PurchaseInvoiceID
LEFT JOIN ACC.DL AS BaseDL
  ON PII.DLRef = BaseDL.DLId
LEFT JOIN RPA.PaymentHeader AS PH
ON PI.PaymentHeaderRef = PH.PaymentHeaderId
LEFT JOIN GNR.[vwParty] AS Agent
ON PI.[PurchasingAgentPartyRef] = Agent.PartyID 
GO