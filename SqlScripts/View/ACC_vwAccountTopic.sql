If Object_ID('ACC.vwAccountTopic') Is Not Null
	Drop View ACC.vwAccountTopic
GO
CREATE VIEW ACC.vwAccountTopic
AS
SELECT     AT.AccountTopicId, AT.AccountSLRef, AT.TopicRef, ACC.Title AS SLTitle, ACC.Title_En AS SLTitle_En, ACC.CLBalanceType AS SLCLBalanceType, 
                      ACC.FullCode AS SLFullCode, T.Topic,T.Priority,T.IsSystemTopic, T.Category ,(SELECT Title FROM FMK.Lookup WHERE Type='TopicCategory' AND Code=T.Category) CategoryTitle, T.Topic_En, AT.Version, AT.Creator, AT.CreationDate, AT.LastModifier, 
                      AT.LastModificationDate
FROM         ACC.AccountTopic AS AT INNER JOIN
                      ACC.vwAccount AS ACC ON AT.AccountSLRef = ACC.AccountId INNER JOIN
                      ACC.Topic AS T ON AT.TopicRef = T.TopicId
