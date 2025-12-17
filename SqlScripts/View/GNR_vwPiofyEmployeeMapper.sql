IF OBJECT_ID('GNR.vwPiofyEmployeeMapper') IS NOT NULL
	DROP VIEW GNR.vwPiofyEmployeeMapper
GO
CREATE VIEW GNR.vwPiofyEmployeeMapper
AS
	SELECT
		PEM.PiofyEmployeeMapperID
		, PEM.PersonnelRef
		, P.DLCode PersonnelCode
		, P.DLTitle PersonnelDLTitle
		, P.DLTitle_En PesonnelDLTitle_En
		, P.FirstName PersonnelFirstName
		, P.FirstName_En PersonnelFirstName_En
		, P.LastName PersonnelLastName
		, P.LastName_En PersonnelLastName_En
		, PEM.PiofyEmployeeID
		, PEM.PiofyEmploymentType
		, PEM.Version
		, PEM.Creator
		, PEM.CreationDate
		, PEM.LastModifier
		, PEM.LastModificationDate
	FROM GNR.PiofyEmployeeMapper PEM
		 LEFT JOIN PAY.vwPersonnel P on PEM.PersonnelRef = P.PersonnelId

 


 