If Object_ID('GNR.vwParty') Is Not Null
	Drop View GNR.vwParty
GO
CREATE VIEW GNR.vwParty
AS

SELECT     P.PartyId, P.Type, P.SubType, P.Name, P.Name_En, P.LastName, P.LastName_En, P.EconomicCode, P.RegistrationCode, P.Website, P.Email, P.DLRef, DL.IsActive, DL.Title AS DLTitle, 
                      DL.Title_En AS DLTitle_En, DL.Code AS DLCode, DL.[Type] DLType,P.Name + ' ' + ISNULL(P.LastName, '') AS FullName, P.IsVendor, P.VendorGroupingRef, 
                      P.IsBroker,p.BrokerGroupingRef, P.CommissionRate, P.BrokerOpeningBalance, P.IsPurchasingAgent, P.IsEmployee, P.IsCustomer, P.SalespersonPartyRef,
                      P.DiscountRate, P.MaximumCredit, P.CustomerGroupingRef, P2.Name + ' ' + ISNULL(P2.LastName, '') 
                      AS SalespersonTitle, G1.FullCode AS VendorGroupingCode,G1.Title AS VendorGroupingTitle, G1.Title_En AS VendorGroupingTitle_En, G2.Title AS CustomerGroupingTitle, 
                      G2.Title_En AS CustomerGroupingTitle_En, G2.FullCode CustomerGroupingCode,
                      G3.FullCode AS BrokerGroupingCode ,G3.Title AS BrokerGroupingTitle,G3.Title_En AS BrokerGroupingTitle_En,
                      P.Version, P.Creator, P.CreationDate, P.LastModifier, P.LastModificationDate, P.IdentificationCode, 
                      P.IsInBlacklist, P.BrokerOpeningBalanceType, 
					  P.[MaximumQuantityCredit],P.[HasQuantityCredit],P.[QuantityCreditCheckingType],
					  A.FullAddress, A.FullAddress_En,PPh.Phone, P.CustomerCategoryForTax, P.BirthDate, 
					  P.MarriageDate, P.HasCredit, P.CreditCheckingType, P.CustomerRemaining, P.[Guid],
					  [cUsr].[Name] AS [CreatorName], [cUsr].[Name_En] AS [CreatorName_En],
					  [mUsr].[Name] AS [ModifierName], [mUsr].[Name_En] AS [ModifierName_En],
					  [P].[PassportNumber],
					  (SELECT     TOP (1) Phone
                         FROM         GNR.PartyPhone
                         WHERE     (P.PartyId = PartyRef) AND (Type = 5 OR Type = 6 OR Type = 7)) AS PartyFax
FROM         GNR.Party AS P INNER JOIN
                      ACC.DL AS DL ON P.DLRef = DL.DLId LEFT OUTER JOIN
                      GNR.Party AS P2 ON P.SalespersonPartyRef = P2.PartyId AND P2.IsEmployee = 1 LEFT OUTER JOIN
                      GNR.vwGrouping AS G2 ON P.CustomerGroupingRef = G2.GroupingID LEFT OUTER JOIN
                      GNR.Grouping AS G1 ON P.VendorGroupingRef = G1.GroupingID LEFT OUTER JOIN
                      GNR.vwGrouping AS G3 ON p.BrokerGroupingRef = G3.GroupingID
	LEFT JOIN GNR.vwPartyAddress A ON P.PartyId = A.PartyRef AND A.IsMain = 1
	LEFT JOIN GNR.PartyPhone PPh ON P.PartyId = PPh.PartyRef AND PPh.IsMain = 1
	LEFT JOIN [FMK].[User] AS [cUsr] ON [P].[Creator] = [cUsr].[UserID]
	LEFT JOIN [FMK].[User] AS [mUsr] ON [P].[LastModifier] = [mUsr].[UserID]
