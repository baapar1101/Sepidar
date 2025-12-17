If Object_ID('DST.vwOrder') Is Not Null
	Drop View DST.vwOrder
GO

CREATE VIEW [DST].[vwOrder]
AS
SELECT 
	O.OrderID, O.State, O.Number, O.Date, O.FiscalYearRef, O.DeliveryDate,O.SignatureRef,
	O.CurrencyRef,O.Description AS Description, C.Title AS CurrencyTitle, C.Title_En AS CurrencyTitle_En, C.PrecisionCount AS CurrencyPrecisionCount,
	O.BrokerPartyRef,BP.BrokerGroupingRef,BP.BrokerGroupingCode,BP.BrokerGroupingTitle,BP.BrokerGroupingTitle_En, BP.DLRef AS BrokerPartyDLRef, BP.DLTitle AS BrokerPartyName, BP.DLTitle_En AS BrokerPartyName_En, 
	BP.DLCode AS BrokerPartyDLCode, O.[Guid],
	O.CustomerPartyRef, 
		CP.DLRef AS CustomerPartyDLRef, CP.DLCode AS CustomerPartyDLCode, CP.DLTitle AS CustomerPartyName, 
		CP.DLTitle_En AS CustomerPartyName_En, CP.DiscountRate AS CustomerDiscountRate,
		CP.CustomerGroupingRef, CP.CustomerGroupingTitle, CP.DiscountRate AS DiscountOnCustomer,
		CP.IdentificationCode AS CustomerIdentificationCode, CP.EconomicCode AS CustomerEconomicCode, 
		(
			SELECT TOP (1) Phone
            FROM GNR.PartyPhone
            WHERE (CP.PartyId = PartyRef) AND (Type = 1 OR IsMain = 1) ORDER BY IsMain DESC
		) AS CustomerPhone, 
	O.CustomerPartyAddressRef, 
		CPA.LocationTitle AS CustomerPartyAddressTitle, CPA.LocationTitle_En AS CustomerPartyAddressTitle_En,
		CPA.Address AS CustomerPartyAddress, CPA.Adress_En AS CustomerPartyAddress_En,
		CPA.FullAddress AS CustomerPartyFullAddress, CPA.FullAddress_En AS CustomerPartyFullAddress_En,
		CPA.ZipCode AS CustomerPartyZipCode,
		PPA.PathCode AS CustomerPathCode, PPA.PathTitle AS CustomerPathTitle, PPA.PathTitle_En AS CustomerPathTitle_En,
		PPA.AreaCode AS CustomerAreaCode, PPA.AreaTitle AS CustomerAreaTitle, PPA.AreaTitle_En AS CustomerAreaTitle_En,
	O.SaleTypeRef, ST.Number AS SaleTypeNumber, ST.Title AS SaleTypeTitle, ST.SaleTypeMarket, ST.Title_En AS SaleTypeTitle_En,
	O.Price, O.PriceInBaseCurrency, O.Discount, O.DiscountInBaseCurrency, O.Addition, O.AdditionInBaseCurrency,
	O.Tax, O.TaxInBaseCurrency, O.Duty, O.DutyInBaseCurrency, O.NetPrice, O.NetPriceInBaseCurrency, O.Rate,
	O.AdditionFactor_VatEffective, O.AdditionFactorInBaseCurrency_VatEffective, O.AdditionFactor_VatIneffective, O.AdditionFactorInBaseCurrency_VatIneffective, 
	ISNULL(O.AdditionFactor_VatEffective, 0) + ISNULL(O.AdditionFactor_VatIneffective, 0) AS AdditionFactor,
	ISNULL(O.AdditionFactorInBaseCurrency_VatEffective, 0) + ISNULL(O.AdditionFactorInBaseCurrency_VatIneffective, 0) AS AdditionFactorInBaseCurrency,
	O.AgreementRef,DA.Title AS Agreements, O.Version, O.Creator, cUsr.Name CreatorName, cUsr.Name_En CreatorName_En, 
	O.LastModifier,	mUsr.Name ModifierName, mUsr.Name_En ModifierName_En,
	O.CreationDate, O.LastModificationDate,
	null BillRemainder, null VendorRemainder, null CustomerRemainder

FROM
	[DST].[Order] AS O
	INNER JOIN GNR.Currency AS C ON O.CurrencyRef = C.CurrencyID
	LEFT OUTER JOIN GNR.vwParty AS BP ON O.BrokerPartyRef = BP.PartyID
	LEFT OUTER JOIN GNR.vwParty AS CP ON O.CustomerPartyRef = CP.PartyID
	LEFT OUTER JOIN GNR.vwPartyAddress AS CPA ON O.CustomerPartyAddressRef = CPA.PartyAddressId
	LEFT OUTER JOIN DST.vwPathPartyAddress AS PPA ON O.CustomerPartyAddressRef = PPA.PartyAddressRef
	INNER JOIN SLS.SaleType AS ST ON O.SaleTypeRef = ST.SaleTypeID
	INNER JOIN FMK.[User] as cUsr ON O.Creator = cUsr.UserID
	INNER JOIN FMK.[User] as mUsr ON O.LastModifier = mUsr.UserID
	LEFT OUTER JOIN [DST].Agreement AS DA ON O.AgreementRef = DA.AgreementId