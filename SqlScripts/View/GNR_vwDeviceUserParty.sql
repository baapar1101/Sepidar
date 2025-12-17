IF OBJECT_ID('GNR.vwDeviceUserParty') IS NOT NULL
	DROP VIEW GNR.vwDeviceUserParty
GO

CREATE VIEW GNR.vwDeviceUserParty
AS
SELECT
	[DUP].[DeviceUserPartyId]
   ,[DUP].[DeviceRef]
   ,[DUP].[UserRef]
   ,[U].[UserName]
   ,[DUP].[PartyRef]
   ,[P].[DLTitle]		AS [PartyDLTitle]
   ,[P].[DLTitle_En]	AS [PartyDLTitle_En]
   ,[P].[DLCode] 		AS [PartyDLCode]
   ,[DUP].[Version]
FROM GNR.[DeviceUserParty] AS [DUP]
LEFT JOIN GNR.vwParty AS P
	ON [DUP].PartyRef = P.PartyId
INNER JOIN FMK.vwUser AS U
	ON [DUP].UserRef = U.UserID
