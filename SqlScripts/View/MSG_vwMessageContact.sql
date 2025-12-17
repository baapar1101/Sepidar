IF OBJECT_ID('MSG.vwMessageContact') IS NOT NULL
	DROP VIEW MSG.vwMessageContact
GO

CREATE VIEW [MSG].[vwMessageContact]
AS
SELECT  MC.MessageContactID, MC.MessageRef, MC.Phone, MC.ContactPhoneRef, MC.ContactType,
		Contacts.FullName ContactName
FROM  MSG.[MessageContact] MC
	LEFT JOIN
		(SELECT PPH.PartyPhoneId ContactPhoneRef, P.Name + ' ' + ISNULL(P.LastName, '') AS FullName, 1 ContactType
		 FROM GNR.PartyPhone PPH
			INNEr JOIN GNR.Party P ON PPH.PartyRef = P.PartyId
		 UNION ALL
		 SELECT UPH.UserPhoneId ContactPhoneRef, U.Name, 2 ContactType
		 FROM FMK.UserPhone UPH
			INNER JOIN FMK.[User] U ON UPH.UserRef = U.UserID
		 UNION ALL
		 SELECT CCPH.CustomContactPhoneId ContactPhoneRef, CC.FullName, 3 ContactType
		 FROM MSG.CustomContactPhone CCPH
			INNER JOIN MSG.CustomContact CC ON CCPH.CustomContactRef = CC.CustomContactId
		 ) Contacts ON MC.ContactType = Contacts.ContactType AND MC.ContactPhoneRef = Contacts.ContactPhoneRef
