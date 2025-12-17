if exists(select 1 from sys.views where name='vwSale' and type='v')
BEGIN
DROP VIEW [AST].vwSale	
END


GO

CREATE VIEW [AST].vwSale
As
SELECT   s.SaleID
		,s.Number
		,s.[Date]
		,s.PartyRef
		,s.[PartyAddressRef]
		,p.DLCode AS PartyDLCode
		,s.VoucherRef
		,p.DLTitle AS PartyName
		,p.DLTitle_En AS PartyTitle_En
		,p.DLRef AS PartyDLRef
		,p.IdentificationCode AS CustomerIdentificationCode
		,p.PassportNumber AS CustomerPassportNumber
		,p.EconomicCode AS CustomerEconomicCode
		,s.CurrencyRef
		,c.Title AS CurrencyTitle
		,c.Title_En AS CurrencyTitle_En
		, C.PrecisionCount AS CurrencyPrecisionCount
		,s.FiscalYearRef
		,fy.Title AS FiscalYearTitle
		,s.CurrencyRate
		,s.SLAccountRef
		,a.FullCode AS SLAccountCode
		,a.Title AS SLAccountTitle
		,a.Title_En AS SLAccountTitle_En
		,u.Name AS CreatorName
		,u.Name_En AS CreatorName_En
		,CASE
			WHEN	s.VoucherRef IS NOT NULL THEN 1 ELSE 0		
		END AS HasVoucher		
		,v.Number AS VoucherNumber
		,v.[Date] AS [VoucherDate]
		,s.[Description]
		,s.[Description_En]
		,s.[Version]
		,s.Creator
		,s.CreationDate
		,s.LastModifier
		,s.LastModificationDate
		,s.IsRevoked
		,s.TaxPayerBillIssueDateTime
		,s.SettlementType
		, [PA].[Address]
		, [PA].[Title] AS [AddressTitle]
		, [PA].[ZipCode] AS [AddressZipCode]
		, [PA].[BranchCode] AS [CustomerBranchCode]
 		, CASE
			WHEN MainTPB.AssetSaleRef IS NULL THEN 0
            ELSE 1
			END AS HasSendedMainBill 
		 FROM AST.Sale AS s
		 LEFT JOIN gnr.vwParty AS p ON p.PartyId = s.PartyRef
		 LEFT JOIN gnr.[vwPartyAddress] AS PA ON PA.[PartyAddressId] = S.[PartyAddressRef]
		 LEFT JOIN gnr.Currency AS c ON c.CurrencyID = s.CurrencyRef
		 LEFT JOIN fmk.FiscalYear AS fy ON fy.FiscalYearId = s.FiscalYearRef
		 LEFT JOIN acc.vwAccount AS a ON a.AccountId = s.SLAccountRef
		 LEFT JOIN acc.Voucher AS v ON v.VoucherId = s.VoucherRef
		 LEFT JOIN FMK.[User] AS u ON u.UserID = s.Creator
		 LEFT JOIN (
		    SELECT
		        AssetSaleRef
		    FROM GNR.TaxPayerBill
		    WHERE ActionTypeIns = 1
		      AND [State] = 4
		      AND AssetSaleRef IS NOT NULL
		    GROUP BY
		        AssetSaleRef
        ) AS MainTPB ON s.SaleID = MainTPB.AssetSaleRef