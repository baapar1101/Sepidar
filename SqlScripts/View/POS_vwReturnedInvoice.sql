If Object_ID('POS.vwReturnedInvoice') Is Not Null
	Drop View POS.vwReturnedInvoice
GO
Create VIEW [POS].[vwReturnedInvoice]
AS
SELECT     I.ReturnedInvoiceId, C.Title CashierTitle, CashierRef, C.PartyRef CustomerPartyRef, C.PartyFullName AS CustomerPartyFullName, ST.Title AS SaleTypeTitle, 
                      I.CustomerRealName, I.CustomerRealName_En, ST.Title_En AS SaleTypeTitle_En, I.SaleTypeRef, 
                      I.Description, I.Description_En, I.StockRef, S.Title AS StockTitle, S.Title_En AS StockTitle_En, 
                      S.Code StockCode, I.Number, I.Date, I.CurrencyRef, Crr.Title AS CurrencyTitle, 
                      Crr.Title_En AS CurrencyTitle_En, I.State, I.Price, I.Discount, I.InvoiceDiscount, 
                      I.Addition, I.Tax, I.Duty, I.NetPrice, I.Version, I.Creator, I.CreationDate, 
                      I.LastModifier, I.LastModificationDate, I.FiscalYearRef, I.CashAmount, I.CardReaderAmount, 
                      I.PosRef, I.TransactionNumber, I.ChequeAmount, I.ChequeSecondaryNumber, I.OtherAmount, 
                      I.OtherDescription, I.CashPaidAmount, P.TerminalNo AS PosTerminalNo, C.UserName AS UserName, 
				 	  C.CanChangeDiscount CashierCanChangeDiscount,
					  C.CanReceiveCash CashierCanReceiveCash,
				      C.CanReceiveCheque CashierCanReceiveCheque,
					  C.CanReceivePos CashierCanReceivePos,
					  C.CanReceiveOther CashierCanReceiveOther
FROM         POS.ReturnedInvoice I INNER JOIN
                      INV.Stock S ON I.StockRef = S.StockID INNER JOIN
                      SLS.SaleType ST ON I.SaleTypeRef = ST.SaleTypeId LEFT JOIN
                      POS.[vwCashier] C ON I.Creator = C.UserRef INNER JOIN
                      GNR.Currency Crr ON I.CurrencyRef = Crr.CurrencyID LEFT JOIN 
                      RPA.Pos P ON I.PosRef = P.PosId
