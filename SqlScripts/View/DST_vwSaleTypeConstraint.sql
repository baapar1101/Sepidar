IF Object_ID('DST.vwSaleTypeConstraint') IS NOT NULL
	DROP VIEW DST.vwSaleTypeConstraint

GO

CREATE VIEW DST.vwSaleTypeConstraint
AS
SELECT 
      C.[SaleTypeConstraintId]
      ,C.[PartyRef]
      ,P.[DLTitle] AS PartyDLTitle
      ,P.[DLTitle_En] AS PartyDLTitle_En
      ,P.[DLCode] AS PartyDLCode
      ,P.[FullName] AS PartyFullName
      ,C.[Version]
      ,C.[Creator]
      ,C.[CreationDate]
      ,C.[LastModifier]
      ,C.[LastModificationDate]
	  ,CU.Name CreatorName
      ,MU.Name LastModifierName

FROM [DST].[SaleTypeConstraint] C
JOIN [GNR].[vwParty] AS P ON C.PartyRef = P.PartyID
INNER JOIN FMk.[User] CU ON C.Creator = CU.UserID
INNER JOIN FMk.[User] MU ON C.LastModifier = MU.UserID
