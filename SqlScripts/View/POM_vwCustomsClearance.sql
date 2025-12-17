If Object_ID('POM.vwCustomsClearance') Is Not Null
	Drop View POM.vwCustomsClearance
GO
CREATE VIEW POM.vwCustomsClearance
AS
  SELECT CC.[CustomsClearanceID]
      , CC.[Number]
      , CC.[Date]
      , CC.[DLRef], DL.Code DlCode, Dl.Title DlTitle, DL.Title_En DlTitle_En
      , CC.[SLRef], SL.FullCode SLCode, Sl.Title SLTitle, Sl.Title_En SlTitle_En
      , CC.[InCustomsRef], InC.Code InCustomsCode, InC.Title InCustomsTitle, InC.Title_En InCustomsTitle_En
      , CC.[AssessCustomsRef], AssC.Code AssessCustomsCode, AssC.Title AssessCustomsTitle, AssC.Title_En AssessCustomsTitle_En
      , CC.[OriginCountryRef], l.Title OriginCountryTitle, l.Title_en OriginCountryTitle_En
      , CC.[CurrencyRef], C.Title AS CurrencyTitle, C.Title_En AS CurrencyTitle_En, C.PrecisionCount AS CurrencyPrecisionCount
      , CC.[Currencyrate]
      , CC.[Description]
      , CC.[Amount]
      , CC.[AmountInBaseCurrency]
      , CC.[CustomsCost]
      , CC.[Tax]
      , CC.[Duty]
      , CC.[NetPrice]
      , CC.[FiscalYearRef]
      , CC.[VoucherRef], V.Number AS VoucherNumber,  V.Date AS VoucherDate
      , CC.[PaymentHeaderRef], ph.Number PaymentNumber, ph.Date PaymentDate
      , CC.[Creator], UC.Name AS CreatorName, UC.Name_En AS CreatorName_En
      , CC.[CreationDate]
      , CC.[LastModifier] , ULM.Name AS LastModifierName, ULM.Name_En AS LastModifierName_En
      , CC.[LastModificationDate]
      , CC.[Version]
  FROM [POM].[CustomsClearance] CC
	INNER JOIN Acc.Dl DL On CC.DLRef = Dl.DLId
	INNER JOIN GNR.Currency C ON CC.CurrencyRef = C.CurrencyID 
	LEFT OUTER JOIN Acc.vwAccount SL ON cc.SLRef = sl.AccountId
	LEFT OUTER JOIN POM.Customs InC ON CC.IncustomsRef = inC.CustomsId 
	LEFT OUTER JOIN POM.Customs AssC On CC.AssessCustomsRef = AssC.CustomsId 
	LEFT OUTER JOIN	GNR.Location L ON CC.OriginCountryRef = L.LocationId 
	LEFT OUTER JOIN ACC.Voucher V ON CC.VoucherRef = V.VoucherId 
	LEFT OUTER JOIN RPA.PaymentHeader PH On PH.PaymentHeaderId = CC.PaymentHeaderRef
	LEFT OUTER JOIN	FMK.[User] AS UC ON CC.Creator = UC.UserID 
	LEFT OUTER JOIN FMK.[User] AS ULM ON CC.LastModifier = ULM.UserID 