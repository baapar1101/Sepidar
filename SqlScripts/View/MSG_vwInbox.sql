IF OBJECT_ID('MSG.vwInbox') IS NOT NULL
	DROP VIEW MSG.vwInbox
GO
CREATE VIEW [MSG].[vwInbox]
AS
SELECT  InboxID, [Text],[Date],	SenderNumber,ReceiverNumber,
		ContactPhoneRef,ContactType,'' ContactName,
		[Version],Creator,CreationDate,LastModifier,LastModificationDate
FROM  MSG.[Inbox]