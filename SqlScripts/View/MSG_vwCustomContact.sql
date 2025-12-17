If Object_ID('MSG.vwCustomContact') Is Not Null
	Drop View MSG.vwCustomContact
GO
CREATE VIEW MSG.vwCustomContact
AS
SELECT     CC.CustomContactId , CC.FullName, CC.MarriageDate, CC.BirthDate,
		   CC.Version, CC.Creator, CC.CreationDate, CC.LastModifier, CC.LastModificationDate,
           (SELECT TOP 1 CCP.Phone FROM MSG.CustomContactPhone CCP WHERE  CCP.CustomContactRef = CC.CustomContactId AND CCP.IsMain = 1) AS [Phone]
FROM         MSG.CustomContact AS CC