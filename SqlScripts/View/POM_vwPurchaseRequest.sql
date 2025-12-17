If Object_ID('pom.vwPurchaseRequest') Is Not Null
	Drop View pom.vwPurchaseRequest
GO

CREATE VIEW [POM].[vwPurchaseRequest]
AS

SELECT
    [PurchaseRequestID],
	PR.[FiscalYearRef],

	PR.[StockRef] ,
	Stock.Code AS StockCode, Stock.Title AS StockTitle, Stock.Title_En AS StockTitle_En,
	PR.[RequesterDepartmentDLRef] ,
	DepartmentDL.Code AS RequesterDepartmentDlCode, DepartmentDL.Title AS RequesterDepartmentDlTitle, DepartmentDL.Title_En AS RequesterDepartmentDlTitle_En,
	PR.[RequesterDLRef] ,
	RequesterDL.Code AS RequesterDlCode, RequesterDL.Title AS RequesterDlTitle, RequesterDL.Title_En AS RequesterDlTitle_En,
	UC.Name AS CreatorTitle, ULM.Name AS LastModifierTitle, UA.Name AS LastAcceptorTitle,
	[PurchasingAgentPartyRef],
	Agent.DlCode AS PurchasingAgentDlCode, Agent.DlTitle AS PurchasingAgentDlTitle, Agent.DlTitle_En AS PurchasingAgentDlTitle_En,
	[PurchasingProcedure],
	[ItemRequestRef],
	IR.[Number] AS ItemRequestNumber,
	PR.[Number] ,
	PR.[Date] ,
	PR.[State] ,
	PR.[Description],
	PR.[Creator],
	PR.[CreationDate] ,
	PR.[LastModifier] ,
	PR.[LastModificationDate] ,
	PR.[LastAcceptDate] ,
	PR.[LastAcceptor] ,
	PR.[Version] ,
    IR.StockRef AS ItemRequestStockRef

   FROM POM.PurchaseRequest PR
  LEFT JOIN aCC.DL DepartmentDL ON PR.RequesterDepartmentDLRef = DepartmentDL.DLId
  LEFT JOIN aCC.DL RequesterDL ON PR.RequesterDLRef = RequesterDL.DLId

  LEFT JOIN INV.Stock Stock ON PR.StockRef = Stock.StockID
  LEFT OUTER JOIN 	  GNR.[vwParty] AS Agent ON PR.[PurchasingAgentPartyRef] = Agent.PartyID
  LEFT OUTER JOIN 	  POM.[ItemRequest] AS IR ON PR.[ItemRequestRef] = IR.ItemRequestID

  LEFT OUTER JOIN 	  FMK.[User] AS UC ON PR.Creator = UC.UserID
  LEFT OUTER JOIN	  FMK.[User] AS ULM ON PR.LastModifier = ULM.UserID
  LEFT OUTER JOIN	  FMK.[User] AS UA ON PR.LastAcceptor = UA.UserID


