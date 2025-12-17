IF OBJECT_ID('MSG.vwCustomContactPhone') Is Not Null
	DROP VIEW MSG.vwCustomContactPhone
GO
CREATE VIEW MSG.vwCustomContactPhone
AS
SELECT CCP.CustomContactPhoneId, CCP.CustomContactRef, CCP.Phone, CCP.IsMain
FROM MSG.CustomContactPhone AS CCP