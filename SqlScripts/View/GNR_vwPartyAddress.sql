If Object_ID('GNR.vwPartyAddress') Is Not Null
	Drop View GNR.vwPartyAddress
GO
CREATE VIEW GNR.vwPartyAddress
AS
SELECT
	PA.PartyAddressId
	,PA.PartyRef
	,L.Title_En AS LocationTitle_En
	,L.Title AS LocationTitle
	,PA.IsMain
	,PA.Version
	,PA.Adress_En
	,PA.LocationRef
	,PA.ZipCode
	,PA.BranchCode
	,PA.Address
	,PA.Type
	,PA.Latitude
	,PA.Longitude
	,ISNULL(L.Title, '') + ', '+ PA.Address FullAddress
	,ISNULL(L.Title_En, '') + ', '+ PA.Adress_En FullAddress_En
	,LL.State AS LocationState
	,LL.State_En AS LocationState_En
	,PA.Title, PA.Guid
	,PPA.AreaAndPathRef -- its not acually a Ref
	,AAndP.AreaCode
	,AAndP.AreaTitle
	,AAndP.FullCode AS PathCode
	,AAndP.Title AS PathTitle
	,AAndP.AreaTitle_En
	,AAndP.Title_En AS PathTitle_En
FROM
	GNR.PartyAddress AS PA 
	LEFT OUTER JOIN	GNR.Location AS L 
		ON PA.LocationRef = L.LocationId 
	LEFT JOIN GNR.vwLocationList AS LL
		ON PA.LocationRef = LL.LocationId
	LEFT JOIN DST.PathPartyAddress AS PPA
		ON PPA.PartyAddressRef = PA.PartyAddressId
	LEFT JOIN DST.vwAreaAndPath AS AAndP
		ON PPA.AreaAndPathRef = AAndP.AreaAndPathId