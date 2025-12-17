IF OBJECT_ID('GNR.vwCommunication') IS NOT NULL
	DROP VIEW GNR.vwCommunication
GO
CREATE VIEW [GNR].[vwCommunication]
AS
SELECT
	[c].[CommunicationId]
   ,[c].[System]
   ,[c].[Method]
   ,[c].[RequestUrl]
   ,[c].[RequestHttpMethod]
   ,[c].[RequestBody]
   ,[c].[UniqueId]
   ,[c].[SendingState]
   ,[c].[NumberOfAttempts]
   ,[c].[LastAttemptTime]
   ,[c].[ResponseStatusCode]
   ,[c].[ResponseRawText]
   ,[c].[ErrorMessage]
   ,[c].[Version]
   ,[c].[Creator]
   ,[c].[CreationDate]
   ,[c].[LastModifier]
   ,[c].[LastModificationDate]
FROM GNR.Communication c