If Object_ID('ACC.vwAccount') Is Not Null
	Drop View ACC.vwAccount
GO
CREATE VIEW ACC.vwAccount
AS


SELECT 
	AccountId, ParentAccountRef, Type, Code, Title, Title_En, IsActive, CashFlowCategory, OpeningBalance, BalanceType, HasBalanceTypeCheck, HasDL, 
	HasCurrency, HasCurrencyConversion, HasTracking, HasTrackingCheck, Version, Creator, CreationDate, LastModifier, LastModificationDate, 
	CLCode + GLCode AS GLCode,GLTitle_En ,GLTitle, GLRef, CLCode, CLTitle,CLTitle_En, CLRef, CLBalanceType, ParentBalanceType,
	CASE S.Type WHEN 1 THEN Code WHEN 2 THEN CLCode + Code WHEN 3 THEN CLCode + GLCode + Code END AS FullCode, 
	CASE S.Type WHEN 1 THEN Title WHEN 2 THEN CLTitle + ' / ' + Title WHEN 3 THEN CLTitle + ' / ' + GLTitle + ' / ' + Title END AS FullTitle, 
	CASE S.Type WHEN 1 THEN Title_En WHEN 2 THEN CLTitle_En + ' / ' + Title_En WHEN 3 THEN CLTitle_En + ' / ' + GLTitle_En + ' / ' + Title_En END AS FullTitle_En, 
	CASE S.Type WHEN 1 THEN '' WHEN 2 THEN CLCode WHEN 3 THEN CLCode + GLCode END AS ParentFullCode, 
	CASE S.Type WHEN 1 THEN '' WHEN 2 THEN CLTitle WHEN 3 THEN CLTitle + ' / ' + GLTitle END AS ParentFullTitle,
	CASE S.Type WHEN 1 THEN '' WHEN 2 THEN CLTitle_En WHEN 3 THEN CLTitle_En + ' / ' + GLTitle_En END AS ParentFullTitle_En,
    HasAccountTopic,
	ShowInCompanyDashboard,
	ShowInAccountAnalysisReport

FROM 
	(SELECT AccountId, ParentAccountRef, Type, Code, Title, Title_En, IsActive, CashFlowCategory, OpeningBalance, BalanceType, 
		HasBalanceTypeCheck, HasDL, HasCurrency, HasCurrencyConversion, HasTracking, HasTrackingCheck, Version, Creator, CreationDate, 
		LastModifier, LastModificationDate,

		(SELECT Code FROM ACC.Account AS A1 WHERE (A.ParentAccountRef = AccountId) AND (A.Type = 3)) AS GLCode,
		(SELECT Title FROM ACC.Account AS A1 WHERE (A.ParentAccountRef = AccountId) AND (A.Type = 3)) AS GLTitle, 
		(SELECT Title_En FROM ACC.Account AS A1 WHERE (A.ParentAccountRef = AccountId) AND (A.Type = 3)) AS GLTitle_En, 
		CASE Type WHEN 3 THEN ParentAccountRef END AS GLRef, 

		CASE Type	WHEN 2 THEN (SELECT A1.Code FROM ACC.Account A1 WHERE A.ParentAccountRef = A1.AccountId AND A.Type = 2) 
					WHEN 3 THEN (SELECT A2.Code FROM ACC.Account A1 
									JOIN ACC.Account A2 ON A1.ParentAccountRef = A2.AccountId
								 WHERE A.ParentAccountRef = A1.AccountId AND A.Type = 3) END AS CLCode, 
		
		CASE Type	WHEN 2 THEN (SELECT A1.Title FROM ACC.Account A1 WHERE A.ParentAccountRef = A1.AccountId AND A.Type = 2) 
					WHEN 3 THEN (SELECT A2.Title FROM ACC.Account A1 
										JOIN ACC.Account A2 ON A1.ParentAccountRef = A2.AccountId
			  					 WHERE A.ParentAccountRef = A1.AccountId AND A.Type = 3) END AS CLTitle, 

		CASE Type	WHEN 2 THEN (SELECT A1.Title_En FROM ACC.Account A1 WHERE A.ParentAccountRef = A1.AccountId AND A.Type = 2) 
					WHEN 3 THEN (SELECT A2.Title_En FROM ACC.Account A1 
										JOIN ACC.Account A2 ON A1.ParentAccountRef = A2.AccountId
			  					 WHERE A.ParentAccountRef = A1.AccountId AND A.Type = 3) END AS CLTitle_En, 

		CASE Type	WHEN 2 THEN ParentAccountRef 
					WHEN 3 THEN (SELECT A1.ParentAccountRef FROM ACC.Account A1 WHERE A.ParentAccountRef = A1.AccountId) END AS CLRef, 		
		
		CASE Type	WHEN 2 THEN (SELECT A1.BalanceType FROM ACC.Account A1 WHERE A.ParentAccountRef = A1.AccountId AND A.Type = 2) 
					WHEN 3 THEN (SELECT A2.BalanceType FROM ACC.Account A1 
										JOIN ACC.Account A2 ON A1.ParentAccountRef = A2.AccountId
								 WHERE A.ParentAccountRef = A1.AccountId AND A.Type = 3) END AS CLBalanceType,
								 
		CASE Type	WHEN 2 THEN A.BalanceType
					WHEN 3 THEN (SELECT A1.BalanceType FROM ACC.Account A1 WHERE A.ParentAccountRef = A1.AccountId AND A.Type = 3)  END AS ParentBalanceType, 
								 
		CASE WHEN (EXISTS(SELECT 1 FROM Acc.AccountTopic WHERE AccountSLRef = A.AccountId)) THEN 1 ELSE 0 END HasAccountTopic,
		A.ShowInCompanyDashboard,
		A.ShowInAccountAnalysisReport

FROM ACC.Account AS A) AS S


