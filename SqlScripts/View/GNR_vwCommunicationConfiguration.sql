IF OBJECT_ID('GNR.vwCommunicationConfiguration') IS NOT NULL
	DROP VIEW GNR.vwCommunicationConfiguration
GO

CREATE VIEW GNR.vwCommunicationConfiguration
AS

SELECT
	[CC].[CommunicationConfigurationID]
   ,[CC].[System]
   ,[CC].[Key]
   ,[CC].[Value]
   ,[CC].[Version]
FROM [GNR].[CommunicationConfiguration] AS [CC]