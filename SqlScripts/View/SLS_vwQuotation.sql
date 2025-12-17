If Object_ID('SLS.vwQuotation') Is Not Null
	Drop View SLS.vwQuotation
GO
CREATE VIEW SLS.vwQuotation
AS
SELECT     Q.QuotationId, Q.CustomerPartyRef, P.DLTitle AS CustomerPartyName, P.DLTitle_En AS CustomerPartyName_En, P.DLRef AS CustomerPartyDLRef, 
                      P.DLCode AS CustomerPartyDLCode, P.DiscountRate AS DiscountOnCustomer, P.CustomerGroupingRef,P.CustomerGroupingTitle,
					  ISNULL(Q.CustomerRealName, P.DLTitle) CustomerRealName, ISNULL(Q.CustomerRealName_En,P.DLTitle_En) CustomerRealName_En,
                      Q.PartyAddressRef, PA.Address AS PartyAddress, S.SaleTypeMarket, Q.[Guid],
                      PA.Adress_En AS PartyAddress_En, Q.SaleTypeRef, S.Number AS SaleTypeNumber, S.Title AS SaleTypeTitle, S.Title_En AS SaleTypeTitle_En, Q.Number, Q.Date, Q.ExpirationDate, 
                      Q.CurrencyRef, C.Title AS CurrencyTitle, C.Title_En AS CurrencyTitle_En, C.PrecisionCount AS CurrencyPrecisionCount, Q.Price, 
                      Q.DeliveryLocationRef, DLL.Title AS DeliveryLocationTitle, DLL.Title_En AS DeliveryLocationTitle_En,
                      Q.PriceInBaseCurrency, Q.Discount, Q.Addition, Q.AdditionInBaseCurrency, Q.DiscountInBaseCurrency, Q.Tax, Q.TaxInBaseCurrency, Q.Duty, 
                      Q.DutyInBaseCurrency, Q.NetPrice, Q.NetPriceInBaseCurrency, Q.Rate, Q.Version, Q.Creator, Q.CreationDate, Q.LastModifier, Q.LastModificationDate, 
                      Q.Closed, Q.FiscalYearRef, P.IdentificationCode AS CustomerIdentificationCode, P.EconomicCode AS CustomerEconomicCode, 
					  Q.AdditionFactor_VatEffective, Q.AdditionFactorInBaseCurrency_VatEffective, Q.AdditionFactor_VatIneffective, Q.AdditionFactorInBaseCurrency_VatIneffective, 
					  ISNULL(Q.AdditionFactor_VatEffective, 0) + ISNULL(Q.AdditionFactor_VatIneffective, 0) AS AdditionFactor,
					  ISNULL(Q.AdditionFactorInBaseCurrency_VatEffective, 0) + ISNULL(Q.AdditionFactorInBaseCurrency_VatIneffective, 0) AS AdditionFactorInBaseCurrency,
                      ll.State AS CustomerState, ll.State_En AS CustomerState_En, ll.City AS CustomerCity, ll.City_En AS CustomerCity_En, ll.Village AS CustomerVillage, PA.ZipCode AS CustomerZipCode,
                          (SELECT     TOP (1) Phone
                             FROM         GNR.PartyPhone
                             WHERE     (P.PartyId = PartyRef) AND (Type = 1 OR IsMain = 1) ORDER BY IsMain DESC) AS CustomerPhone,
                          (SELECT     TOP (1) Phone
                             FROM         GNR.PartyPhone
                             WHERE     (P.PartyId = PartyRef) AND (Type = 5)) AS CustomerFax,
					  P.EMail CustomerEMail, '' BillRemainder, '' VendorRemainder,
					  '' CustomerRemainder, Q.ReceiptRef, Q.PaymentRef,
					  CASE 
						WHEN DATEDIFF(d, GETDATE(), ExpirationDate) < 0 THEN 0 
						ELSE DATEDIFF(d, GETDATE(), ExpirationDate)
					  END RemainedDaysToExpiration, U.Name CreatorName
FROM         SLS.Quotation AS Q INNER JOIN
                      GNR.Currency AS C ON C.CurrencyID = Q.CurrencyRef 
                      INNER JOIN GNR.vwParty AS P 
						ON Q.CustomerPartyRef = P.PartyId
					  INNER JOIN GNR.DeliveryLocation AS DLL 
						ON Q.DeliveryLocationRef=DLL.DeliveryLocationID 
					  INNER JOIN FMK.[User] U
						ON U.UserID = Q.Creator
					  LEFT OUTER JOIN GNR.PartyAddress AS PA 
						ON Q.PartyAddressRef = PA.PartyAddressId AND P.PartyId = PA.PartyRef AND P.PartyId = PA.PartyRef
					  LEFT OUTER JOIN GNR.vwLocationList AS ll
						ON PA.LocationRef = ll.LocationId
					  LEFT OUTER JOIN SLS.SaleType AS S
						ON Q.SaleTypeRef = S.SaleTypeId