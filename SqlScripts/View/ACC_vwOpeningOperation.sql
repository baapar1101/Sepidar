If Object_ID('ACC.vwOpeningOperation') Is Not Null
	Drop View ACC.vwOpeningOperation
GO
CREATE VIEW ACC.vwOpeningOperation
AS

SELECT     OO.OpeningOperationId, OO.Date, OO.AccountSLRef, OO.VoucherRef, OO.Description, OO.Description_En, OO.Version, OO.Creator, OO.CreationDate, 
                      OO.LastModifier, OO.LastModificationDate, AC.FullCode AS SLCode, AC.Title AS SLTitle, AC.Title_En AS SLTitle_En
FROM         ACC.OpeningOperation AS OO LEFT OUTER JOIN
                      ACC.vwAccount AS AC ON AC.AccountId = OO.AccountSLRef LEFT OUTER JOIN
                      ACC.Voucher AS V ON OO.VoucherRef = V.VoucherId
                      
