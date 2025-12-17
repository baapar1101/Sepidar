 If Object_ID('GNR.vwEstablishmentCommunication') Is Not Null
	Drop View GNR.vwEstablishmentCommunication
GO
 CREATE VIEW [GNR].[vwEstablishmentCommunication]
AS
SELECT
		c.EstablishmentCommunicationId
		, c.EntityCode
		, c.EntityName
		, c.[Version]   
		, c.Creator
		, c.CreationDate
		, c.LastModifier
		, c.LastModificationDate
 FROM GNR.EstablishmentCommunication c
					  

GO


