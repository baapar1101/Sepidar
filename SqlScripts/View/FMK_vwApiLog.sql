IF Object_ID('FMK.vwApiLog') IS NOT NULL
	DROP VIEW FMK.vwApiLog
GO

CREATE VIEW FMK.vwApiLog
AS

SELECT 
	[AL].[ApiLogID]
   ,[AL].[RequestTime]
   ,[AL].[RequestUrl]
   ,[AL].[RequestUserHostAddress]
   ,[AL].[RequestHeaders]
   ,[AL].[RequestMethod]
   ,[AL].[RequestBody]
   ,[AL].[Guid]
   ,[AL].[UserRef]
   ,[AL].[DeviceRef]
   ,[AL].[OriginalResource]
   ,[AL].[ResponseTime]
   ,[AL].[ResponseRawText]
   ,[AL].[ResponseStatusCode]
   ,[AL].[UserName]
   ,[AL].[UserName_En]
   ,[AL].[UserUserName]
   ,[AL].[DeviceTitle]
   ,[AL].[DeviceTitle_En]
   ,[AL].[DeviceCode]
FROM 
	FMK.ApiLog AS AL