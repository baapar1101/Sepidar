IF OBJECT_ID('MSG.vwOutgoingMessage') IS NOT NULL
	DROP VIEW MSG.vwOutgoingMessage
GO
CREATE VIEW [MSG].[vwOutgoingMessage]
AS
SELECT  [OutgoingMessageID],[Text],[Date],[SenderNumber],[ReceiverNumber], MC.[ContactName] ReceiverName,
		[State],[TrackingID],[MessageContactRef],[Description],[Version],[Creator],[CreationDate],
		[LastModifier],[LastModificationDate]
FROM  MSG.[OutgoingMessage] O
	INNER JOIN MSG.vwMessageContact MC ON O.MessageContactRef = MC.MessageContactID