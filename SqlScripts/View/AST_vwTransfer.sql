If Object_ID('AST.vwTransfer') Is Not Null
	Drop View AST.vwTransfer
GO
CREATE VIEW [AST].[vwTransfer]AS 
	SELECT [TransferID]
      ,T.[Number]
      ,T.[Date]
      ,T.[FiscalYearRef]
      ,T.[Description]
      ,T.[Description_En]
      ,T.[Version]
      ,T.[Creator]
      ,T.[CreationDate]
      ,T.[LastModifier]
      ,T.[LastModificationDate]
      ,u.Name AS CreatorName
      ,u.Name_En AS CreatorEn
  FROM [AST].[Transfer] T
  LEFT JOIN FMK.[User] u ON u.UserID = T.Creator 
GO


