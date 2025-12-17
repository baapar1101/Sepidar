If Object_ID('SLS.vwReturnedInvoice') Is Not Null	
	Drop View SLS.vwReturnedInvoice
GO
CREATE VIEW SLS.vwReturnedInvoice
AS
SELECT     RI.ReturnedInvoiceId, RI.CustomerPartyRef, P.DLTitle AS CustomerPartyName, P.DLTitle_En AS CustomerPartyName_En, RI.SignatureRef,
                      P.DLRef AS CustomerPartyDLRef, P.DLCode AS CustomerPartyDLCode, P.DiscountRate AS DiscountOnCustomer,P.CustomerGroupingRef,P.CustomerGroupingTitle, P.CustomerGroupingTitle_En, P.CustomerGroupingCode, 
                      RI.SaleTypeRef, S.Number AS SaleTypeNumber, S.SaleTypeMarket, RI.CustomerRealName, RI.CustomerRealName_En,
                      S.Title AS SaleTypeTitle, S.Title_En AS SaleTypeTitle_En, RI.PartyAddressRef, RI.Number, RI.QuotationRef, RI.Date, RI.CurrencyRef, 
                      C.Title AS CurrencyTitle, C.Title_En AS CurrencyTitle_En, C.PrecisionCount AS CurrencyPrecisionCount, RI.SLRef, A.FullCode AS SLCode, 
                      A.Title AS SLTitle, A.Title_En AS SLTitle_En, RI.PriceInBaseCurrency, RI.Price, RI.Discount, RI.DiscountInBaseCurrency, RI.Addition, 
                      RI.AdditionInBaseCurrency, RI.Tax, RI.TaxInBaseCurrency, RI.Duty, RI.DutyInBaseCurrency, RI.NetPrice, RI.NetPriceInBaseCurrency, RI.Rate, 
                      RI.Version, RI.Creator, RI.CreationDate, RI.LastModifier, RI.LastModificationDate, RI.FiscalYearRef, RI.VoucherRef, V.Number AS VoucherNumber, 
					  RI.AdditionFactor_VatEffective, RI.AdditionFactorInBaseCurrency_VatEffective, RI.AdditionFactor_VatIneffective, RI.AdditionFactorInBaseCurrency_VatIneffective, 
					  ISNULL(RI.AdditionFactor_VatEffective, 0) + ISNULL(RI.AdditionFactor_VatIneffective, 0) AS AdditionFactor,
					  ISNULL(RI.AdditionFactorInBaseCurrency_VatEffective, 0) + ISNULL(RI.AdditionFactorInBaseCurrency_VatIneffective, 0) AS AdditionFactorInBaseCurrency,
                      V.Date AS VoucherDate, PA.Address AS PartyAddress, PA.Adress_En AS PartyAddress_En, P.IdentificationCode AS CustomerIdentificationCode, 
                      P.EconomicCode AS CustomerEconomicCode, ll.State AS CustomerState, ll.State_En AS CustomerState_En, ll.City AS CustomerCity, ll.City_En AS CustomerCity_En, ll.Village AS CustomerVillage, 
                      PA.ZipCode AS CustomerZipCode,
                      (SELECT     TOP (1) Phone
                         FROM         GNR.PartyPhone
                         WHERE     (P.PartyId = PartyRef) AND (Type = 1)) AS CustomerPhone,
                      (SELECT     TOP (1) Phone
                         FROM         GNR.PartyPhone
                         WHERE     (P.PartyId = PartyRef) AND (Type = 5)) AS CustomerFax,
					  P.EMail CustomerEMail, RI.PaymentHeaderRef, PH.Number AS PaymentNumber,
					  PH.Date AS PaymentDate, IRemaining.TotalReceivedAmount AS PaymentTotalAmount, '' BillRemainder, '' VendorRemainder,
					  '' CustomerRemainder
                    , IRemaining.RemainingAmount
                    , IRemaining.TotalReceivedAmount
					, [PPA].[AreaTitle]
					, [PPA].[AreaTitle_En]
					, [PPA].[PathTitle]
					, [PPA].[PathTitle_En]
                    , RI.[Guid]
                    , RI.[Description],
					cUsr.Name CreatorName, cUsr.Name_En CreatorName_En, 
					  mUsr.Name ModifierName, mUsr.Name_En ModifierName_En
                    ,TaxPayerBillIssueDateTime
                    
FROM         SLS.ReturnedInvoice AS RI INNER JOIN
                      GNR.vwParty AS P ON RI.CustomerPartyRef = P.PartyId INNER JOIN 
                      SLS.fnReturnedInvoiceRemaining() IRemaining ON IRemaining.ReturnedInvoiceId = RI.ReturnedInvoiceId LEFT OUTER JOIN
                      ACC.Voucher AS V ON RI.VoucherRef = V.VoucherId LEFT OUTER JOIN
                      GNR.Currency AS C ON RI.CurrencyRef = C.CurrencyID LEFT OUTER JOIN
                      ACC.vwAccount AS A ON RI.SLRef = A.AccountId LEFT OUTER JOIN
                      SLS.SaleType AS S ON RI.SaleTypeRef = S.SaleTypeId LEFT OUTER JOIN
                      GNR.PartyAddress AS PA ON RI.PartyAddressRef = PA.PartyAddressId LEFT OUTER JOIN
                      GNR.vwLocationList AS ll ON PA.LocationRef = ll.LocationId LEFT OUTER JOIN
					  RPA.PaymentHeader PH ON PH.PaymentHeaderId = RI.PaymentHeaderRef LEFT OUTER JOIN 
                      [DST].[vwPathPartyAddress] AS [PPA] ON [RI].[PartyAddressRef] = [PPA].[PartyAddressRef]
					  		LEFT OUTER JOIN FMK.[User] as cUsr ON RI.Creator = cUsr.UserID 
							LEFT OUTER JOIN FMK.[User] as mUsr ON RI.LastModifier = mUsr.UserID
                      