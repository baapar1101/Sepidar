--<<FileName:GNR_vwDevice.sql>>--

IF Object_ID('GNR.vwDevice') IS NOT NULL
	Drop View GNR.vwDevice
GO

CREATE VIEW GNR.vwDevice
AS
SELECT
	D.[DeviceId]
	, D.[DeviceType]
	, D.[Title]
	, D.[Title_En]
	, D.[Code]
	, D.[Key]
	, D.[TempKey]
	, D.[IntegrationId]
	, D.[IsRegistered]
	, D.[IsActive]
	, D.[Version]
	, D.[Creator]
	, D.[CreationDate]
	, D.[LastModifier]
	, D.[LastModificationDate]
	,CU.Name CreatorName
    ,MU.Name LastModifierName
FROM
	GNR.Device AS D
	   INNER JOIN FMk.[User] CU ON D.Creator = CU.UserID
   INNER JOIN FMk.[User] MU ON D.LastModifier = MU.UserID