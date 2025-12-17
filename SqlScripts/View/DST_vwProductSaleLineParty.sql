--<<FileName:DST_vwProductSaleLineParty.sql>>--

IF Object_ID('DST.vwProductSaleLineParty') IS NOT NULL
	DROP VIEW DST.vwProductSaleLineParty
GO

CREATE VIEW DST.vwProductSaleLineParty
AS

SELECT						pp.ProductSaleLinePartyId
						,	pp.ProductSaleLineRef
						,	pp.PartyRef
						,	p.DLCode
						,	p.DLTitle
						,	p.DLTitle_En													 
FROM	DST.ProductSaleLineParty pp
		LEFT		JOIN		GNR.vwParty p			ON		pp.PartyRef			=	p.PartyId		
