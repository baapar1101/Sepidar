If Object_ID('SLS.vwInvoice') Is Not Null
	Drop View SLS.vwInvoice
GO

CREATE VIEW SLS.vwInvoice
AS
SELECT     I.InvoiceId, I.CustomerPartyRef, P.DLTitle AS CustomerPartyName, P.DLTitle_En AS CustomerPartyName_En, P.DLRef AS CustomerPartyDLRef,
                      P.DLCode AS CustomerPartyDLCode, P.DiscountRate AS DiscountOnCustomer, P.CustomerGroupingRef, P.CustomerGroupingTitle, P.CustomerGroupingTitle_En,P.CustomerGroupingCode,
					  I.SaleTypeRef,I.SignatureRef, S.Number AS SaleTypeNumber, S.Title AS SaleTypeTitle, S.SaleTypeMarket,
                      S.Title_En AS SaleTypeTitle_En, I.PartyAddressRef, PA.Address AS PartyAddress, PA.Adress_En AS PartyAddress_En, I.Number, I.QuotationRef,
                      Q.Number AS QuotationNumber, I.OrderRef, O.Number AS OrderNumber, I.Date, I.CurrencyRef, C.Title AS CurrencyTitle, C.Title_En AS CurrencyTitle_En,
                      I.DeliveryLocationRef, DLL.Title AS DeliveryLocationTitle, DLL.Title_En AS DeliveryLocationTitle_En, I.ShouldControlCustomerCredit,
                      C.PrecisionCount AS CurrencyPrecisionCount, I.SLRef, A.FullCode AS SLCode, A.Title AS SLTitle, A.Title_En AS SLTitle_En, I.State, I.Price,
                      I.PriceInBaseCurrency, I.Discount, I.DiscountInBaseCurrency, I.Addition, I.AdditionInBaseCurrency, I.Tax, I.TaxInBaseCurrency, I.Duty,
                      I.AdditionFactor_VatEffective, I.AdditionFactorInBaseCurrency_VatEffective, I.AdditionFactor_VatIneffective, I.AdditionFactorInBaseCurrency_VatIneffective,
					  ISNULL(I.AdditionFactor_VatEffective, 0) + ISNULL(I.AdditionFactor_VatIneffective, 0) AS AdditionFactor,
					  ISNULL(I.AdditionFactorInBaseCurrency_VatEffective, 0) + ISNULL(I.AdditionFactorInBaseCurrency_VatIneffective, 0) AS AdditionFactorInBaseCurrency,
                      I.DutyInBaseCurrency, I.NetPrice, I.NetPriceInBaseCurrency, I.Rate, I.Version, I.Creator, I.CreationDate, I.LastModifier, I.LastModificationDate,
                      I.FiscalYearRef, I.VoucherRef, V.Number AS VoucherNumber, V.Date AS VoucherDate,
                      P.IdentificationCode AS CustomerIdentificationCode, P.EconomicCode AS CustomerEconomicCode, P.PassportNumber AS CustomerPassportNumber, ll.State AS CustomerState, ll.State_En AS CustomerState_En, ll.City AS CustomerCity, ll.City_En AS CustomerCity_En,
                      ll.Village AS CustomerVillage, PA.ZipCode AS CustomerZipCode, PA.BranchCode AS CustomerBranchCode,
                          (SELECT     TOP (1) Phone
                             FROM         GNR.PartyPhone
                         WHERE     (P.PartyId = PartyRef) AND (Type = 1 OR IsMain = 1) ORDER BY IsMain DESC) AS CustomerPhone,
                      (SELECT     TOP (1) Phone
                         FROM         GNR.PartyPhone
                         WHERE     (P.PartyId = PartyRef) AND (Type = 5)) AS CustomerFax,
					  P.EMail CustomerEMail, p.IsInBlacklist AS CustomerIsInBlacklist,
					  cUsr.Name CreatorName, cUsr.Name_En CreatorName_En,
					  mUsr.Name ModifierName, mUsr.Name_En ModifierName_En, I.BaseOnInventoryDelivery,
					  I.CustomerRealName, I.CustomerRealName_En, null BillRemainder, null VendorRemainder,
					  null CustomerRemainder,
					  IRemaining.RemainingAmount, IRemaining.TotalReceivedAmount
					, [PPA].[AreaTitle]
					, [PPA].[AreaTitle_En]
					, [PPA].[PathTitle]
					, [PPA].[PathTitle_En]
					,I.[Guid]
					,I.[Description]
					,I.[AgreementRef]
					,DA.Title AS Agreements
					,TaxPayerBillIssueDateTime
					,SettlementType
                    ,CASE
                        WHEN MainTPB.InvoiceRef IS NULL THEN 0
                        ELSE 1
                    END AS HasSendedMainBill
                    ,CASE
                        WHEN ManualTPBs.InvoiceRef IS NULL THEN 0
                        ELSE 1
                    END AS HasManualBill
FROM         SLS.Invoice AS I
		INNER JOIN GNR.vwParty AS P ON I.CustomerPartyRef = P.PartyId
		INNER JOIN GNR.DeliveryLocation AS DLL ON I.DeliveryLocationRef=DLL.DeliveryLocationID
		INNER JOIN SLS.fnInvoiceRemaining() IRemaining ON IRemaining.InvoiceID = I.InvoiceID
		LEFT OUTER JOIN GNR.PartyAddress AS PA ON I.PartyAddressRef = PA.PartyAddressId
		LEFT OUTER JOIN GNR.Currency AS C ON I.CurrencyRef = C.CurrencyID
		LEFT OUTER JOIN SLS.Quotation AS Q ON I.QuotationRef = Q.QuotationId
		LEFT OUTER JOIN DST.[Order] AS O ON I.OrderRef = O.OrderId
		INNER JOIN ACC.vwAccount AS A ON I.SLRef = A.AccountId
		LEFT OUTER JOIN GNR.vwLocationList AS ll ON PA.LocationRef = ll.LocationId
		LEFT OUTER JOIN ACC.Voucher AS V ON I.VoucherRef = V.VoucherId
		LEFT OUTER JOIN SLS.SaleType AS S ON I.SaleTypeRef = S.SaleTypeId
		LEFT OUTER JOIN FMK.[User] as cUsr ON I.Creator = cUsr.UserID
		LEFT OUTER JOIN FMK.[User] as mUsr ON I.LastModifier = mUsr.UserID
		LEFT OUTER JOIN [DST].[vwPathPartyAddress] AS [PPA] ON [I].[PartyAddressRef] = [PPA].[PartyAddressRef]
		LEFT OUTER JOIN [DST].[Agreement] AS DA ON [I].[AgreementRef] = [DA].AgreementId
		LEFT OUTER JOIN (
		    SELECT
		        InvoiceRef = ISNULL(InvoiceRef, ExportServiceInvoiceRef)
		    FROM GNR.TaxPayerBill
		    WHERE ActionTypeIns = 1
		      AND [State] = 4
		      AND (InvoiceRef IS NOT NULL OR ExportServiceInvoiceRef IS NOT NULL)
		    GROUP BY
		        InvoiceRef, ExportServiceInvoiceRef
        ) AS MainTPB ON I.InvoiceId = MainTPB.InvoiceRef
        LEFT OUTER JOIN (
            SELECT
		        InvoiceRef = ISNULL(InvoiceRef, ExportServiceInvoiceRef)
		    FROM GNR.TaxPayerBill
		    WHERE MakingMethod = 2
		      AND (InvoiceRef IS NOT NULL OR ExportServiceInvoiceRef IS NOT NULL)
		    GROUP BY
		        InvoiceRef, ExportServiceInvoiceRef
        ) AS ManualTPBs ON ManualTPBs.InvoiceRef = I.InvoiceId
