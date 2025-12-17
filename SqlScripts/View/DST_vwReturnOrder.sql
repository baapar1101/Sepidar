If Object_ID('DST.vwReturnOrder') Is Not Null
	Drop View DST.vwReturnOrder
GO

CREATE VIEW [DST].[vwReturnOrder]
AS
SELECT 
	RO.ReturnOrderID, RO.Number, RO.Date, RO.FiscalYearRef, RO.State,RO.SignatureRef, RO.[Description], RO.[Guid],
	RO.CurrencyRef, C.Title AS CurrencyTitle, C.Title_En AS CurrencyTitle_En, C.PrecisionCount AS CurrencyPrecisionCount,
	RO.CustomerPartyRef, 
		CP.DLRef AS CustomerPartyDLRef, CP.DLCode AS CustomerPartyDLCode, CP.DLTitle AS CustomerPartyName, 
		CP.DLTitle_En AS CustomerPartyName_En, CP.DiscountRate AS CustomerDiscountRate,
		CP.CustomerGroupingRef, CP.CustomerGroupingTitle, CP.DiscountRate AS DiscountOnCustomer,
		CP.IdentificationCode AS CustomerIdentificationCode, CP.EconomicCode AS CustomerEconomicCode, 
		(
			SELECT TOP (1) Phone
            FROM GNR.PartyPhone
            WHERE (CP.PartyId = PartyRef) AND (Type = 1 OR IsMain = 1) ORDER BY IsMain DESC
		) AS CustomerPhone, 
	RO.CustomerPartyAddressRef, 
		CPA.LocationTitle AS CustomerPartyAddressTitle, CPA.LocationTitle_En AS CustomerPartyAddressTitle_En,
		CPA.Address AS CustomerPartyAddress, CPA.Adress_En AS CustomerPartyAddress_En,
		CPA.FullAddress AS CustomerPartyFullAddress, CPA.FullAddress_En AS CustomerPartyFullAddress_En,
		CPA.ZipCode AS CustomerPartyZipCode,
		PPA.PathCode AS CustomerPathCode, PPA.PathTitle AS CustomerPathTitle, PPA.PathTitle_En AS CustomerPathTitle_En,
		PPA.AreaCode AS CustomerAreaCode, PPA.AreaTitle AS CustomerAreaTitle, PPA.AreaTitle_En AS CustomerAreaTitle_En,
	RO.SaleTypeRef, ST.Number AS SaleTypeNumber, ST.Title AS SaleTypeTitle, ST.SaleTypeMarket, ST.Title_En AS SaleTypeTitle_En,
	RO.Price, RO.PriceInBaseCurrency, RO.Discount, RO.DiscountInBaseCurrency, RO.Addition, RO.AdditionInBaseCurrency,
	RO.Tax, RO.TaxInBaseCurrency, RO.Duty, RO.DutyInBaseCurrency, RO.NetPrice, RO.NetPriceInBaseCurrency, RO.Rate,
	RO.AdditionFactor_VatEffective, RO.AdditionFactorInBaseCurrency_VatEffective, RO.AdditionFactor_VatIneffective, RO.AdditionFactorInBaseCurrency_VatIneffective, 
	ISNULL(RO.AdditionFactor_VatEffective, 0) + ISNULL(RO.AdditionFactor_VatIneffective, 0) AS AdditionFactor,
	ISNULL(RO.AdditionFactorInBaseCurrency_VatEffective, 0) + ISNULL(RO.AdditionFactorInBaseCurrency_VatIneffective, 0) AS AdditionFactorInBaseCurrency,
	RO.Version, RO.Creator, cUsr.Name CreatorName, cUsr.Name_En CreatorName_En, 
	RO.LastModifier,	mUsr.Name ModifierName, mUsr.Name_En ModifierName_En,
	RO.CreationDate, RO.LastModificationDate,
	null BillRemainder, null VendorRemainder, null CustomerRemainder

FROM
	[DST].[ReturnOrder] AS RO
	INNER JOIN GNR.Currency AS C ON RO.CurrencyRef = C.CurrencyID
	LEFT OUTER JOIN GNR.vwParty AS CP ON RO.CustomerPartyRef = CP.PartyID
	LEFT OUTER JOIN GNR.vwPartyAddress AS CPA ON RO.CustomerPartyAddressRef = CPA.PartyAddressId
	LEFT OUTER JOIN DST.vwPathPartyAddress AS PPA ON RO.CustomerPartyAddressRef = PPA.PartyAddressRef
	INNER JOIN SLS.SaleType AS ST ON RO.SaleTypeRef = ST.SaleTypeID
	INNER JOIN FMK.[User] as cUsr ON RO.Creator = cUsr.UserID
	INNER JOIN FMK.[User] as mUsr ON RO.LastModifier = mUsr.UserID
